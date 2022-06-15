// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app_clone/main.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool isPasswordVisible = false;
  bool isButtonActive = false;
  bool isUserNotEmpty = false;
  bool isPassNotEmpty = false;
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userController.addListener(() {
      final isUserNotEmpty = userController.text.isNotEmpty;

      setState(() {
        this.isUserNotEmpty = isUserNotEmpty;
        if (isPassNotEmpty == true && isUserNotEmpty == true) {
          isButtonActive = true;
        } else {
          isButtonActive = false;
        }
      });
    });

    passController.addListener(() {
      final isPassNotEmpty = passController.text.isNotEmpty;

      setState(() {
        this.isPassNotEmpty = isPassNotEmpty;
        if (isUserNotEmpty == true && isPassNotEmpty == true) {
          isButtonActive = true;
        } else {
          isButtonActive = false;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: backButton(context),
            title: const Text(
              'Log in',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: loginForm(),
      ),
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

  Widget loginForm() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            emailField(),
            SizedBox(height: 20),
            passwordField(),
            SizedBox(height: 10),
            errorText(),
            SizedBox(height: 25),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email or username',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: userController,
          cursorColor: Colors.green,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 75, 75, 75),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: passController,
          cursorColor: Colors.green,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 75, 75, 75),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
              color: Colors.white,
              onPressed: () {
                setState(
                  () {
                    isPasswordVisible = !isPasswordVisible;
                  },
                );
              },
            ),
          ),
          obscureText: !isPasswordVisible,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget errorText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }

  Widget loginButton() {
    return MaterialButton(
      child: Text(
        'Log in',
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
      minWidth: 100,
      height: 50,
      onPressed: isButtonActive ? signIn : null,
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userController.text.trim(),
          password: passController.text.trim());
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
      navigatorKey.currentState!.pop();
    }
  }
}
