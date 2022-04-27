// To parse this JSON data, do
//
//     final modelListPic = modelListPicFromMap(jsonString);

import 'dart:convert';

ModelListPic modelListPicFromMap(String str) =>
    ModelListPic.fromMap(json.decode(str));

String modelListPicToMap(ModelListPic data) => json.encode(data.toMap());

class ModelListPic {
  ModelListPic({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelListPic.fromMap(Map<String, dynamic> json) => ModelListPic(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.pic,
    this.cabang,
  });

  List<Pic>? pic;
  Cabang? cabang;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pic: json["pic"] == null ? null: List<Pic>.from(json["pic"].map((x) => Pic.fromMap(x))),
        cabang: json["cabang"] == null ? null : Cabang.fromMap(json["cabang"]),
      );

  Map<String, dynamic> toMap() => {
        "pic": pic == null ? null : List<dynamic>.from(pic!.map((x) => x.toMap())),
        "cabang": cabang == null ? null : cabang!.toMap(),
      };
}

class Pic {
  Pic({
    this.id,
    this.leadId,
    this.userId,
    this.roleId,
    this.name,
    this.role,
    this.photoProfile,
  });

  int? id;
  int? leadId;
  int? userId;
  int? roleId;
  String? name;
  String? role;
  String? photoProfile;

  factory Pic.fromMap(Map<String, dynamic> json) => Pic(
        id: json["id"] == null ? null : json["id"],
        leadId: json["lead_id"] == null ? null : json["lead_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        name: json["name"] == null ? null : json["name"],
        role: json["role"] == null ? null : json["role"],
        photoProfile:
            json["photo_profile"] == null ? null : json["photo_profile"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "lead_id": leadId == null ? null : leadId,
        "user_id": userId == null ? null : userId,
        "role_id": roleId == null ? null : roleId,
        "name": name == null ? null : name,
        "role": role == null ? null : role,
        "photo_profile": photoProfile == null ? null : photoProfile,
      };
}

class Cabang {
  Cabang({
    this.id,
    this.code,
    this.name,
    this.area_id,
    this.user_id,
    this.telp,
    this.address,
    this.register,
    this.area,
    this.pic,
  });

  int? id;
  String? code;
  String? name;
  int? area_id;
  int? user_id;
  String? telp;
  String? address;
  String? register;
  String? area;
  String? pic;

  factory Cabang.fromMap(Map<String, dynamic> json) => Cabang(
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    name: json["name"] == null ? null : json["name"],
    area_id: json["area_id"] == null ? null : json["area_id"],
    user_id: json["user_id"] == null ? null : json["user_id"],
    telp: json["telp"] == null ? null : json["telp"],
    address: json["address"] == null ? null : json["address"],
    register: json["register"] == null ? null : json["register"],
    area: json["area"] == null ? null : json["area"],
    pic: json["address"] == null ? null : json["pic"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "name": name == null ? null : name,
    "area_id": area_id == null ? null : area_id,
    "user_id": user_id == null ? null : user_id,
    "telp": telp == null ? null : telp,
    "address": address == null ? null : address,
    "register": register == null ? null : register,
    "area": area == null ? null : area,
    "pic": pic == null ? null : pic,
  };
}
