class ArtistJSON {
  ArtistJSON({
    required this.total,
    required this.messages,
    required this.data,
  });

  int total;
  String messages;
  List<Datum> data;

  factory ArtistJSON.fromJson(Map<String, dynamic> json) => ArtistJSON(
        total: json["total"],
        messages: json["messages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.artistId,
    required this.artistName,
    required this.artistImage,
    required this.songId,
    required this.createdAt,
    required this.updatedAt,
  });

  int artistId;
  String artistName;
  String artistImage;
  dynamic songId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        artistId: json["artist_id"],
        artistName: json["artist_name"],
        artistImage: json["artist_image"],
        songId: json["song_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
