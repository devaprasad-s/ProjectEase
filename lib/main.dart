import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProjectEase',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
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
                              Image.asset('assets/fields/username.png'),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 10.0),
                                child: TextField(
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
                                  Navigator.pushNamed(context,
                                      '/profile'); // Perform login action
                                },
                                child: Image.asset('assets/icons/loginico.png',
                                    width: 121,
                                    height: 39,
                                    fit: BoxFit.contain),
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
                          Navigator.pushNamed(
                              context, '/profile'); // Perform signup action
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
            // Add your menu icon onPressed logic here
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
