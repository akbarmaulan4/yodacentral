// To parse this JSON data, do
//
//     final modelResponseLogin = modelResponseLoginFromMap(jsonString);

import 'dart:convert';

ModelResponseLogin modelResponseLoginFromMap(String str) =>
    ModelResponseLogin.fromMap(json.decode(str));

String modelResponseLoginToMap(ModelResponseLogin data) =>
    json.encode(data.toMap());

class ModelResponseLogin {
  ModelResponseLogin({
    this.message,
    this.token,
    this.userData,
  });

  String? message;
  String? token;
  UserData? userData;

  factory ModelResponseLogin.fromMap(Map<String, dynamic> json) =>
      ModelResponseLogin(
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        userData: json["userData"] == null
            ? null
            : UserData.fromMap(json["userData"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "token": token == null ? null : token,
        "userData": userData == null ? null : userData!.toMap(),
      };
}

class UserData {
  UserData({
    this.email,
    this.name,
    this.telp,
    this.avatar,
    this.role,
    this.kantor,
    this.kode,
    this.markNotif,
    this.active,
  });

  String? email;
  String? name;
  String? telp;
  String? avatar;
  String? role;
  String? kantor;
  String? kode;
  int? markNotif;
  bool? active;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        telp: json["telp"] == null ? null : json["telp"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        role: json["role"] == null ? null : json["role"],
        kantor: json["kantor"] == null ? null : json["kantor"],
        kode: json["kode"] == null ? null : json["kode"],
        markNotif: json["mark_notif"] == null ? null : json["mark_notif"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "name": name == null ? null : name,
        "telp": telp == null ? null : telp,
        "avatar": avatar == null ? null : avatar,
        "role": role == null ? null : role,
        "kantor": kantor == null ? null : kantor,
        "kode": kode == null ? null : kode,
        "mark_notif": markNotif == null ? null : markNotif,
        "active": active == null ? null : active,
      };
}
