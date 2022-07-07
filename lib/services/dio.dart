import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music_app_clone/models/artist_json.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8000',
    contentType: "application/json",
    responseType: ResponseType.json,
  ));

  Future<ArtistJSON> getDatas() async {
    Response data = await _dio.get('/api/artists');
    return ArtistJSON.fromJson(data.data);
  }

  // Future<ArtistJSON> storeData(String name, String image) async {
  //   var dataToAdd = {
  //     "artist_name": name,
  //     "artist_image": image,
  //   };

  //   Response data = await _dio.post(
  //     '/api/artists/',
  //     data: jsonEncode(dataToAdd),
  //   );
  //   return ArtistJSON.fromJson(data.data);
  // }
}
