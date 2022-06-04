// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

class Music {
  final String image;
  final String title;
  final String artist;

  const Music({
    required this.image,
    required this.title,
    required this.artist,
  });
}

class MusicOperations {
  List<Music> getMusic() {
    return <Music>[
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e02c6af5ffa661a365b77df6ef6',
          title: 'Save Your Tears (Remix)',
          artist: 'The Weeknd'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e02b46f74097655d7f353caab14',
          title: 'As It Was',
          artist: 'Harry Styles'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e02206517a3f7e4c34bf0bfc531',
          title: 'Somebody Else',
          artist: 'The 1975'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e02c22f844a227186c96651c40a',
          title: 'Hatchback',
          artist: 'Cochise'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e02cad190f1a73c024e5a40dddd',
          title: 'Off The Grid',
          artist: 'Kanye West'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e0242a6d7b8477a1cf06ebce45f',
          title: 'Glitch',
          artist: 'KWON EUN BI'),
      Music(
          image:
              'https://i.scdn.co/image/ab67616d00001e0221e34052888986183afcebfa',
          title: 'First Class',
          artist: 'Jack Harlow'),
    ];
  }
}
