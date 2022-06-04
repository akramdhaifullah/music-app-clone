// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:music_app_clone/pages/home.dart';
import 'package:music_app_clone/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic isLoggedIn;
dynamic displayName;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginStatus = prefs.getBool('isLoggedIn');
    var userName = prefs.getString('name');
    setState(() {
      isLoggedIn = loginStatus;
      displayName = userName;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getValidationData();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoScrollGlow(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'CircularStd'),
      home: isLoggedIn == true ? Home(userName: displayName) : MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.center,
        child: TextButton(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }),
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
