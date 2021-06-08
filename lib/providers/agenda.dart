import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AgendaProvider with ChangeNotifier {
  List<Calendar> items = [];
  bool isLoading = true;
  var _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  final String authToken;
  final String userId;

  AgendaProvider({this.authToken, this.userId});

  List<Calendar> get getData {
    return [...items];
  }

  Future<void> getPickup() async {
    
    try {
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': '/',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Authorization': 'Bearer $authToken'
      });

      final extractedData = json.decode(response.body.toString());
      final List<Calendar> loaded = [];
      for (Map i in extractedData["calendars"]) {
        loaded.add(Calendar.fromMap(i));
      }
      items = loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class Agenda with ChangeNotifier {
  Agenda({
    @required this.calendars,
    @required this.message,
  });

  final List<Calendar> calendars;
  final String message;

  factory Agenda.fromJson(String str) => Agenda.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Agenda.fromMap(Map<String, dynamic> json) => Agenda(
        calendars: List<Calendar>.from(
            json["calendars"].map((x) => Calendar.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "calendars": List<dynamic>.from(calendars.map((x) => x.toMap())),
        "message": message,
      };
}

class Calendar with ChangeNotifier {
  Calendar({
    @required this.id,
    @required this.name,
    @required this.dateStart,
    @required this.dateEnd,
    @required this.tempat,
    @required this.waktuStart,
    @required this.waktuEnd,
    @required this.description,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.thumbnail,
  });

  final int id;
  final String name;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String tempat;
  final String waktuStart;
  final String waktuEnd;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String thumbnail;

  factory Calendar.fromJson(String str) => Calendar.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Calendar.fromMap(Map<String, dynamic> json) => Calendar(
        id: json["id"],
        name: json["name"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: DateTime.parse(json["date_end"]),
        tempat: json["tempat"],
        waktuStart: json["waktu_start"],
        waktuEnd: json["waktu_end"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "date_start":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "date_end":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "tempat": tempat,
        "waktu_start": waktuStart,
        "waktu_end": waktuEnd,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "thumbnail": thumbnail == null ? null : thumbnail,
      };
}
