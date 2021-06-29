import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komisains_app/modules/youtube_channel/models/youtube_channel.dart';

class YoutubeRepository {
  final String? authToken;
  final String? userId;

  YoutubeRepository({this.authToken, this.userId});

  Future<List<Datum>> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/yt-channels'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Datum> loaded = [];
      for (Map<String, dynamic> i in extractedData["data"]) {
        loaded.add(Datum.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
