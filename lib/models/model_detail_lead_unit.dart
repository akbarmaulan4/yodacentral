// To parse this JSON data, do
//
//     final modelLeadDetailUnit = modelLeadDetailUnitFromMap(jsonString);

import 'dart:convert';

import 'model_lead_search_financing.dart';
import 'model_wilayah.dart';

ModelLeadDetailUnit modelLeadDetailUnitFromMap(String str) =>
    ModelLeadDetailUnit.fromMap(json.decode(str));

String modelLeadDetailUnitToMap(ModelLeadDetailUnit data) =>
    json.encode(data.toMap());

class ModelLeadDetailUnit {
  ModelLeadDetailUnit({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelLeadDetailUnit.fromMap(Map<String, dynamic> json) =>
      ModelLeadDetailUnit(
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
    this.dataUnit,
    this.fotoUnit,
    this.spekUnit,
    this.lokasiUnit,
    this.dataPenjual,
    this.kontak_pic
  });

  DataUnit? dataUnit;
  List<String>? fotoUnit;
  SpekUnit? spekUnit;
  LokasiUnit? lokasiUnit;
  DataPenjual? dataPenjual;
  KontakPIC? kontak_pic;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        dataUnit: json["data_unit"] == null
            ? null
            : DataUnit.fromMap(json["data_unit"]),
        fotoUnit: json["foto_unit"] == null
            ? null
            : List<String>.from(json["foto_unit"].map((x) => x)),
        spekUnit: json["spek_unit"] == null
            ? null
            : SpekUnit.fromMap(json["spek_unit"]),
        lokasiUnit: json["lokasi_unit"] == null
            ? null
            : LokasiUnit.fromMap(json["lokasi_unit"]),
        dataPenjual: json["data_penjual"] == null
            ? null
            : DataPenjual.fromMap(json["data_penjual"]),
        kontak_pic: json["kontak_pic"] == null
            ? null
            : KontakPIC.fromMap(json["kontak_pic"]),
      );

  Map<String, dynamic> toMap() => {
        "data_unit": dataUnit == null ? null : dataUnit!.toMap(),
        "foto_unit": fotoUnit == null
            ? null
            : List<dynamic>.from(fotoUnit!.map((x) => x)),
        "spek_unit": spekUnit == null ? null : spekUnit!.toMap(),
        "lokasi_unit": lokasiUnit == null ? null : lokasiUnit!.toMap(),
        "data_penjual": dataPenjual == null ? null : dataPenjual!.toMap(),
        "kontak_pic": kontak_pic == null ? null : kontak_pic!.toMap(),
      };
}

class DataPenjual {
  DataPenjual({
    this.id,
    this.name,
    this.nomorTelepon,
    this.address,
    this.photo,
    this.provinsi,
    this.kotaKabupaten,
    this.kode,
    this.kecamatan,
    this.kabupaten,
    this.dataPenjualProvinsi,
    this.registerDate,
    this.registerTime,
  });

  int? id;
  String? name;
  String? nomorTelepon;
  String? address;
  String? photo;
  String? provinsi;
  String? kotaKabupaten;
  String? kode;
  String? kecamatan;
  String? kabupaten;
  String? dataPenjualProvinsi;
  String? registerDate;
  String? registerTime;

  factory DataPenjual.fromMap(Map<String, dynamic> json) => DataPenjual(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        nomorTelepon:
            json["Nomor Telepon"] == null ? null : json["Nomor Telepon"],
        address: json["address"] == null ? null : json["address"],
        photo: json["photo"] == null ? null : json["photo"],
        provinsi: json["Provinsi"] == null ? null : json["Provinsi"],
        kotaKabupaten:
            json["Kota/Kabupaten"] == null ? null : json["Kota/Kabupaten"],
        kode: json["kode"] == null ? null : json["kode"],
        kecamatan: json["kecamatan"] == null ? null : json["kecamatan"],
        kabupaten: json["kabupaten"] == null ? null : json["kabupaten"],
        dataPenjualProvinsi: json["provinsi"] == null ? null : json["provinsi"],
        registerDate:
            json["register_date"] == null ? null : json["register_date"],
        registerTime:
            json["register_time"] == null ? null : json["register_time"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "Nomor Telepon": nomorTelepon == null ? null : nomorTelepon,
        "address": address == null ? null : address,
        "photo": photo == null ? null : photo,
        "Provinsi": provinsi == null ? null : provinsi,
        "Kota/Kabupaten": kotaKabupaten == null ? null : kotaKabupaten,
        "kode": kode == null ? null : kode,
        "kecamatan": kecamatan == null ? null : kecamatan,
        "kabupaten": kabupaten == null ? null : kabupaten,
        "provinsi": dataPenjualProvinsi == null ? null : dataPenjualProvinsi,
        "register_date": registerDate == null ? null : registerDate,
        "register_time": registerTime == null ? null : registerTime,
      };
}

class DataUnit {
  DataUnit({
    this.name,
    this.note,
  });

  String? name;
  String? note;

  factory DataUnit.fromMap(Map<String, dynamic> json) => DataUnit(
        name: json["name"] == null ? null : json["name"],
        note: json["note"] == null ? null : json["note"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "note": note == null ? null : note,
      };
}

class LokasiUnit {
  LokasiUnit({
    this.provinsi,
    this.kotaKabupaten,
    this.kecamatan,
    this.kecamatan_id,
    this.cabangPengelola,
  });

  String? provinsi;
  String? kotaKabupaten;
  String? kecamatan;
  int? kecamatan_id;
  String? cabangPengelola;

  factory LokasiUnit.fromMap(Map<String, dynamic> json) => LokasiUnit(
        provinsi: json["Provinsi"] == null ? null : json["Provinsi"],
        kotaKabupaten: json["Kota/Kabupaten"] == null ? null : json["Kota/Kabupaten"],
        kecamatan: json["Kecamatan"] == null ? null : json["Kecamatan"],
        kecamatan_id: json["kecamatan_id"] == null ? null : json["kecamatan_id"],
        cabangPengelola: json["Cabang Pengelola"] == null ? null : json["Cabang Pengelola"],
      );

  Map<String, dynamic> toMap() => {
        "Provinsi": provinsi == null ? null : provinsi,
        "Kota/Kabupaten": kotaKabupaten == null ? null : kotaKabupaten,
        "Kecamatan": kecamatan == null ? null : kecamatan,
        "Cabang Pengelola": cabangPengelola == null ? null : cabangPengelola,
      };
}

class SpekUnit {
  SpekUnit({
    this.nomerPolisi,
    this.tahun,
    this.kondisi,
    this.merek,
    this.model,
    this.varian,
    this.jarakTempuh,
    this.bahanBakar,
    this.transmisi,
    this.warna,
    this.harga,
  });

  String? nomerPolisi;
  int? tahun;
  String? kondisi;
  String? merek;
  String? model;
  String? varian;
  String? jarakTempuh;
  String? bahanBakar;
  String? transmisi;
  String? warna;
  String? harga;

  factory SpekUnit.fromMap(Map<String, dynamic> json) => SpekUnit(
        nomerPolisi: json["Nomer Polisi"] == null ? null : json["Nomer Polisi"],
        tahun: json["Tahun"] == null ? null : json["Tahun"],
        kondisi: json["Kondisi"] == null ? null : json["Kondisi"].toString(),
        merek: json["Merek"] == null ? null : json["Merek"],
        model: json["Model"] == null ? null : json["Model"],
        varian: json["Varian"] == null ? null : json["Varian"],
        jarakTempuh: json["Jarak Tempuh"] == null ? null : json["Jarak Tempuh"],
        bahanBakar: json["Bahan Bakar"] == null ? null : json["Bahan Bakar"],
        transmisi: json["Transmisi"] == null ? null : json["Transmisi"],
        warna: json["Warna"] == null ? null : json["Warna"].toString(),
        harga: json["Harga"] == null ? null : json["Harga"],
      );

  Map<String, dynamic> toMap() => {
        "Nomer Polisi": nomerPolisi == null ? null : nomerPolisi,
        "Tahun": tahun == null ? null : tahun,
        "Kondisi": kondisi == null ? null : kondisi,
        "Merek": merek == null ? null : merek,
        "Model": model == null ? null : model,
        "Varian": varian == null ? null : varian,
        "Jarak Tempuh": jarakTempuh == null ? null : jarakTempuh,
        "Bahan Bakar": bahanBakar == null ? null : bahanBakar,
        "Transmisi": transmisi == null ? null : transmisi,
        "Warna": warna == null ? null : warna,
        "Harga": harga == null ? null : harga,
      };
}



class KontakPIC {
  KontakPIC({
    this.name_user,
    this.telp,
  });

  String? name_user;
  String? telp;

  factory KontakPIC.fromMap(Map<String, dynamic> json) => KontakPIC(
    name_user: json["name_user"] == null ? null : json["name_user"],
    telp: json["telp"] == null ? null : json["telp"],
  );

  Map<String, dynamic> toMap() => {
    "name_user": name_user == null ? null : name_user,
    "note": telp == null ? null : telp,
  };
}
