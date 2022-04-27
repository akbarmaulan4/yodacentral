// To parse this JSON data, do
//
//     final modelSellerSearch = modelSellerSearchFromMap(jsonString);

import 'dart:convert';

ModelSellerSearch modelSellerSearchFromMap(String str) =>
    ModelSellerSearch.fromMap(json.decode(str));

String modelSellerSearchToMap(ModelSellerSearch data) =>
    json.encode(data.toMap());

class ModelSellerSearch {
  ModelSellerSearch({
    this.message,
    this.total,
    this.data,
  });

  String? message;
  int? total;
  List<Datum>? data;

  factory ModelSellerSearch.fromMap(Map<String, dynamic> json) =>
      ModelSellerSearch(
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
    this.address,
    this.telp,
    this.photo,
    this.kode,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.registerDate,
    this.registerTime,
  });

  int? id;
  String? name;
  String? address;
  String? telp;
  String? photo;
  String? kode;
  String? kecamatan;
  String? kabupaten;
  String? provinsi;
  String? registerDate;
  String? registerTime;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        telp: json["telp"] == null ? null : json["telp"],
        photo: json["photo"] == null ? null : json["photo"],
        kode: json["kode"] == null ? null : json["kode"],
        kecamatan: json["kecamatan"] == null ? null : json["kecamatan"],
        kabupaten: json["kabupaten"] == null ? null : json["kabupaten"],
        provinsi: json["provinsi"] == null ? null : json["provinsi"],
        registerDate:
            json["register_date"] == null ? null : json["register_date"],
        registerTime:
            json["register_time"] == null ? null : json["register_time"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "telp": telp == null ? null : telp,
        "photo": photo == null ? null : photo,
        "kode": kode == null ? null : kode,
        "kecamatan": kecamatan == null ? null : kecamatan,
        "kabupaten": kabupaten == null ? null : kabupaten,
        "provinsi": provinsi == null ? null : provinsi,
        "register_date": registerDate == null ? null : registerDate,
        "register_time": registerTime == null ? null : registerTime,
      };
}
