import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  final TextEditingController emailRead;
  final TextEditingController passRead;
  LoginPage({required this.emailRead, required this.passRead});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.emailRead.dispose();
    widget.passRead.dispose();
    super.dispose();
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
                                  controller: widget.emailRead,
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
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                                child: TextField(
                                  controller: widget.passRead,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  String email = widget.emailRead.text;
                                  String password = widget.passRead.text;

                                  // Use the signInWithEmailAndPassword method to authenticate the user
                                  FirebaseAuth.instance
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
                                  });
                                },
                                child: Image.asset(
                                  'assets/icons/loginico.png',
                                  width: 121,
                                  height: 39,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      '/signup'); // Perform login action
                                },
                                child: Image.asset('assets/icons/signupico.png',
                                    width: 121,
                                    height: 39,
                                    fit: BoxFit.contain),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text("Or",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Product Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () {
                                print(
                                    "tapped on container"); // Perform login action
                              },
                              child: Image.asset('assets/icons/gologin.png',
                                  width: 211, height: 37, fit: BoxFit.contain),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}

class SignupPage extends StatelessWidget {
  final TextEditingController emailRead;
  final TextEditingController passRead;
  final TextEditingController userRead;
  void recordUsername(String username, String email) {
    String sanitizedEmail = email.replaceAll(RegExp('[^a-zA-Z0-9]'), '_');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(sanitizedEmail)
        .set({'username': username}).then((value) {
      print("Username recorded in Firestore");
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
                      child: InkWell(
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
                            Navigator.pushNamed(context, '/profile');
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
                        child: Image.asset(
                          'assets/icons/signupico.png',
                          width: 121,
                          height: 39,
                          fit: BoxFit.contain,
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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Change the color of the icons here
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pushNamed(context, '/'); // Add your button logic here
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    AssetImage('assets/images/profile_picture.jpg'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Devaprasad S',
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
