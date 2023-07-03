import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../db/sqlhelper.dart';
import 'profile_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailRead = TextEditingController();
  final TextEditingController _passRead = TextEditingController();
  final TextEditingController _userRead = TextEditingController();
  final TextEditingController _phoneRead = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  @override
  void dispose() {
    super.dispose();
    _emailRead.dispose();
    _passRead.dispose();
    _userRead.dispose();
    _phoneRead.dispose();
    _confirmPass.dispose();
  }

  Future<void> saveUserDetails(
      String username, String email, String password, String phoneno) async {
    if (username.trim() == "" ||
        email.trim() == "" ||
        password.trim() == "" ||
        phoneno.trim() == "") {
      showSnackbar("Enter all the fields");
    } else {
      final existingUsers = await SQLHelper.userAlreadyFound(username, email);
      if (existingUsers.isNotEmpty) {
        // User already exists
        showSnackbar('User already exists');
      } else {
        await SQLHelper.addUserDetails(username, email, password, phoneno);
        // You can perform any additional actions after saving the user details
        // For example, navigate to the profile page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              username: username,
            ),
          ),
        );
      }
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
                        Image.asset('assets/fields/username.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            controller: _userRead,
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
                            controller: _confirmPass,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/fields/phoneno.png'),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _phoneRead,
                            decoration: InputDecoration(
                              hintText: '90xxxxx088',
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
                          String email = _emailRead.text;
                          String password = _passRead.text;
                          String username = _userRead.text;
                          String phone = _phoneRead.text;
                          if (password == _confirmPass.text &&
                              phone.length == 10 &&
                              emailRegex.hasMatch(email)) {
                            saveUserDetails(username, email, password, phone);
                          } else if (password != _confirmPass.text) {
                            showSnackbar("Passwords don't match try again");
                          } else if (phone.length != 10) {
                            showSnackbar("Enter a valid phone number");
                          } else if (!emailRegex.hasMatch(email)) {
                            showSnackbar("Enter a valid email address");
                          }
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
