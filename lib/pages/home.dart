// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:music_app_clone/main.dart';
import 'package:music_app_clone/models/artist.dart';
import 'package:music_app_clone/models/charts.dart';
import 'package:music_app_clone/models/music.dart';
import 'package:music_app_clone/models/playlist.dart';
import 'package:music_app_clone/models/podcast.dart';
import 'package:music_app_clone/pages/updates.dart';
import 'package:music_app_clone/pages/recent.dart';
import 'package:music_app_clone/pages/settings.dart';

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
            SizedBox(height: 20),
            podcasts(),
            SizedBox(height: 20),
            charts(),
            SizedBox(height: 20),
            recentPlays(),
            SizedBox(height: 20),
            artists(),
          ],
        ),
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
            gridCards(),
            SizedBox(height: 10),
          ],
        ));
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerTitle(),
          Row(
            children: [
              notificationButton(),
              SizedBox(width: 16),
              recentButton(),
              SizedBox(width: 16),
              settingsButton(),
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
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String headerGreetings() {
    final now = DateTime.now();
    final time = int.parse('${now.hour}${now.minute}');
    if (time >= 600) {
      return 'Good morning';
    } else if (time >= 1200 && time <= 1900) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Widget notificationButton() {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Updates())),
      child: Icon(
        MdiIcons.bellOutline,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget recentButton() {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Recent())),
      child: Icon(
        MdiIcons.progressClock,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget settingsButton() {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (context) => Settings())),
      child: Icon(
        MdiIcons.cogOutline,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  // Widget rowColumnCards() {
  Widget gridCards() {
    return Container(
      height: 220,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: GridView.count(
        childAspectRatio: 6 / 2,
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
    return GestureDetector(
      onTap: () {},
      child: Material(
        color: Color.fromARGB(160, 33, 33, 33),
        elevation: 10,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          height: 60,
          width: 177,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              photoCard(playlist.image.toString()),
              SizedBox(width: 8),
              labelCard(playlist.title),
            ],
          ),
        ),
      ),
    );
  }

  Widget photoCard(String image) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Image(
        image: NetworkImage(image),
        fit: BoxFit.cover,
        width: 59,
        height: 59,
      ),
    );
  }

  Widget labelCard(String title) {
    return SizedBox(
      width: 104,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          height: 1.4,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget podcasts() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: const Text(
                'Episodes for you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          podcastList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget podcastList() {
    List<Podcast> data = PodcastOperations().getPodcast();
    return SizedBox(
      height: 215,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(podcast.image),
            ),
          ),
          width: 150,
          height: 150,
        ),
        Container(
          width: 150,
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            podcast.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            podcast.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        )
      ],
    );
  }

  Widget charts() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: const Text(
                'Charts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 10),
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(charts.image)),
          ),
          width: 148,
          height: 148,
        ),
        SizedBox(
          width: 145,
          child: Text(
            charts.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        )
      ],
    );
  }

  Widget recentPlays() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: const Text(
                'Recently played',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          recentPlaysList(),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget recentPlaysList() {
    List<Music> data = MusicOperations().getMusic();
    return SizedBox(
      height: 150,
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
          margin: EdgeInsets.fromLTRB(0, 0, 14, 10),
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(music.image)),
          ),
          width: 112,
          height: 112,
        ),
        SizedBox(
          width: 112,
          child: Text(
            music.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget artists() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: const Text(
                'Your favorite artists',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          artistList(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget artistList() {
    List<Artist> data = ArtistOperations().getArtist();
    return SizedBox(
      height: 215,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return buildArtistList(data[index]);
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildArtistList(Artist artist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 14, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
            image: DecorationImage(
              image: NetworkImage(artist.image),
            ),
          ),
          width: 150,
          height: 150,
        ),
        Container(
          width: 150,
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
