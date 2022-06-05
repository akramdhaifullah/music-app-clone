// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app_clone/main.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 19, 19, 19),
          leading: backButton(context),
          title: const Text(
            'Settings',
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        logOut(context),
      ]),
    );
  }

  Widget backButton(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget logOut(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        child: Text(
          'Log out',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        disabledColor: Colors.white10,
        disabledTextColor: Colors.black,
        color: Colors.white,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minWidth: 120,
        height: 50,
        onPressed: () {
          FirebaseAuth.instance.signOut();
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
