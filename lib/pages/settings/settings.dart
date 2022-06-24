// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:music_app_clone/main.dart';
import 'package:music_app_clone/models/configuration.dart';
import 'package:music_app_clone/pages/settings/artist/delete_artist.dart';
import 'package:music_app_clone/pages/settings/artist/new_artist.dart';
import 'package:music_app_clone/pages/settings/artist/update_artist.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userEmail = user.email!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 19, 19, 19),
          leading: backButton(),
          title: const Text(
            'Settings',
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 40),
          child: Column(children: [
            userProfile(userEmail),
            SizedBox(height: 10),
            artistSettingsList(),
            SizedBox(height: 20),
            settingsList(),
            logOutButton(),
          ]),
        ),
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

  // use Card widget
  Widget userProfile(String email) {
    String getFirstWord(String email) {
      List<String> wordList = email.split('@');
      if (wordList.isNotEmpty) {
        return wordList[0];
      } else {
        return '';
      }
    }

    return Row(
      children: [
        userProfilePhoto(),
        SizedBox(width: 20),
        userProfileText(getFirstWord(email)),
        Spacer(),
        userProfileIcon(),
      ],
    );
  }

  Widget userProfilePhoto() {
    return CircleAvatar(
      child: Iconify(
        Mdi.account_outline,
        color: Colors.white,
        size: 30,
      ),
      radius: 26.0,
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
    );
  }

  Widget userProfileText(String user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(
          user,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'View Profile',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }

  Widget userProfileIcon() {
    return Icon(
      Icons.chevron_right_rounded,
      color: Colors.white70,
      size: 30,
    );
  }

  Widget artistSettingsList() {
    List<ConfigurationArtist> data =
        ConfigurationArtistOperations().artistConfigurations;
    return Container(
      // color: Colors.green,
      height: 140,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              navigatorKey.currentState!
                  .push(MaterialPageRoute(builder: (context) => AddArtist()));
            },
            child: buildArtistSettingsList(data[0]),
          ),
          GestureDetector(
              onTap: () {
                navigatorKey.currentState!.push(
                    MaterialPageRoute(builder: (context) => DeleteArtist()));
              },
              child: buildArtistSettingsList(data[1])),
          GestureDetector(
              onTap: () {
                navigatorKey.currentState!.push(
                    MaterialPageRoute(builder: ((context) => UpdateArtist())));
              },
              child: buildArtistSettingsList(data[2])),
        ],
      ),
      // child: ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     return buildArtistSettingsList(data[index]);
      //   },
      //   itemCount: data.length,
      //   physics: NeverScrollableScrollPhysics(),
      // ),
    );
  }

  Widget buildArtistSettingsList(ConfigurationArtist config) {
    return Container(
      // color: Colors.green,
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            config.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          userProfileIcon(),
        ],
      ),
    );
  }

  Widget settingsList() {
    List<Configuration> data = ConfigurationOperations().getConfiguration();
    return Container(
      // color: Colors.amber,
      height: 600,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return buildSettingsList(data[index]);
        },
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget buildSettingsList(Configuration config) {
    return GestureDetector(
      onTap: () {
        print('Opening ${config.label}');
      },
      child: SizedBox(
        // color: Colors.green,
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              config.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            userProfileIcon(),
          ],
        ),
      ),
    );
  }

  Widget logOutButton() {
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
