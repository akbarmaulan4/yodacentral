// To parse this JSON data, do
//
//     final modelDetailKredit = modelDetailKreditFromMap(jsonString);

import 'dart:convert';

ModelDetailKredit modelDetailKreditFromMap(String str) =>
    ModelDetailKredit.fromMap(json.decode(str));

String modelDetailKreditToMap(ModelDetailKredit data) =>
    json.encode(data.toMap());

class ModelDetailKredit {
  ModelDetailKredit({this.message, this.data});
  String? message;
  Data? data;

  factory ModelDetailKredit.fromMap(Map<String, dynamic> json) =>
      ModelDetailKredit(
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
    this.spekUnit,
    this.surat,
    this.domisiliSurat,
    this.photo_document,
    this.biaya,
    this.nasabah
  });

  SpekUnit? spekUnit;
  Surat? surat;
  DomisiliSurat? domisiliSurat;
  PhotoDocument? photo_document;
  Biaya? biaya;
  Nasabah? nasabah;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        spekUnit: json["spek_unit"] == null ? null : SpekUnit.fromMap(json["spek_unit"]),
        surat: json["surat"] == null ? null : Surat.fromMap(json["surat"]),
        domisiliSurat: json["domisili_surat"] == null ? null : DomisiliSurat.fromMap(json["domisili_surat"]),
        photo_document: json["photo_document"] == null ? null : PhotoDocument.fromMap(json["photo_document"]),
        biaya: json["biaya"] == null ? null : Biaya.fromMap(json["biaya"]),
        nasabah: json["nasabah"] == null ? null : Nasabah.fromMap(json["nasabah"]),
      );

  Map<String, dynamic> toMap() => {
        "spek_unit": spekUnit == null ? null : spekUnit!.toMap(),
        "surat": surat == null ? null : surat!.toMap(),
        "photo_document": photo_document == null ? null : photo_document!.toMap(),
        "biaya": biaya == null ? null : biaya!.toMap(),
        "nasabah": biaya == null ? null : nasabah!.toMap(),
      };
}

class PhotoDocument{
  PhotoDocument({
    this.document_jaminan,
    this.document_kontrak
});
  List<String>? document_kontrak;
  List<String>? document_jaminan;

  factory PhotoDocument.fromMap(Map<String, dynamic> json) => PhotoDocument(
    document_kontrak: json["document_kontrak"] == null ? null : List<String>.from(json["document_kontrak"].map((x) => x)),
    document_jaminan: json["document_jaminan"] == null ? null : List<String>.from(json["document_jaminan"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "document_kontrak": document_kontrak == null ? null : List<dynamic>.from(document_kontrak!.map((x) => x)),
    "document_jaminan": document_jaminan == null ? null : List<dynamic>.from(document_jaminan!.map((x) => x)),
  };
}

class Biaya {
  Biaya({
    this.hargaKendaraanBaru,
    this.hargaOnTheRoad,
    this.maxPembiayaanTrukKepu,
    this.dp,
    this.pokokPinjaman,
    this.bunga,
    this.sukuBungaFlat,
    this.sukuBungaEfektif,
    this.totalPinjaman,
    this.premiAsuransi,
    this.biayaAdministrasi,
    this.biayaFudicia,
    this.biayaProvisi,
    this.biayaSurveyVerifikasi,
    this.biayaNotaris,
    this.komisiSeller,
    this.totalBiaya,
    this.noKontrak,
    this.tenor,
    this.pembayaranAsuransi,
    this.kesertaanAsuransi,
    this.jenisAsuransi,
    this.angsuran,
    this.angsuranPertama,
    this.nilaiPertanggungan,
    this.nilaiPencairan,
    this.nilaiTotalDP,
    this.biayaTenor,
  });

  int? hargaKendaraanBaru;
  int? hargaOnTheRoad;
  int? maxPembiayaanTrukKepu;
  int? dp;
  int? pokokPinjaman;
  int? bunga;
  int? sukuBungaFlat;
  int? sukuBungaEfektif;
  int? totalPinjaman;
  int? premiAsuransi;
  int? biayaAdministrasi;
  int? biayaFudicia;
  int? biayaProvisi;
  int? biayaSurveyVerifikasi;
  int? biayaNotaris;
  int? komisiSeller;
  int? totalBiaya;
  String? noKontrak;
  String? tenor;
  String? pembayaranAsuransi;
  String? kesertaanAsuransi;
  String? jenisAsuransi;
  int? angsuran;
  String? angsuranPertama;
  String? nilaiPertanggungan;
  String? nilaiPencairan;
  int? nilaiTotalDP;
  String? biayaTenor;

  factory Biaya.fromMap(Map<String, dynamic> json) => Biaya(
        hargaKendaraanBaru: json["Harga kendaraan baru"] == null ? null : json["Harga kendaraan baru"],
        hargaOnTheRoad: json["Harga on the road"] == null ? null : json["Harga on the road"],
        maxPembiayaanTrukKepu: json["Max pembiayaan truk/kepu"] == null ? null : json["Max pembiayaan truk/kepu"],
        dp: json["DP"] == null ? null : json["DP"],
        pokokPinjaman: json["Pokok pinjaman"] == null ? null : json["Pokok pinjaman"],
        bunga: json["Bunga"] == null ? null : json["Bunga"],
        sukuBungaFlat: json["Suku bunga flat"] == null ? null : json["Suku bunga flat"],
        sukuBungaEfektif: json["Suku bunga efektif"] == null ? null : json["Suku bunga efektif"],
        totalPinjaman: json["Total pinjaman"] == null ? null : json["Total pinjaman"],
        premiAsuransi: json["Premi asuransi"] == null ? null : json["Premi asuransi"],
        biayaAdministrasi: json["Biaya administrasi"] == null ? null : json["Biaya administrasi"],
        biayaFudicia: json["Biaya fudicia"] == null ? null : json["Biaya fudicia"],
        biayaProvisi: json["Biaya provisi"] == null ? null : json["Biaya provisi"],
        biayaSurveyVerifikasi: json["Biaya survey & verifikasi"] == null ? null : json["Biaya survey & verifikasi"],
        biayaNotaris: json["Biaya notaris"] == null ? null : json["Biaya notaris"],
        komisiSeller: json["Komisi seller"] == null ? null : json["Komisi seller"],
        totalBiaya: json["Total biaya"] == null ? null : json["Total biaya"],
        noKontrak: json["No. Kontrak"] == null ? null : json["No. Kontrak"],
        tenor: json["Tenor"] == null ? null : json["Tenor"].toString(),
        pembayaranAsuransi: json["Pembayaran asuransi"] == null ? null : json["Pembayaran asuransi"].toString(),
        kesertaanAsuransi: json["Kesertaan asuransi"] == null ? null : json["Kesertaan asuransi"].toString(),
        jenisAsuransi: json["Jenis asuransi"] == null ? null : json["Jenis asuransi"].toString(),
        angsuran: json["Angsuran"] == null ? null : json["Angsuran"],
        angsuranPertama: json["Angsuran pertama"] == null ? null : json["Angsuran pertama"].toString(),
        nilaiPertanggungan: json["Nilai pertanggungan"] == null ? null : json["Nilai pertanggungan"].toString(),
        nilaiPencairan: json["Nilai pencairan"] == null ? null : json["Nilai pencairan"].toString(),
        nilaiTotalDP: json["Nilai Total DP"] == null ? null : json["Nilai Total DP"],
        biayaTenor: json["tenor"] == null ? null : json["tenor"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "Harga kendaraan baru": hargaKendaraanBaru == null ? null : hargaKendaraanBaru,
        "Harga on the road": hargaOnTheRoad == null ? null : hargaOnTheRoad,
        "Max pembiayaan truk/kepu": maxPembiayaanTrukKepu == null ? null : maxPembiayaanTrukKepu,
        "DP": dp == null ? null : dp,
        "Pokok pinjaman": pokokPinjaman == null ? null : pokokPinjaman,
        "Bunga": bunga == null ? null : bunga,
        "Suku bunga flat": sukuBungaFlat == null ? null : sukuBungaFlat,
        "Suku bunga efektif": sukuBungaEfektif == null ? null : sukuBungaEfektif,
        "Total pinjaman": totalPinjaman == null ? null : totalPinjaman,
        "Premi asuransi": premiAsuransi == null ? null : premiAsuransi,
        "Biaya administrasi": biayaAdministrasi == null ? null : biayaAdministrasi,
        "Biaya fudicia": biayaFudicia == null ? null : biayaFudicia,
        "Biaya provisi": biayaProvisi == null ? null : biayaProvisi,
        "Biaya survey & verifikasi": biayaSurveyVerifikasi == null ? null : biayaSurveyVerifikasi,
        "Biaya notaris": biayaNotaris == null ? null : biayaNotaris,
        "Komisi seller": komisiSeller == null ? null : komisiSeller,
        "Total biaya": totalBiaya == null ? null : totalBiaya,
        "No. Kontrak": noKontrak == null ? null : noKontrak,
        "Tenor": tenor == null ? null : tenor,
        "Pembayaran asuransi": pembayaranAsuransi == null ? null : pembayaranAsuransi,
        "Kesertaan asuransi": kesertaanAsuransi == null ? null : kesertaanAsuransi,
        "Jenis asuransi": jenisAsuransi == null ? null : jenisAsuransi,
        "Angsuran": angsuran == null ? null : angsuran,
        "Angsuran pertama": angsuranPertama == null ? null : angsuranPertama,
        "Nilai pertanggungan": nilaiPertanggungan == null ? null : nilaiPertanggungan,
        "Nilai pencairan": nilaiPencairan == null ? null : nilaiPencairan,
        "Nilai Total DP": nilaiTotalDP == null ? null : nilaiTotalDP,
        "tenor": biayaTenor == null ? null : biayaTenor,
      };
}

class SpekUnit {
  SpekUnit({
    this.nomerPolisi,
    this.kondisiMobil,
    this.merek,
    this.model,
    this.varian,
    this.warna,
    this.tahun,
    this.jenis,
    this.tujuanPenggunaan,
    this.kategori,
    this.nomorMesin,
    this.nomorRangka,
  });

  String? nomerPolisi;
  String? kondisiMobil;
  String? merek;
  String? model;
  String? varian;
  String? warna;
  int? tahun;
  String? jenis;
  String? tujuanPenggunaan;
  String? kategori;
  String? nomorMesin;
  String? nomorRangka;

  factory SpekUnit.fromMap(Map<String, dynamic> json) => SpekUnit(
        nomerPolisi: json["Nomer Polisi"] == null ? null : json["Nomer Polisi"],
        kondisiMobil: json["Kondisi mobil"] == null ? null : json["Kondisi mobil"].toString(),
        merek: json["Merek"] == null ? null : json["Merek"],
        model: json["Model"] == null ? null : json["Model"],
        varian: json["Varian"] == null ? null : json["Varian"],
        warna: json["Warna"] == null ? null : json["Warna"],
        tahun: json["Tahun"] == null ? null : json["Tahun"],
        jenis: json["Jenis"] == null ? null : json["Jenis"],
        tujuanPenggunaan: json["Tujuan penggunaan"] == null ? null : json["Tujuan penggunaan"],
        kategori: json["Kategori"] == null ? null : json["Kategori"].toString(),
        nomorMesin: json["Nomor mesin"] == null ? null : json["Nomor mesin"].toString(),
        nomorRangka: json["Nomor rangka"] == null ? null : json["Nomor rangka"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "Nomer Polisi": nomerPolisi == null ? null : nomerPolisi,
        "Kondisi mobil": kondisiMobil == null ? null : kondisiMobil,
        "Merek": merek == null ? null : merek,
        "Model": model == null ? null : model,
        "Varian": varian == null ? null : varian,
        "Warna": warna == null ? null : warna,
        "Tahun": tahun == null ? null : tahun,
        "Jenis": jenis == null ? null : jenis,
        "Tujuan penggunaan": tujuanPenggunaan == null ? null : tujuanPenggunaan,
        "Kategori": kategori == null ? null : kategori,
        "Nomor mesin": nomorMesin == null ? null : nomorMesin,
        "Nomor rangka": nomorRangka == null ? null : nomorRangka,
      };
}

class Surat {
  Surat({
    this.namaPemilikBpkb,
    this.nomorBpkb,
    this.tanggalBerlakuBpkb,
    this.masaBerlakuStnk,
    this.kotaTerbitBpk,
  });

  String? namaPemilikBpkb;
  String? nomorBpkb;
  String? kotaTerbitBpk;
  DateTime? tanggalBerlakuBpkb;
  DateTime? masaBerlakuStnk;

  factory Surat.fromMap(Map<String, dynamic> json) => Surat(
        namaPemilikBpkb: json["Nama pemilik BPKB"] == null ? null : json["Nama pemilik BPKB"],
        nomorBpkb: json["Nomor BPKB"] == null ? null : json["Nomor BPKB"],
        kotaTerbitBpk: json["Kota terbit BPK"] == null ? null : json["Kota terbit BPK"],
        tanggalBerlakuBpkb: json["Tanggal berlaku BPKB"] == null ? null : DateTime.parse(json["Tanggal berlaku BPKB"]),
        masaBerlakuStnk: json["Masa berlaku STNK"] == null ? null : DateTime.parse(json["Masa berlaku STNK"]),
      );

  Map<String, dynamic> toMap() => {
        "Nama pemilik BPKB": namaPemilikBpkb == null ? null : namaPemilikBpkb,
        "Nomor BPKB": nomorBpkb == null ? null : nomorBpkb,
        "Kota terbit BPK": kotaTerbitBpk == null ? null : kotaTerbitBpk,
        "Tanggal berlaku BPKB": tanggalBerlakuBpkb == null ? null : "${tanggalBerlakuBpkb!.year.toString().padLeft(4, '0')}-${tanggalBerlakuBpkb!.month.toString().padLeft(2, '0')}-${tanggalBerlakuBpkb!.day.toString().padLeft(2, '0')}",
        "Masa berlaku STNK": masaBerlakuStnk == null ? null : "${masaBerlakuStnk!.year.toString().padLeft(4, '0')}-${masaBerlakuStnk!.month.toString().padLeft(2, '0')}-${masaBerlakuStnk!.day.toString().padLeft(2, '0')}",
      };
}

class DomisiliSurat{
  DomisiliSurat({this.provinsi_id, this.provinsi, this.kabupaten_id, this.kabupaten}){}
  int? provinsi_id;
  String? provinsi;
  int? kabupaten_id;
  String? kabupaten ;

  factory DomisiliSurat.fromMap(Map<String, dynamic> json) => DomisiliSurat(
    provinsi_id: json["provinsi_id"] == null ? null : json["provinsi_id"],
    provinsi: json["provinsi"] == null ? null : json["provinsi"].toString(),
    kabupaten_id: json["kabupaten_id"] == null ? null : json["kabupaten_id"],
    kabupaten: json["kabupaten"] == null ? null : json["kabupaten"].toString()
  );

  Map<String, dynamic> toMap() => {
    "provinsi_id": provinsi_id == null ? null : provinsi_id,
    "provinsi": provinsi == null ? null : provinsi,
    "kabupaten_id": kabupaten_id == null ? null : kabupaten_id,
    "kabupaten": kabupaten_id == null ? null : kabupaten,
  };
}

class Nasabah{
  Nasabah({this.name, this.telp});
  String? name;
  String? telp;

  factory Nasabah.fromMap(Map<String, dynamic> json) => Nasabah(
    name: json["name"] == null ? null : json["name"].toString(),
    telp: json["telp"] == null ? null : json["telp"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? '' : name,
    "telp": telp == null ? '' : telp,
  };

}
