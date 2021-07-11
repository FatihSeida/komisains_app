import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/info_training/models/training_information_item.dart';

class InfoTrainingRepository {
  final String? userId;
  // final String? authToken;

  InfoTrainingRepository({
    this.userId,
    // this.authToken,
  });

  Future<List<Info>> fetchData(String authToken) async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/info-training'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Info> loaded = [];
      for (Map<String, dynamic> i in extractedData["info"]) {
        loaded.add(Info.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
