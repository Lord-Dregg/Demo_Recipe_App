//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import './homepage.dart';
import './login_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 8), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      /*if (_auth.currentUser != null)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }*/
    });

    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 80.0,
        ),
      ),
    );
  }
}
