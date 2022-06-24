// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/uil.dart';

import 'package:music_app_clone/main.dart';
import 'package:music_app_clone/models/artist.dart';
import 'package:music_app_clone/models/charts.dart';
import 'package:music_app_clone/models/music.dart';
import 'package:music_app_clone/models/playlist.dart';
import 'package:music_app_clone/models/podcast.dart';
import 'package:music_app_clone/pages/home/updates.dart';
import 'package:music_app_clone/pages/home/recent.dart';
import 'package:music_app_clone/pages/settings/settings.dart';

import 'package:provider/provider.dart';

List<Artist> artistData = ArtistOperations().artistList;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            welcome(),
            SizedBox(height: 25),
            podcasts(),
            SizedBox(height: 25),
            charts(),
            SizedBox(height: 25),
            recentPlays(),
            Container(height: 25),
            artists(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Iconify(Ic.baseline_home, color: Colors.white),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Iconify(Uil.search, color: Colors.white), label: 'Search'),
          BottomNavigationBarItem(
              icon: Iconify(Fluent.library_28_regular, color: Colors.white),
              label: 'Your Library'),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
      ),
    );
  }

  Widget welcome() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blueGrey.shade300, Colors.transparent],
            begin: Alignment(-1.4, -1.4),
            end: Alignment(-0.8, 1),
            stops: [0.1, 1]),
      ),
      child: Column(
        children: [
          header(),
          SizedBox(height: 20),
          gridCards(),
        ],
      ),
    );
  }

  Widget header() {
    double iconSize = 26;
    return Container(
      margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerTitle(),
          Row(
            children: [
              notificationButton(iconSize),
              SizedBox(width: 18),
              recentButton(iconSize),
              SizedBox(width: 18),
              settingsButton(iconSize),
            ],
          ),
        ],
      ),
    );
  }

  Widget headerTitle() {
    return Text(
      headerGreetings(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String headerGreetings() {
    // final now = DateTime.now();
    // final time = int.parse('${now.hour}${now.minute}');
    // print(time);
    // if (time >= 600 && time <= 1159) {
    //   return 'Good morning';
    // } else if (time >= 1200 && time <= 1759) {
    //   return 'Good afternoon';
    // } else {
    //   return 'Good evening';
    // }
    return 'Good afternoon';
  }

  Widget notificationButton(double size) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Updates())),
      child: Iconify(
        Ph.bell,
        color: Colors.white,
        size: size,
      ),
    );
  }

  Widget recentButton(double size) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Recent())),
      child: Iconify(
        Mdi.progress_clock,
        color: Colors.white,
        size: size,
      ),
    );
  }

  Widget settingsButton(double size) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Settings())),
      child: Iconify(
        Carbon.settings,
        color: Colors.white,
        size: size,
      ),
    );
  }

  // Widget rowColumnCards() {
  Widget gridCards() {
    return Container(
      height: 185,
      // color: Colors.green,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: GridView.count(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 6.3 / 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
        children: gridCardsList(),
      ),
    );
  }

  List<Widget> gridCardsList() {
    List<Playlist> data = PlaylistOperations().getPlaylist();
    List<Widget> cards =
        data.map((Playlist playlist) => horizontalCards(playlist)).toList();
    return cards;
  }

  Widget horizontalCards(Playlist playlist) {
    double edgeBorder = 4;

    return GestureDetector(
      onTap: () {
        print("Opening ${playlist.title}");
      },
      child: Material(
        color: Color.fromARGB(160, 33, 33, 33),
        elevation: 2,
        borderRadius: BorderRadius.circular(edgeBorder),
        child: Container(
          height: 60,
          width: 177,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(edgeBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              photoCard(playlist.image.toString()),
              SizedBox(width: 9),
              labelCard(playlist.title),
            ],
          ),
        ),
      ),
    );
  }

  Widget photoCard(String image) {
    double squareSize = 56;
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Image(
        image: NetworkImage(image),
        fit: BoxFit.cover,
        width: squareSize,
        height: squareSize,
      ),
    );
  }

  Widget labelCard(String title) {
    return SizedBox(
      width: 105,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget labelTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget podcasts() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: labelTitle("Episodes for you"),
            ),
          ),
          podcastList(),
        ],
      ),
    );
  }

  Widget podcastList() {
    List<Podcast> data = PodcastOperations().getPodcast();
    return SizedBox(
      height: 220,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return buildPodcastCard(data[index]);
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildPodcastCard(Podcast podcast) {
    return GestureDetector(
      onTap: () {
        print("Opening ${podcast.title}");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 14, 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(podcast.image),
              ),
            ),
            width: 152,
            height: 152,
          ),
          SizedBox(
            width: 150,
            child: Text(
              podcast.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 150,
            child: Text(
              podcast.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget charts() {
    return Container(
      // color: Colors.green,
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: labelTitle("Charts"),
            ),
          ),
          chartsList(),
        ],
      ),
    );
  }

  Widget chartsList() {
    List<Charts> data = ChartsOperations().getCharts();
    return SizedBox(
      height: 190,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return buildChartsCard(data[index]);
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildChartsCard(Charts charts) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 14),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(image: NetworkImage(charts.image)),
            ),
            width: 148,
            height: 148,
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 145,
            child: Text(
              charts.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget recentPlays() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: labelTitle("Recently played")),
          ),
          recentPlaysList(),
        ],
      ),
    );
  }

  Widget recentPlaysList() {
    List<Music> data = MusicOperations().getMusic();
    return SizedBox(
      height: 156,
      // color: Colors.green,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return buildRecentCard(data[index]);
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildRecentCard(Music music) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 14),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(music.image),
              fit: BoxFit.fill,
            ),
          ),
          width: 112,
          height: 112,
        ),
        SizedBox(height: 7),
        SizedBox(
          // color: Colors.amber,
          width: 113,
          child: Text(
            music.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        )
      ],
    );
  }

  Widget artists() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: labelTitle('Your favorite artists'),
            ),
          ),
          artistList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget artistList() {
    return Consumer<ArtistOperations>(
      builder: (context, value, child) => SizedBox(
        height: 215,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return buildArtistList(artistData[index]);
          },
          itemCount: artistData.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildArtistList(Artist artist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 14),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(artist.image.toString()),
            ),
          ),
          width: 150,
          height: 150,
        ),
        SizedBox(height: 10),
        Container(
          width: 150,
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
