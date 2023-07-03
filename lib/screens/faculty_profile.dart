import 'dart:io';
import 'package:app_uno/screens/faculty_viewproject.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'addproject_page.dart';
import 'projectdesc_page.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';

class FacultyProfilePage extends StatefulWidget {
  final String username;
  FacultyProfilePage({required this.username});
  @override
  FacultyProfilePageState createState() => FacultyProfilePageState();
}

class FacultyProfilePageState extends State<FacultyProfilePage> {
  File? _image;
  String? enteredName;
  String? selectedSemester;
  String? email;
  String? phoneNumber;
  bool showTextField = true;
  bool editingMode = false;
  bool displayButton = false;
  String projectName = '';

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

  void recordDetails(String? selectedSemester, String username) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.username)
        .set({'semester': selectedSemester}).then((value) {
      print("Success");
    }).catchError((error) {
      print("Failed  $error");
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.username)
        .set({'semester': selectedSemester}).then((value) {
      print("Success");
    }).catchError((error) {
      print("Failed  $error");
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.username)
        .set({'semester': selectedSemester}).then((value) {
      print("Success");
    }).catchError((error) {
      print("Failed  $error");
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
                                      : NetworkImage(
                                          'https://th.bing.com/th/id/R.974957d202f671e4fa6700c04e68deae?rik=1qiPKP50jb%2bb%2bQ&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2fd%2fd3%2fAlbert_Einstein_Head.jpg&ehk=ylDVIswxD12RU7CpoGhl4Zst21bEvKeKPOCz3o0%2fbRw%3d&risl=1&pid=ImgRaw&r=0',
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
                        ],
                      ),
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
                            controller:
                                TextEditingController(text: 'Dev@gmail.com'),
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FacultyProViewPage()));
                          },
                          child: SizedBox(
                            width: 370,
                            height: 94,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFFF7FAF9),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Text(
                                        'Mini Project',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF0007B7)),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Project Name',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(children: [
                                              Text("View"),
                                              Icon(Icons
                                                  .arrow_forward_ios_outlined)
                                            ]))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Group (No)',
                                          style: TextStyle(
                                              color: Color(0xFF3F4949)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*if (!displayButton)
                      Positioned(
                        top: 420,
                        left: 20,
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
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
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
                      )
                    else
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
                      )*/
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
