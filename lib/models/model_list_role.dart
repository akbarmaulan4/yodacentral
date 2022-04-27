// To parse this JSON data, do
//
//     final modelListRole = modelListRoleFromMap(jsonString);

import 'dart:convert';

ModelListRole modelListRoleFromMap(String str) =>
    ModelListRole.fromMap(json.decode(str));

String modelListRoleToMap(ModelListRole data) => json.encode(data.toMap());

class ModelListRole {
  ModelListRole({
    this.message,
    this.total,
    this.data,
  });

  String? message;
  int? total;
  List<Datum>? data;

  factory ModelListRole.fromMap(Map<String, dynamic> json) => ModelListRole(
        message: json["message"] == null ? null : json["message"],
        total: json["total"] == null ? null : json["total"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "total": total == null ? null : total,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.category,
    this.scope,
  });

  int? id;
  String? name;
  String? category;
  String? scope;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        scope: json["scope"] == null ? null : json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "scope": scope == null ? null : scope,
      };
}
