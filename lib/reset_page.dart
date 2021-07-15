import 'package:flutter/material.dart';
import 'package:ui_demo/login_page.dart';
import 'Providers/auth_provider.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    bool isLoading = false;

    final Widget resetButton = Padding(
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
                .resetPassword(
              email: emailController.text.trim(),
            )
                .then((value) {
              if (value == 'Email Reset Successfully') {
                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                setState(() {
                  isLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value),
                  ),
                );
              }
            });
          },
          color: Colors.lightBlueAccent.shade100,
          child: Text('Reset', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final Widget reset = Container(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 0.3 * MediaQuery.of(context).size.height,
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
            resetButton,
          ],
        ),
      ),
    );

    return Scaffold(
      body: !isLoading
          ? Center(
              child: reset,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
