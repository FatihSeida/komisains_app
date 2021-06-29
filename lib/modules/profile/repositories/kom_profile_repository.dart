import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/profile/models/kom_profile.dart';

class KomProfileRepository {
  final String? authToken;
  final String? userId;

  KomProfileRepository({this.authToken, this.userId});

  Future<CakabaProfile> fetchData() async {
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
      final CakabaProfile loaded = CakabaProfile.fromMap(extractedData['cakaba-profile']);
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}