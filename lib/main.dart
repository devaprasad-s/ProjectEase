import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController emailRead = TextEditingController();
  final TextEditingController passRead = TextEditingController();
  final TextEditingController userRead = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProjectEase',
      theme: ThemeData(
        fontFamily:
            'Product Sans', // Replace 'YourDefaultFont' with the name of your desired font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(
              emailRead: emailRead,
              passRead: passRead,
            ),
        '/signup': (context) => SignupPage(
              emailRead: emailRead,
              passRead: passRead,
              userRead: userRead,
            ),
        '/profile': (context) => ProfilePage(username: " "),
      },
    );
  }
}
