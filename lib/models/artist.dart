// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Artist {
  String? image;
  final String name;

  Artist({this.image, required this.name}) {
    image ??= 'https://i.imgur.com/ovAdKF3.png';
  }
}

class ArtistOperations with ChangeNotifier {
  List<Artist> _list = [
    Artist(
        image:
            'https://i.scdn.co/image/ab67616100005174ee954a3b5418065c2fe253fb',
        name: 'Olivia Rodrigo'),
    Artist(
        image:
            'https://i.scdn.co/image/ab6761610000f178c429d2e8dbc906a8beb3b051',
        name: 'aespa'),
    Artist(
        image:
            'https://i.scdn.co/image/ab6761610000f178879835ea4e3a0f0b8cf1c7b4',
        name: 'Lil Uzi Vert'),
    Artist(
        image:
            'https://i.scdn.co/image/ab6761610000f178cb4ae963f0c01900f3e17712',
        name: 'KSI'),
    Artist(
        image:
            'https://i.scdn.co/image/ab6761610000f1788a8415e72dedaa552259d0c1',
        name: 'Red Velvet'),
  ];

  List<Artist> get artistList => _list;

  void addArtist(String image, String name) {
    bool hasDuplicate = false;
    for (int i = 0; i < _list.length; i++) {
      if (name.compareTo(_list[i].name) == 0) {
        hasDuplicate = true;
      }
    }

    if (!hasDuplicate) {
      print(image + ', ' + name);
      if (image == ' ' || image == '') {
        _list.add(Artist(image: null, name: name));
        print('condition fulfilled');
      } else {
        _list.add(Artist(image: image, name: name));
        print('condition not fulfilled');
      }
      notifyListeners();
    }
  }
}
