import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_page.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailRead;
  final TextEditingController passRead;
  final TextEditingController userRead;

  void recordUsername(String username, String email) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(username)
        .set({'email': email}).then((value) {
      print("Username and Email recorded in Firestore");
    }).catchError((error) {
      print("Failed to record username: $error");
    });
  }

  SignupPage(
      {required this.emailRead,
      required this.passRead,
      required this.userRead});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 41.2,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Project',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Ultralight',
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Ease',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Medium',
                                color: Color(0xFF5F1FC7)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Stack(
                      children: [
                        Image.asset('assets/fields/email.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            controller: emailRead,
                            decoration: InputDecoration(
                              hintText: 'eg:johndoe@gmail.com',
                              fillColor: Colors.transparent,
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/fields/username.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            controller: userRead,
                            decoration: InputDecoration(
                              hintText: 'eg:JohnDoe',
                              fillColor: Colors.transparent,
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/fields/password.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            controller: passRead,
                            decoration: InputDecoration(
                              hintText: '***********',
                              fillColor: Colors.transparent,
                              filled: true,
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/fields/confirmpass.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '***********',
                              fillColor: Colors.transparent,
                              filled: true,
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      '/'); // Add your button logic here
                                },
                                child: Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          String email = emailRead.text;
                          String password = passRead.text;
                          String username = userRead.text;
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          )
                              .then((userCredential) {
                            // Registration successful, record the username in Firestore
                            recordUsername(username, email);

                            // Navigate to the profile page or perform any other necessary actions
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(username: username),
                              ),
                            );
                          }).catchError((error) {
                            // Registration failed, display an error message to the user
                            print("Registration error: $error");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Registration Error'),
                                  content: Text(error.toString()),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        child: Container(
                          width: 113,
                          height: 31,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 27.59),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE9D7DA),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.43, color: Color(0xFF413D4B)),
                              borderRadius: BorderRadius.circular(6.90),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0xAF000000),
                                blurRadius: 3.45,
                                offset: Offset(1.72, 1.72),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFF413D4B),
                                fontSize: 14,
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
