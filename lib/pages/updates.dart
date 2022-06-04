// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

class Updates extends StatelessWidget {
  const Updates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: backButton(context),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "What's new",
          ),
        ),
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
}
