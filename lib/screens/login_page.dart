//import 'dart:io';
import 'package:app_uno/screens/admin_profile.dart';
import 'package:app_uno/screens/faculty_profile.dart';
import 'package:app_uno/screens/profile_page.dart';
import 'package:flutter/material.dart';

import '../db/sqlhelper.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailRead = TextEditingController();
  final TextEditingController _passRead = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailRead.dispose();
    _passRead.dispose();
  }

  // Function to handle login button press
  void _onLoginButtonPressed() async {
    final String email = _emailRead.text.trim();
    final String password = _passRead.text.trim();

    // Call the SQLHelper to get user details based on the entered username/email
    final bool isAuthenticated =
        await SQLHelper.authenticateUser(email, password);

    if (isAuthenticated) {
      // User found, verify password
      // final String storedPassword = userDetails['password'];

      final userDetails = await SQLHelper.getUserDetailsEmail(email);
      if (userDetails != null) {
        final String username = userDetails['username'];
        final int id = userDetails['id'];
        // Use the user details as needed
        if (id > 10) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(username: username)),
          );
        } else if (id < 10 && id > 2) {
          print("HEYYO THIS IS YOUR username $username");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FacultyProfilePage(username: username)),
          );
        } else {
          print("HEYYO THIS IS YOUR username $username");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminProfilePage(username: username)),
          );
        }
      } else {
        print('User not found');
      }

      // Invalid password, show an error message
      // (You can use a SnackBar or showDialog to show the message)
      _showErrorMessage("Invalid password");
    } else {
      // User not found, show an error message
      _showErrorMessage("Authentication failed");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login.png'),
                      fit: BoxFit.cover),
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
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                                child: TextField(
                                  controller: _emailRead,
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
                              Image.asset('assets/fields/password.png'),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                                child: TextField(
                                  controller: _passRead,
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
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          '/'); // Add your button logic here
                                    },
                                    child: Text(
                                      'Forgot password?',
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _onLoginButtonPressed();

                                  // Use the signInWithEmailAndPassword method to authenticate the user
                                  /*FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  )
                                      .then((userCredential) {
                                    // Login successful, navigate to the profile page or perform any other necessary actions
                                    Navigator.pushNamed(context, '/profile');
                                  }).catchError((error) {
                                    // Login failed, display an error message to the user
                                    print("Login error: $error");
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Login Error'),
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
                                  });*/ // Handle button press
                                },
                                child: Container(
                                  width: 114.26,
                                  height: 31.17,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 27.59),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD6F0FF),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.43,
                                          color: Color(0xFF413D4B)),
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
                                      'Login',
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      '/signup'); // Handle button press
                                },
                                child: Container(
                                  width: 113,
                                  height: 31,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 27.59),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFE9D7DA),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.43,
                                          color: Color(0xFF413D4B)),
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
                            ],
                          ),
                          /*SizedBox(height: 20),
                          Center(
                            child: Text("Or",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ),*/
                          /*SizedBox(height: 20),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              print(
                                  "tapped on container"); // Handle button press
                            },
                            child: Container(
                              width: 203,
                              height: 29,
                              padding:
                                  const EdgeInsets.only(left: 9.83, right: 32),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Color(0xFFDCD5F9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.87),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x7F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 21.17,
                                    height: 21.17,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFDCD5F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.70),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/googleico.svg',
                                      width: 21.17,
                                      height: 21.17,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Login with Google',
                                    style: TextStyle(
                                      color: Color(0xFF413D4B),
                                      fontSize: 15,
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.w400,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),*/
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
