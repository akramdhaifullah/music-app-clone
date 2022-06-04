// ignore_for_file: prefer_const_constructors

class Podcast {
  final String image;
  final String title;
  final String producer;
  final String description;

  const Podcast(
      {required this.image,
      required this.title,
      required this.producer,
      required this.description});
}

class PodcastOperations {
  List<Podcast> getPodcast() {
    return <Podcast>[
      Podcast(
          image:
              'https://i.scdn.co/image/adf4a49802a4d56f67d02802f294cdcbab573e3f',
          title: 'The Sky Sports Football Podcast',
          producer: 'Sky Sports',
          description:
              'All under one roof: The Essential Football Show preview & review, Super Sunday reaction, Monday Night Football talking points and more...'),
      Podcast(
          image:
              'https://i.scdn.co/image/9faf4edabeafbd742b199b6317cc12126971b321',
          title: 'Podcast Raditya Dika',
          producer: 'Raditya Dika',
          description:
              'Podcast milik Raditya Dika dengan tema obrolan tentang keuangan, keluarga, industri kreatif, dan hal-hal di antaranya. Episode baru seminggu sekali.'),
      Podcast(
          image:
              'https://i.scdn.co/image/164641a5dab5ddb6b2d3be524901ffe250444ae2',
          title: 'The Lazy Podcast',
          producer: 'The Lazy Monday',
          description:
              'Tempat untuk mendengarkan podcast The Lazy Monday audio only'),
      Podcast(
          image:
              'https://i.scdn.co/image/ab67656300005f1f84392c0cd228fcf834abc165',
          title: 'Podcast Pemain Cadangan',
          producer: 'Podkesmas Asia',
          description:
              'Inilah kami Augie Fantinus & Udjo Project Pop, 2 orang pemain cadangan yang waktu ngobrolnya lebih banyak dari waktu bermainnya! Kata siapa jadi cadangan itu gak enak? Jadi cadangan itu GAK MAIN!\nHadir setiap Rabu dan Sabtu. Jangan lupa Follow dan nyalakan lonceng-nya yaaa\nfor business inquiries please contact : contact@podkesmas.asia')
    ];
  }
}
