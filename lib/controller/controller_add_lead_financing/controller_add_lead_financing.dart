import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/add_seller_baru_review.dart';
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';
import 'package:yodacentral/utils/utils.dart';

class ControllerAddLeadFinancing extends GetxController {
  String? nomorPolisi1;
  Datum? kondisiMobil1;
  Datum? merek1;
  Datum? model1;
  Datum? varian1;
  Datum? tahun1;
  Datum? jarakTempuh1;
  Datum? bahanBakar1;
  Datum? transmisi1;
  Datum? warna1;
  String? catatan1;
  String? harga1;
  Datum? provinsi1;
  Datum? kotaKabupaten1;
  Datum? kecamatan1;
  DataSeller? dataSeller1;

  //////nasabah
  String? namaNasabah;
  String? nomorKtpNasabah;
  String? nomorTlpNasabah;

  Datum? provinsiNasabah1;
  Datum? kotaKabupatenNasabah1;
  Datum? kecamatanNasabah1;

  List<File>? listFoto1;

  ////seler baru
  String? namaSeller;
  String? nomorSeller;
  String? alamatSeller;
  Datum? provinsiSeller;
  Datum? kotaKabupatenSeller;
  Datum? kecamatanSeller;
  File? fotoSeller;

  TextEditingController edtNopol = TextEditingController();
  // var nopolFormat = new MaskTextInputFormatter(
  //   // mask: '+# (###) ###-##-##',
  //     mask: '##.###.###.#-###.###',
  //     filter: { "#": RegExp(r'[0-9]') },
  //     type: MaskAutoCompletionType.lazy
  // );

  inputSellerBaru(
      {required String namaSellerA,
      required String nomorSellerA,
      required Datum provinsiSellerA,
      required Datum kotaKabupatenSellerA,
      required Datum kecamatanSellerA,
      required File fotoSellerA,
      required String alamatA}) {
    namaSeller = namaSellerA;
    nomorSeller = nomorSellerA;
    provinsiSeller = provinsiSellerA;
    kotaKabupatenSeller = kotaKabupatenSellerA;
    kecamatanSeller = kecamatanSellerA;
    fotoSeller = fotoSellerA;
    alamatSeller = alamatA;
    Get.to(() => AddSellerBaruReview(), transition: Transition.noTransition);

    // createSeller();

    log("simpan seller baru");

    update();
  }

  inputNopol({required String nopol}) {
    nomorPolisi1 = nopol;
    update();
  }

  inputSeller({DataSeller? dataSeller}) {
    dataSeller1 = dataSeller;
    log("ini data seller");
    log(dataSeller!.provinsi!);
    update();
  }

  inputAll({
    required String nomorPolisi,
    required Datum kondisiMobil,
    required Datum merek,
    required Datum model,
    required Datum varian,
    required Datum tahun,
    required Datum jarakTempuh,
    required Datum bahanBakar,
    required Datum transmisi,
    required Datum warna,
    String? catatan,
    required String harga,
    required Datum provinsi,
    required Datum kotaKabupaten,
    required Datum kecamatan,
  }) {
    nomorPolisi1 = nomorPolisi;
    kondisiMobil1 = kondisiMobil;
    merek1 = merek;
    model1 = model;
    varian1 = varian;
    tahun1 = tahun;
    jarakTempuh1 = jarakTempuh;
    bahanBakar1 = bahanBakar;
    transmisi1 = transmisi;
    warna1 = warna;
    catatan1 = catatan ?? "--";
    harga1 = harga;
    provinsi1 = provinsi;
    kotaKabupaten1 = kotaKabupaten;
    kecamatan1 = kecamatan;

    log("simpan data mobil");

    update();
  }

  inputListFoto({required List<File> listFoto}) {
    listFoto1 = listFoto;
    log(listFoto1!.length.toString(), name: "ini simpan foto mobil");
    log("simpan foto");
    update();
  }

  inputDataNasabah(
      {required Datum provinsi,
      required Datum kotaKabupaten,
      required Datum kecamatan,
      required String nama,
      required String nomorKtp,
      required String nomorTlp}) {
    namaNasabah = nama;
    nomorKtpNasabah = nomorKtp;
    nomorTlpNasabah = nomorTlp;
    provinsiNasabah1 = provinsi;
    kotaKabupatenNasabah1 = kotaKabupaten;
    kecamatanNasabah1 = kecamatan;

    log("simpan data nasabah");

    update();
  }

  uploadAddleadAndSeller() {}

  updalodAddLead({required bool sellerBaru}) async {
    log(catatan1.toString(), name: "ini catatan");
    log(model1!.id.toString() + " " + model1!.name.toString(),
        name: "type_body_id");
    log(merek1!.id.toString() + " " + merek1!.name.toString(),
        name: "car_category_id");
    log(varian1!.id.toString() + " " + varian1!.name.toString(),
        name: "ini varian mobil");
    modalLoad();
    var a = harga1!.split(",");

    String finalStr = a.reduce((value, element) {
      return value + element;
    });

    SaveRoot.callSaveRoot().then((value) async {
      log(value.token.toString(), name: "ini token");
      String bar = "Bearer ${value.token}";
      // try {
      var headers = {
        "Authorization": bar,
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiUrl.domain.toString()}/api/lead'));
      print('URL ${ApiUrl.domain.toString()}/api/lead');
      if (sellerBaru == true) {
        request.fields.addAll({
          'police_number': nomorPolisi1.toString(),
          'condition_id': kondisiMobil1!.id.toString(),
          'variant_id': varian1!.id.toString(),
          'mileage_id': jarakTempuh1!.id.toString(),
          'fuel_id': bahanBakar1!.id.toString(),
          'transmission_id': transmisi1!.id.toString(),
          'color_id': warna1!.id.toString(),
          'type_body_id': model1!.id.toString(),
          'intended_use_id': '4',
          'car_category_id': merek1!.id.toString(),
          'note': catatan1 == null ? "---" : catatan1.toString(),
          'price': finalStr,
          'year': tahun1!.name.toString(),
          'kecamatan_id': kecamatan1!.id.toString(),
          // 'seller_id': sellerBaru
          //     ? modelReturnAddSeller!.data!.id.toString()
          //     : dataSeller1!.id.toString(),
          'category': 'Financing',
          'nama_penjual': namaSeller.toString(),
          'alamat_penjual': alamatSeller.toString(),
          'telp_penjual': nomorSeller!,
          'kecamatan_penjual': kecamatanSeller!.id.toString(),
        });
      } else {
        request.fields.addAll({
          'police_number': nomorPolisi1.toString(),
          'condition_id': kondisiMobil1!.id.toString(),
          'variant_id': varian1!.id.toString(),
          'mileage_id': jarakTempuh1!.id.toString(),
          'fuel_id': bahanBakar1!.id.toString(),
          'transmission_id': transmisi1!.id.toString(),
          'color_id': warna1!.id.toString(),
          'type_body_id': model1!.id.toString(),
          'intended_use_id': '4',
          'car_category_id': merek1!.id.toString(),
          'note': catatan1 == null ? "---" : catatan1.toString(),
          'price': finalStr,
          'year': tahun1!.name.toString(),
          'kecamatan_id': kecamatan1!.id.toString(),
          'seller_id': dataSeller1!.id.toString(),
          'category': 'Financing'
        });
      }

      for (var i = 0; i < listFoto1!.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'photo_unit[$i]', listFoto1![i].path));
        log(request.files[i].filename.toString());
      }

      request.headers.addAll(headers);
      log(request.headers.toString(), name: "ini auth");
      log(jsonEncode(request.fields.toString()), name: "ini data");
      log("ini upload");
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        if (Get.isBottomSheetOpen == true) Get.back();
        print(await response.stream.bytesToString());
        // for (var i = 0; i < 5; i++) {
        //   Get.back();
        // }

        // Get.offAll(() => Wraping());
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Lead Telah Berhasil Diiklankan",
            content: "Cek leadmu pada menu Dasbor. Jika terjadi masalah, silahkan hubungi Customer Relation.",
            onTap: () {
              // Utils.saveUpdatePipeline(true);
              sellerBaru ? Get.back() : Get.back();
              Get.offAll(() => Wraping());
            },
            textButton: "Selesai",
          ),
          isScrollControlled: true,
        );
        // update();
      } else {
        if (Get.isBottomSheetOpen == true) Get.back();
        log(await response.stream.bytesToString());
        if (Get.isBottomSheetOpen == true) Get.back();
        rawBottomNotif(
          message: response.statusCode.toString() +
              " | " +
              await response.stream.asBroadcastStream().isBroadcast.toString(),
          colorFont: Colors.white,
          backGround: Colors.red,
        );
        log(response.statusCode.toString());
        log(response.reasonPhrase.toString());
        log(await response.stream.bytesToString());

        // update();
      }
    });

    // update();
  }

  addLeadRefinancing() async {
    modalLoad();
    SaveRoot.callSaveRoot().then((value) async {
      log(value.token.toString(), name: "ini token");
      String bar = "Bearer ${value.token}";
      // try {
      var headers = {
        "Authorization": bar,
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiUrl.domain.toString()}/api/lead'));
      request.fields.addAll({
        'police_number': nomorPolisi1.toString(),
        'condition_id': kondisiMobil1!.id.toString(),
        'variant_id': varian1!.id.toString(),
        'mileage_id': jarakTempuh1!.id.toString(),
        'fuel_id': bahanBakar1!.id.toString(),
        'transmission_id': transmisi1!.id.toString(),
        'color_id': warna1!.id.toString(),
        'type_body_id': model1!.id.toString(),
        'intended_use_id': '4',
        'car_category_id': merek1!.id.toString(),
        'note': catatan1 == null ? "---" : catatan1.toString(),
        'price': harga1!.replaceAll(",", ""),
        'year': tahun1!.name.toString(),
        'kecamatan_id': kecamatan1!.id.toString(),
        'name': namaNasabah.toString(),
        'nik': nomorKtpNasabah!.replaceAll(" ", ""),
        'telp': nomorTlpNasabah.toString(),
        'nasabah_kecamatan_id': kecamatanNasabah1!.id.toString(),
        'category': 'Refinancing',
      });
      for (var i = 0; i < listFoto1!.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'photo_unit[$i]', listFoto1![i].path));
        log(request.files[i].filename.toString());
      }

      request.headers.addAll(headers);
      log(request.headers.toString(), name: "ini auth");
      log(request.fields.toString(), name: "ini data");
      log("ini upload");
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        if (Get.isBottomSheetOpen == true) Get.back();
        print(await response.stream.bytesToString());
        // for (var i = 0; i < 5; i++) {
        //   Get.back();
        // }

        // Get.offAll(() => Wraping());
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Lead Telah Berhasil Diiklankan",
            content:
                "Cek leadmu pada menu Dasbor. Jika terjadi masalah, silahkan hubungi Customer Relation.",
            onTap: () {
              Get.back();
              Get.offAll(() => Wraping());
            },
            textButton: "Selesai",
          ),
          isScrollControlled: true,
        );
        update();
      } else {
        log(await response.stream.bytesToString());
        if (Get.isBottomSheetOpen == true) Get.back();
        rawBottomNotif(
          message: response.statusCode.toString() + " | " + "gagal",
          colorFont: Colors.white,
          backGround: Colors.red,
        );
        log(response.statusCode.toString());
        log(response.reasonPhrase.toString());
        log(await response.stream.toString());

        update();
      }
    });
  }
}

class DataSeller {
  DataSeller({
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
}

// To parse this JSON data, do
//
//     final modelReturnAddSeller = modelReturnAddSellerFromMap(jsonString);

ModelReturnAddSeller modelReturnAddSellerFromMap(String str) =>
    ModelReturnAddSeller.fromMap(json.decode(str));

String modelReturnAddSellerToMap(ModelReturnAddSeller data) =>
    json.encode(data.toMap());

class ModelReturnAddSeller {
  ModelReturnAddSeller({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelReturnAddSeller.fromMap(Map<String, dynamic> json) =>
      ModelReturnAddSeller(
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
    this.name,
    this.address,
    this.telp,
    this.photo,
    this.id,
    this.kode,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.registerDate,
    this.registerTime,
  });

  String? name;
  String? address;
  String? telp;
  String? photo;
  int? id;
  String? kode;
  String? kecamatan;
  String? kabupaten;
  String? provinsi;
  String? registerDate;
  String? registerTime;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        telp: json["telp"] == null ? null : json["telp"],
        photo: json["photo"] == null ? null : json["photo"],
        id: json["id"] == null ? null : json["id"],
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
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "telp": telp == null ? null : telp,
        "photo": photo == null ? null : photo,
        "id": id == null ? null : id,
        "kode": kode == null ? null : kode,
        "kecamatan": kecamatan == null ? null : kecamatan,
        "kabupaten": kabupaten == null ? null : kabupaten,
        "provinsi": provinsi == null ? null : provinsi,
        "register_date": registerDate == null ? null : registerDate,
        "register_time": registerTime == null ? null : registerTime,
      };
}
