// To parse this JSON data, do
//
//     final modelDetailNasabah = modelDetailNasabahFromMap(jsonString);

import 'dart:convert';

ModelDetailNasabah modelDetailNasabahFromMap(String str) =>
    ModelDetailNasabah.fromMap(json.decode(str));

String modelDetailNasabahToMap(ModelDetailNasabah data) =>
    json.encode(data.toMap());

class ModelDetailNasabah {
  ModelDetailNasabah({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelDetailNasabah.fromMap(Map<String, dynamic> json) =>
      ModelDetailNasabah(
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
    this.identitas,
    this.pasangan,
    this.domisili,
    this.document,
    this.penjamin,
    this.pekerjaan
  });

  Identitas? identitas;
  dynamic pasangan;
  Domisili? domisili;
  Document? document;
  dynamic penjamin;
  Pekerjaan? pekerjaan;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        identitas: json["identitas"] == null ? null : Identitas.fromMap(json["identitas"]),
        pasangan: json["pasangan"],
        domisili: json["domisili"] == null ? null : Domisili.fromMap(json["domisili"]),
        document: json["document"] == null ? null : Document.fromMap(json["document"]),
        penjamin: json["data_penjamin"],
        pekerjaan: json["pekerjaan_nasabah"] == null ? null : Pekerjaan.fromMap(json["pekerjaan_nasabah"]),
      );

  Map<String, dynamic> toMap() => {
        "identitas": identitas == null ? null : identitas!.toMap(),
        "pasangan": pasangan,
        "domisili": domisili == null ? null : domisili!.toMap(),
        "document": document == null ? null : document!.toMap(),
        "data_penjamin": penjamin,
      };
}

class Document {
  Document({
    this.kelengkapan,
    this.photoDocument,
    this.photo_nasabah,
  });

  String? kelengkapan;
  List<String>? photoDocument;
  String? photo_nasabah;

  factory Document.fromMap(Map<String, dynamic> json) => Document(
        kelengkapan: json["kelengkapan"] == null ? null : json["kelengkapan"],
        photoDocument: json["photo_document"] == null ? null : List<String>.from(json["photo_document"].map((x) => x)),
        photo_nasabah: json["photo_nasabah"] == null ? null : json["photo_nasabah"],
      );

  Map<String, dynamic> toMap() => {
        "kelengkapan": kelengkapan == null ? null : kelengkapan,
        "photo_document": photoDocument == null ? null : List<dynamic>.from(photoDocument!.map((x) => x)),
        "photo_nasabah": kelengkapan == null ? null : kelengkapan,
      };
}

class Domisili {
  Domisili({
    this.alamatKtp,
    this.provinsi,
    this.kotaKabupaten,
    this.kecamatan,
    this.kelurahan,
    this.rw,
    this.rt,
    this.kodePos,
    this.noTlpRumah,
    this.catatan
  });

  String? alamatKtp;
  String? provinsi;
  String? kotaKabupaten;
  String? kecamatan;
  String? kelurahan;
  String? rw;
  String? rt;
  String? kodePos;
  String? noTlpRumah;
  String? catatan;

  factory Domisili.fromMap(Map<String, dynamic> json) => Domisili(
        alamatKtp: json["Alamat KTP"] == null ? null : json["Alamat KTP"],
        provinsi: json["Provinsi"] == null ? null : json["Provinsi"].toString(),
        kotaKabupaten: json["Kota/Kabupaten"] == null ? null : json["Kota/Kabupaten"].toString(),
        kecamatan: json["Kecamatan"] == null ? null : json["Kecamatan"].toString(),
        kelurahan: json["Kelurahan"] == null ? null : json["Kelurahan"].toString(),
        rw: json["RW"] == null ? null : json["RW"],
        rt: json["RT"] == null ? null : json["RT"],
        kodePos: json["Kode pos"] == null ? null : json["Kode pos"],
        noTlpRumah: json["Nomor Telepon Rumah"] == null ? null : json["Nomor Telepon Rumah"],
        catatan:json["Catatan Domisili"] == null ? null : json["Catatan Domisili"]
      );

  Map<String, dynamic> toMap() => {
        "Alamat KTP": alamatKtp == null ? null : alamatKtp,
        "Provinsi": provinsi == null ? null : provinsi,
        "Kota/Kabupaten": kotaKabupaten == null ? null : kotaKabupaten,
        "Kecamatan": kecamatan == null ? null : kecamatan,
        "Kelurahan": kelurahan == null ? null : kelurahan,
        "RW": rw == null ? null : rw,
        "RT": rt == null ? null : rt,
        "Kode pos": kodePos == null ? null : kodePos,
        "Nomor Telepon Rumah": noTlpRumah == null ? null : noTlpRumah,
        "Catatan Domisili": catatan == null ? null : catatan,
      };
}

class Identitas {
  Identitas({
    this.namaLengkapSesuaiKtp,
    this.nomorTelepon,
    this.noKtp,
    this.jenisKelamin,
    this.statusPernikahan,
    this.gelarNasabah,
    this.namaGadisIbuKandung,
    this.noNpwp,
    this.tempatLahir,
    this.tglTerbitKTP,
    this.tanggalLahirDdMmYyyy,
    this.catatan
  });

  String? namaLengkapSesuaiKtp;
  String? nomorTelepon;
  String? noKtp;
  String? jenisKelamin;
  String? statusPernikahan;
  String? gelarNasabah;
  String? namaGadisIbuKandung;
  String? noNpwp;
  String? tempatLahir;
  String? tglTerbitKTP;
  DateTime? tanggalLahirDdMmYyyy;
  String? catatan;

  factory Identitas.fromMap(Map<String, dynamic> json) => Identitas(
        namaLengkapSesuaiKtp: json["Nama lengkap sesuai KTP"] == null ? null : json["Nama lengkap sesuai KTP"],
        nomorTelepon: json["Nomor telepon"] == null ? null : json["Nomor telepon"],
        noKtp: json["No. KTP"] == null ? null : json["No. KTP"],
        jenisKelamin: json["Jenis kelamin"] == null ? null : json["Jenis kelamin"],
        statusPernikahan: json["Status pernikahan"] == null ? null : json["Status pernikahan"].toString(),
        gelarNasabah: json["Gelar nasabah"] == null ? null : json["Gelar nasabah"],
        namaGadisIbuKandung: json["Nama gadis ibu kandung"] == null ? null : json["Nama gadis ibu kandung"],
        noNpwp: json["No. NPWP"] == null ? null : json["No. NPWP"],
        tempatLahir: json["Tempat lahir"] == null ? null : json["Tempat lahir"],
        tglTerbitKTP: json["Tanggal terbit KTP"] == null ? null : json["Tanggal terbit KTP"].toString(),
        tanggalLahirDdMmYyyy: json["Tanggal lahir (dd/mm/yyyy)"] == 0
            ? null
            : json["Tanggal lahir (dd/mm/yyyy)"] == 0 ? DateTime.now() : DateTime.parse(json["Tanggal lahir (dd/mm/yyyy)"]),

        catatan: json["Catatan Nasabah"] == null ? null : json["Catatan Nasabah"],
      );

  Map<String, dynamic> toMap() => {
        "Nama lengkap sesuai KTP":
            namaLengkapSesuaiKtp == null ? null : namaLengkapSesuaiKtp,
        "Nomor telepon": nomorTelepon == null ? null : nomorTelepon,
        "No. KTP": noKtp == null ? null : noKtp,
        "Jenis kelamin": jenisKelamin == null ? null : jenisKelamin,
        "Status pernikahan": statusPernikahan == null ? null : statusPernikahan,
        "Gelar nasabah": gelarNasabah == null ? null : gelarNasabah,
        "Nama gadis ibu kandung":
            namaGadisIbuKandung == null ? null : namaGadisIbuKandung,
        "No. NPWP": noNpwp == null ? null : noNpwp,
        "Tempat lahir": tempatLahir == null ? null : tempatLahir,
        "Tanggal terbit KTPr": tglTerbitKTP == null ? null : tglTerbitKTP,
        "Tanggal lahir (dd/mm/yyyy)": tanggalLahirDdMmYyyy == null
            ? null
            : "${tanggalLahirDdMmYyyy!.year.toString().padLeft(4, '0')}-${tanggalLahirDdMmYyyy!.month.toString().padLeft(2, '0')}-${tanggalLahirDdMmYyyy!.day.toString().padLeft(2, '0')}",

        "Catatan Nasabah": catatan == null ? null : catatan,
  };
}

class Pekerjaan {
  Pekerjaan({
    this.pekerjaan,
    this.nama_institusi,
    this.jabatan,
    this.lama_bekerja,
    this.nomor_tlp_inst,
    this.alamat_inst,
    this.catatan_kerja,
  });

  String? pekerjaan;
  String? nama_institusi;
  String? jabatan;
  String? lama_bekerja;
  String? nomor_tlp_inst;
  String? alamat_inst;
  String? catatan_kerja;

  factory Pekerjaan.fromMap(Map<String, dynamic> json) => Pekerjaan(
    pekerjaan: json["Pekerjaan"] == null ? null : json["Pekerjaan"],
    nama_institusi: json["Nama Institusi"] == null ? null : json["Nama Institusi"],
    jabatan: json["Jabatan"] == null ? null : json["Jabatan"],
    lama_bekerja: json["Lama Bekerja"] == null ? null : json["Lama Bekerja"],
    nomor_tlp_inst: json["Nomor Telepon Institusi"] == null ? null : json["Nomor Telepon Institusi"],
    alamat_inst: json["Alamat Institusi"] == null ? null : json["Alamat Institusi"],
    catatan_kerja: json["Catatan Pekerjaan"] == null ? null : json["Catatan Pekerjaan"],
  );

  Map<String, dynamic> toMap() => {
    "Pekerjaan": pekerjaan == null ? null : pekerjaan,
    "Nama Institusi": nama_institusi == null ? null : nama_institusi,
    "Jabatan": jabatan == null ? null : jabatan,
    "Lama Bekerja": lama_bekerja == null ? null : lama_bekerja,
    "Nomor Telepon Institusi": nomor_tlp_inst == null ? null : nomor_tlp_inst,
    "Alamat Institusi": alamat_inst == null ? null : alamat_inst,
    "Catatan Pekerjaan": catatan_kerja == null ? null : catatan_kerja,
  };
}
