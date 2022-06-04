// ignore_for_file: prefer_const_constructors

class Charts {
  final String image;
  final String description;

  const Charts({
    required this.image,
    required this.description,
  });
}

class ChartsOperations {
  List<Charts> getCharts() {
    return <Charts>[
      Charts(
          image:
              'https://charts-images.scdn.co/assets/locale_en/regional/weekly/region_global_large.jpg',
          description:
              'Your weekly update of the most played tracks right now - Global.'),
      Charts(
          image:
              'https://charts-images.scdn.co/assets/locale_en/regional/weekly/region_id_large.jpg',
          description:
              'Your weekly update of the most played tracks right now - Indonesia.'),
      Charts(
          image:
              'https://charts-images.scdn.co/assets/locale_en/regional/daily/region_global_large.jpg',
          description:
              'Your daily update of the most played tracks right now - Global.'),
      Charts(
          image:
              'https://charts-images.scdn.co/assets/locale_en/regional/daily/region_id_large.jpg',
          description:
              'Your daily update of the most played tracks right now - Indonesia.'),
    ];
  }
}
