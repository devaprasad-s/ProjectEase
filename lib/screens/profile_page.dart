import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../db/sqlhelper.dart';
import 'addproject_page.dart';
import 'projectdesc_page.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  ProfilePage({required this.username});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  File? _image;
  String? enteredName;
  String? selectedSemester;
  String? email;
  String? phoneNumber;
  bool showTextField = true;
  bool editingMode = false;
  bool displayButton = false;
  String projectName = '';
  late String username;

  @override
  void initState() {
    super.initState();
    // Assign the username from the widget parameter to the local variable
    fetchUserDetails(widget.username);
  }

  Future<void> fetchUserDetails(String username) async {
    final userDetails = await SQLHelper.getUserDetails(username);

    if (userDetails != null) {
      final String email = userDetails['email'];
      final String phone = userDetails['phno'];
      _userController.text = username;
      _emailController.text = email;
      _phoneController.text = phone;
      final int? groupno = userDetails['groupno'];

      final projectDetails = await SQLHelper.getProjectDetails(groupno!);
      if (projectDetails != null) {
        final String projname = projectDetails['projname'];
        print('PROJJJJJNAME $projname');
        displayButton = true;
        setState(() {
          projectName = projname;
        });
      }
      // Use the user details as needed
      print('Email: $email');
      print('Phone: $phone');
    } else {
      print('User not found');
    }
  }

  _navigateToAddProject(BuildContext context) async {
    print('HEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY');
    print(widget.username);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProjectPage(
            username: _userController.text, semester: selectedSemester!),
      ),
    );

    // Handle the result returned from Page B
    if (result != null) {
      // Assign the result to the variable
      displayButton = true;
      setState(() {
        projectName = result;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void updateSemester(String? value) {
    setState(() {
      selectedSemester = value;
    });
  }

  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void updatePhoneNumber(String value) {
    setState(() {
      phoneNumber = value;
    });
  }

  void updateEnteredName(String value) {
    setState(() {
      enteredName = value;
    });
  }

  void hideTextField() {
    setState(() {
      showTextField = false;
    });
  }

  void toggleEditingMode() {
    setState(() {
      editingMode = !editingMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Profile'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Choose an image'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Text('Camera'),
                                            onTap: () {
                                              _pickImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                            child: Text('Gallery'),
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: _image != null
                                      ? FileImage(_image!)
                                      : AssetImage(
                                          'assets/images/pexels-photo-771742.jpeg',
                                        ) as ImageProvider<Object>,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          editingMode
                              ? SizedBox(
                                  height: 40,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onChanged: updateEnteredName,
                                    onEditingComplete: toggleEditingMode,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      enteredName ?? widget.username,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: toggleEditingMode,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          'Semester',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 26),
                        //Spacer(),
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: DropdownButton(
                                iconSize: 20,
                                value: selectedSemester,
                                isExpanded: true,
                                onChanged: updateSemester,
                                items: [
                                  'S1',
                                  'S2',
                                  'S3',
                                  'S4',
                                  'S5',
                                  'S6',
                                  'S7',
                                  'S8'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Email ID',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 36),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 0, 16, 0 //vertical: 8
                                      ), // Adjust the vertical padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: updateEmail,
                            controller: _emailController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Phone No',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 26,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number',
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: updatePhoneNumber,
                            controller: _phoneController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      top: 420,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (selectedSemester != null) {
                            _navigateToAddProject(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Please select a semester."),
                                  actions: [
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 140,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFFB0D3F4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.black),
                              SizedBox(width: 8),
                              if (displayButton)
                                Text(
                                  'Edit Project',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              if (!displayButton)
                                Text(
                                  'Add Project',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (displayButton)
                      // Only display the button if displayButton is true
                      Positioned(
                        top: 420,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetailsPage(
                                      username: widget.username,
                                      projectName: projectName),
                                ),
                              ); // Perform the action on button click
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD1DEFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      projectName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    color:
                                        Colors.blueGrey) // Add the arrow icon
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
