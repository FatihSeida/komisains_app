import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChannelYoutube {
  ChannelYoutube({
    required this.data,
    required this.message,
  });

  final List<Datum> data;
  final String message;

  factory ChannelYoutube.fromJson(String str) =>
      ChannelYoutube.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChannelYoutube.fromMap(Map<String, dynamic> json) => ChannelYoutube(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String thumbnail;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        thumbnail:
            'https://komdakkomcakaba.my.id/yt-channel-thumbnail/${json["thumbnail"]}',
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
