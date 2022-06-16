// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:music_app_clone/pages/authentication/login.dart';
import 'package:music_app_clone/pages/authentication/register.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              disabledColor: Colors.white10,
              disabledTextColor: Colors.black,
              color: Colors.green,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minWidth: 300,
              height: 50,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register())),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                primary: Colors.white,
                onSurface: Colors.grey,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
