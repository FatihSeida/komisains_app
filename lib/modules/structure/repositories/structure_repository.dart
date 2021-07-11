import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/structure/models/structures.dart';

class StructureRepository {
  // final String? authToken;
  final String? userId;

  StructureRepository({
    // this.authToken, 
    this.userId});

  Future<List<Structure>> fetchData(String authToken) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://api.komdakkomcakaba.my.id/api/structure-organization'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Structure> loaded = [];
      for (Map<String, dynamic> i in extractedData["structures"]) {
        loaded.add(Structure.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
