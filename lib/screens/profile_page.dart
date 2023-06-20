import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'addproject_page.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  ProfilePage({required this.username});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  File? _image;
  String? enteredName;
  String? selectedSemester;
  String? email;
  String? phoneNumber;
  bool showTextField = true;
  bool editingMode = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      await uploadImageToFirebaseStorage(_image!);
    }
  }

  Future<void> uploadImageToFirebaseStorage(File image) async {
    try {
      String a = widget.username;
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('$a/profilepic.jpg');

      firebase_storage.UploadTask uploadTask = storageRef.putFile(image);

      // You can optionally listen to the upload progress
      uploadTask.snapshotEvents
          .listen((firebase_storage.TaskSnapshot snapshot) {
        print(
            'Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      });

      // Wait for the upload to complete
      await uploadTask;

      print('Image uploaded successfully.');

      // Retrieve the download URL
      String downloadURL = await storageRef.getDownloadURL();
      print('Download URL: $downloadURL');

      // You can perform further operations with the downloadURL, such as storing it in a database.
    } catch (e) {
      print('Image upload error: $e');
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 12,
                right: 12,
                child: SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD1DEFF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              // Add your menu button functionality here
                            },
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
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
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(
                              'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg',
                            ) as ImageProvider<Object>,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 84,
                right: 84,
                child: editingMode
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
                            enteredName ?? '',
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
              ),
              Positioned(
                top: 330,
                left: 20,
                child: Text(
                  'Semester',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 320,
                left: 120,
                right: 84,
                child: SizedBox(
                  height: 40,
                  child: DropdownButtonFormField<String>(
                    value: selectedSemester,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: updateSemester,
                    items: ['S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Positioned(
                top: 390,
                left: 20,
                child: Text(
                  'Email ID',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 380,
                left: 120,
                right: 44,
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onChanged: updateEmail,
                    controller: TextEditingController(text: 'Dev@gmail.com'),
                  ),
                ),
              ),
              Positioned(
                top: 450,
                left: 20,
                child: Text(
                  'Phone No',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 440,
                left: 120,
                right: 44,
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onChanged: updatePhoneNumber,
                  ),
                ),
              ),
              Positioned(
                top: 500,
                left: 20,
                child: Text(
                  'Your Projects',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Positioned(
                top: 540,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    if (selectedSemester != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProjectPage(
                            semester: selectedSemester!,
                          ),
                        ),
                      );
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFB0D3F4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Colors.black),
                        SizedBox(width: 8),
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
            ],
          ),
        ),
      ),
    );
  }
}
