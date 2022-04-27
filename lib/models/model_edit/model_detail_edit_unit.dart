// To parse this JSON data, do
//
//     final modelDetailEditUnit = modelDetailEditUnitFromMap(jsonString);

import 'dart:convert';

ModelDetailEditUnit modelDetailEditUnitFromMap(String str) =>
    ModelDetailEditUnit.fromMap(json.decode(str));

String modelDetailEditUnitToMap(ModelDetailEditUnit data) =>
    json.encode(data.toMap());

class ModelDetailEditUnit {
  ModelDetailEditUnit({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelDetailEditUnit.fromMap(Map<String, dynamic> json) =>
      ModelDetailEditUnit(
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
    this.id,
    this.numberPolice,
    this.kondisi,
    this.merek,
    this.model,
    this.varian,
    this.tahun,
    this.jarakTempuh,
    this.bahanBakar,
    this.transmisi,
    this.warna,
    this.catatan,
    this.harga,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.tipeBody,
    this.tujuanPenggunaan,
    this.kategori,
  });

  String? id;
  String? numberPolice;
  BahanBakar? kondisi;
  BahanBakar? merek;
  BahanBakar? model;
  BahanBakar? varian;
  int? tahun;
  BahanBakar? jarakTempuh;
  BahanBakar? bahanBakar;
  BahanBakar? transmisi;
  BahanBakar? warna;
  String? catatan;
  int? harga;
  BahanBakar? kecamatan;
  BahanBakar? kabupaten;
  BahanBakar? provinsi;
  BahanBakar? tipeBody;
  BahanBakar? tujuanPenggunaan;
  BahanBakar? kategori;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        numberPolice: json["number_police"] == null ? null : json["number_police"],
        kondisi: json["kondisi"] == null ? null : BahanBakar.fromMap(json["kondisi"]),
        merek: json["merek"] == null ? null : BahanBakar.fromMap(json["merek"]),
        model: json["model"] == null ? null : BahanBakar.fromMap(json["model"]),
        varian: json["varian"] == null ? null : BahanBakar.fromMap(json["varian"]),
        tahun: json["Tahun"] == null ? null : json["Tahun"],
        jarakTempuh: json["jarak_tempuh"] == null ? null : BahanBakar.fromMap(json["jarak_tempuh"]),
        bahanBakar: json["bahan_bakar"] == null ? null : BahanBakar.fromMap(json["bahan_bakar"]),
        transmisi: json["transmisi"] == null ? null : BahanBakar.fromMap(json["transmisi"]),
        warna: json["warna"] == null ? null : BahanBakar.fromMap(json["warna"]),
        catatan: json["catatan"] == null ? null : json["catatan"],
        harga: json["harga"] == null ? null : json["harga"],
        kecamatan: json["kecamatan"] == null ? null : BahanBakar.fromMap(json["kecamatan"]),
        kabupaten: json["kabupaten"] == null ? null : BahanBakar.fromMap(json["kabupaten"]),
        provinsi: json["provinsi"] == null ? null : BahanBakar.fromMap(json["provinsi"]),
        tipeBody: json["tipe_body"] == null ? null : BahanBakar.fromMap(json["tipe_body"]),
        tujuanPenggunaan: json["tujuan_penggunaan"] == null ? null : BahanBakar.fromMap(json["tujuan_penggunaan"]),
        kategori: json["kategori"] == null ? null : BahanBakar.fromMap(json["kategori"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "number_police": numberPolice == null ? null : numberPolice,
        "kondisi": kondisi == null ? null : kondisi!.toMap(),
        "merek": merek == null ? null : merek!.toMap(),
        "model": model == null ? null : model!.toMap(),
        "varian": varian == null ? null : varian!.toMap(),
        "Tahun": tahun == null ? null : tahun,
        "jarak_tempuh": jarakTempuh == null ? null : jarakTempuh!.toMap(),
        "bahan_bakar": bahanBakar == null ? null : bahanBakar!.toMap(),
        "transmisi": transmisi == null ? null : transmisi!.toMap(),
        "warna": warna == null ? null : warna!.toMap(),
        "catatan": catatan == null ? null : catatan,
        "harga": harga == null ? null : harga,
        "kecamatan": kecamatan == null ? null : kecamatan!.toMap(),
        "kabupaten": kabupaten == null ? null : kabupaten!.toMap(),
        "provinsi": provinsi == null ? null : provinsi!.toMap(),
        "tipe_body": tipeBody == null ? null : tipeBody!.toMap(),
        "tujuan_penggunaan":
            tujuanPenggunaan == null ? null : tujuanPenggunaan!.toMap(),
        "kategori": kategori == null ? null : kategori!.toMap(),
      };
}

class BahanBakar {
  BahanBakar({
    this.id,
    this.value,
  });

  int? id;
  String? value;

  factory BahanBakar.fromMap(Map<String, dynamic> json) => BahanBakar(
        id: json["id"] == null ? -1 : json["id"],
        value: json["value"] == null ? '' : json["value"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? -1 : id,
        "value": value == null ? '' : value,
      };
}
