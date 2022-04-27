// To parse this JSON data, do
//
//     final modelLogActivity = modelLogActivityFromMap(jsonString);

import 'dart:convert';

ModelLogActivity modelLogActivityFromMap(String str) =>
    ModelLogActivity.fromMap(json.decode(str));

String modelLogActivityToMap(ModelLogActivity data) =>
    json.encode(data.toMap());

class ModelLogActivity {
  ModelLogActivity({
    this.data,
    this.message,
  });

  List<Datum>? data;
  String? message;

  factory ModelLogActivity.fromMap(Map<String, dynamic> json) =>
      ModelLogActivity(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message == null ? null : message,
      };
}

class Datum {
  Datum({
    this.category,
    this.device,
    this.createdAt,
  });

  String? category;
  String? device;
  String? createdAt;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        category: json["category"] == null ? null : json["category"],
        device: json["device"] == null ? null : json["device"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "category": category == null ? null : category,
        "device": device == null ? null : device,
        "created_at": createdAt == null ? null : createdAt,
      };
}
