import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:komisains_app/modules/ebook/models/books.dart';

class EbookRepository {
  final String? authToken;
  final String? userId;

  EbookRepository({this.authToken, this.userId});

  Future<List<Book>> fetchData(String category) async {
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
      final List<Book> loaded = [];
      for (Map<String, dynamic> i in extractedData["ebook"]) {
        loaded.add(Book.fromMap(i));
      }
      if (category == 'Materi Wajib') {
        return loaded
            .where((loadedItem) => loadedItem.category == 'Materi Wajib')
            .toList();
      } else {
        return loaded
            .where((loadedItem) => loadedItem.category == 'Resensi')
            .toList();
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
