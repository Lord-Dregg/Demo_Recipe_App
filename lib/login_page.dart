import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_demo/Providers/auth_provider.dart';
import 'package:ui_demo/reset_page.dart';
import './homepage.dart';
import './register_page.dart';
import './reset_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final Widget loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5,
        child: MaterialButton(
          minWidth: 200,
          height: 42,
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            AuthClass()
                .signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            )
                .then((value) {
              if (value == 'Welcome') {
                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else {
                setState(() {
                  isLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value),
                ));
              }
            });
          },
          color: Colors.lightBlueAccent.shade100,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final Widget login = Container(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 0.38 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.8, color: Colors.lightBlue),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-Mail Address',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            loginButton,
          ],
        ),
      ),
    );

    final signUp = TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      ),
      child: Text(
        'Don\'t have an account? Create one now',
        style: TextStyle(color: Colors.black54),
      ),
    );

    return Scaffold(
      body: !isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  login,
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onTap: () {
                      //Forgot Password
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPage()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  signUp,
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
