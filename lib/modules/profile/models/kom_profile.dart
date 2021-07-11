import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class KomProfile {
  KomProfile({
    required this.cakabaProfile,
    required this.message,
  });

  final CakabaProfile cakabaProfile;
  final String message;

  factory KomProfile.fromJson(String str) =>
      KomProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KomProfile.fromMap(Map<String, dynamic> json) => KomProfile(
        cakabaProfile: CakabaProfile.fromMap(json["cakaba-profile"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "cakaba-profile": cakabaProfile.toMap(),
        "message": message,
      };
}

class CakabaProfile {
  CakabaProfile({
    required this.id,
    required this.description,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String description;
  final String thumbnail;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CakabaProfile.fromJson(String str) =>
      CakabaProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CakabaProfile.fromMap(Map<String, dynamic> json) => CakabaProfile(
        id: json["id"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "thumbnail": thumbnail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
