// To parse this JSON data, do
//
//     final modelProvinsi = modelProvinsiFromMap(jsonString);

import 'dart:convert';

ModelWilayah modelProvinsiFromMap(String str) =>
    ModelWilayah.fromMap(json.decode(str));

String modelProvinsiToMap(ModelWilayah data) => json.encode(data.toMap());

class ModelWilayah {
  ModelWilayah({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory ModelWilayah.fromMap(Map<String, dynamic> json) => ModelWilayah(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
