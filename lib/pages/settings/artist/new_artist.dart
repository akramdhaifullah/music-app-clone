// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:music_app_clone/main.dart';
import 'package:music_app_clone/models/artist.dart';

class NewArtist extends StatelessWidget {
  final nameController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 19, 19, 19),
            leading: backButton(),
            title: const Text(
              'Add new artist',
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Column(
        children: [
          nameField(),
          SizedBox(height: 20),
          imageField(),
          SizedBox(height: 40),
          addButton(),
        ],
      ),
    );
  }

  Widget backButton() {
    return GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        navigatorKey.currentState!.pop();
      },
    );
  }

  Widget nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: nameController,
            cursorColor: Colors.green,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 75, 75, 75),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget imageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: imageController,
            cursorColor: Colors.green,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 75, 75, 75),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }

  Widget addButton() {
    return Align(
      alignment: Alignment.center,
      child: MaterialButton(
        child: Text(
          'Add artist',
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
          navigatorKey.currentContext!.read<ArtistOperations>().addArtist(
              imageController.text.trim(), nameController.text.trim());
        },
      ),
    );
  }
}
