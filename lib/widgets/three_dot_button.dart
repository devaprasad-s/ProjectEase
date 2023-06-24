import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ThreeDotButton extends StatefulWidget {
  final VoidCallback onLogoutPressed;

  const ThreeDotButton({required this.onLogoutPressed});

  @override
  ThreeDotButtonState createState() => ThreeDotButtonState();
}

class ThreeDotButtonState extends State<ThreeDotButton> {
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      widget.onLogoutPressed(); // Call the provided callback
    } catch (e) {
      print("Logout error: $e");
      // Show an error dialog or display a snackbar with the error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'logout') {
          _logout(); // Call the logout method
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'logout',
          child: Text('Log out'),
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }
}
