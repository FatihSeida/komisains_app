import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class InfoTraining {
  InfoTraining({
    required this.info,
    required this.message,
  });

  final List<Info> info;
  final String message;

  factory InfoTraining.fromJson(String str) =>
      InfoTraining.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoTraining.fromMap(Map<String, dynamic> json) => InfoTraining(
        info: List<Info>.from(json["info"].map((x) => Info.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "info": List<dynamic>.from(info.map((x) => x.toMap())),
        "message": message,
      };
}

class Info {
  Info({
    required this.id,
    required this.title,
    required this.dateStart,
    required this.dateEnd,
    required this.province,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String province;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String thumbnail;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        id: json["id"],
        title: json["title"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: DateTime.parse(json["date_end"]),
        province: json["province"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        thumbnail:
            'https://komdakkomcakaba.my.id/info-training-thumbnail/${json["thumbnail"]}',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "date_start":
            "${dateStart.year.toString().padLeft(4, '0')}-${dateStart.month.toString().padLeft(2, '0')}-${dateStart.day.toString().padLeft(2, '0')}",
        "date_end":
            "${dateEnd.year.toString().padLeft(4, '0')}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}",
        "province": province,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "thumbnail": thumbnail,
      };
}
