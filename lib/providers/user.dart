import 'package:flutter/material.dart';
import 'dart:convert';

class User with ChangeNotifier {
  User({
    required this.error,
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.user,
    required this.message,
  });

  final bool error;
  final String tokenType;
  final String accessToken;
  final int expiresIn;
  final UserClass user;
  final String message;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        error: json["error"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        user: UserClass.fromMap(json["user"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "token_type": tokenType,
        "access_token": accessToken,
        "expires_in": expiresIn,
        "user": user.toMap(),
        "message": message,
      };
}

class UserClass with ChangeNotifier {
  UserClass({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.gcmtoken,
    required this.hp,
    required this.address,
    required this.komisariat,
    required this.department,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.sex,
    required this.age,
    required this.jenjangTraining,
    required this.pengalamanOrganisasi,
    required this.linkedin,
    required this.instagram,
    required this.otherSocialMedia,
    required this.yearJoin,
    required this.angkatanKuliah,
    required this.namaAngkatan,
    required this.tempatTanggalLahir,
  });

  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic gcmtoken;
  final dynamic hp;
  final dynamic address;
  final dynamic komisariat;
  final String department;
  final dynamic photo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sex;
  final dynamic age;
  final String jenjangTraining;
  final String pengalamanOrganisasi;
  final dynamic linkedin;
  final dynamic instagram;
  final String otherSocialMedia;
  final dynamic yearJoin;
  final String angkatanKuliah;
  final dynamic namaAngkatan;
  final dynamic tempatTanggalLahir;

  factory UserClass.fromJson(String str) => UserClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        gcmtoken: json["gcmtoken"],
        hp: json["hp"],
        address: json["address"],
        komisariat: json["komisariat"],
        department: json["department"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sex: json["sex"],
        age: json["age"],
        jenjangTraining: json["jenjang_training"],
        pengalamanOrganisasi: json["pengalaman_organisasi"],
        linkedin: json["linkedin"],
        instagram: json["instagram"],
        otherSocialMedia: json["other_social_media"],
        yearJoin: json["year_join"],
        angkatanKuliah: json["angkatan_kuliah"],
        namaAngkatan: json["nama_angkatan"],
        tempatTanggalLahir: json["tempat_tanggal_lahir"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "gcmtoken": gcmtoken,
        "hp": hp,
        "address": address,
        "komisariat": komisariat,
        "department": department,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sex": sex,
        "age": age,
        "jenjang_training": jenjangTraining,
        "pengalaman_organisasi": pengalamanOrganisasi,
        "linkedin": linkedin,
        "instagram": instagram,
        "other_social_media": otherSocialMedia,
        "year_join": yearJoin,
        "angkatan_kuliah": angkatanKuliah,
        "nama_angkatan": namaAngkatan,
        "tempat_tanggal_lahir": tempatTanggalLahir,
      };
}
