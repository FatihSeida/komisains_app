import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/agenda/models/agenda.dart';

class AgendaRepository {
  final String? userId;
  // final String? authToken;

  AgendaRepository({
    this.userId,
    // this.authToken,
  });

  Future<List<Calendar>> fetchData(String authToken) async {
    try {
      final response = await http.get(
          Uri.parse('https://api.komdakkomcakaba.my.id/api/calendars'),
          headers: {
            'Content-type': 'application/json',
            'Accept': '/',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Authorization': 'Bearer $authToken',
          });

      final extractedData = json.decode(response.body.toString());
      final List<Calendar> loaded = [];
      for (Map<String, dynamic> i in extractedData["calendars"]) {
        loaded.add(Calendar.fromMap(i));
      }
      return loaded;
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
