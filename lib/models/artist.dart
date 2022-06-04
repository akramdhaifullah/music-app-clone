class Artist {
  final String image;
  final String name;

  Artist({required this.image, required this.name});
}

class ArtistOperations {
  List<Artist> getArtist() {
    return <Artist>[
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
  }
}
