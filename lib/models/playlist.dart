import 'package:flutter/cupertino.dart';

class Playlist {
  String? image;
  final String title;

  Playlist({this.image, required this.title}) {
    image ??= 'https://i.imgur.com/ovAdKF3.png';
  }
}

class PlaylistOperations {
  List<Playlist> getPlaylist() {
    return <Playlist>[
      Playlist(title: 'Playlist #1'),
      Playlist(title: 'Playlist #2'),
      Playlist(title: 'Playlist #3'),
      Playlist(title: 'Playlist #4'),
      Playlist(title: 'Playlist #5'),
      Playlist(title: 'Playlist #6'),
    ];
  }
}
