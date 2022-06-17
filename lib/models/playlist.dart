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
      Playlist(
          title: 'Top Hits of 2017',
          image:
              'https://i.scdn.co/image/ab67706f00000003ccda972531209eafddf06cc1'),
      Playlist(
          title: 'Mega Hit Mix',
          image:
              'https://i.scdn.co/image/ab67706f00000003db32a17c1f5291b19317b62e'),
      Playlist(
          title: "corona '20",
          image:
              'https://i.scdn.co/image/ab67706c0000bebbf5a37c507b24e9a68ec89e18'),
      Playlist(
          title: '2014,2015,2016,2017',
          image:
              'https://i.scdn.co/image/ab67706c0000bebbcde6c8101cac9f870e8b04b1'),
      Playlist(
          title: 'Release Radar',
          image:
              'https://newjams-images.scdn.co/v3/release-radar/ab6761610000e5ebc429d2e8dbc906a8beb3b051/en/large'),
      Playlist(
          title: 'Beats & Rhymes',
          image:
              'https://i.scdn.co/image/ab67706f00000003fc5acf8e023c0c049176e94c'),
    ];
  }
}
