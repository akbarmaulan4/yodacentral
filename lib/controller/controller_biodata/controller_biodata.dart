import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';

import '../../screens/login/data_diri.dart/upload_foto_profil_/upload_foto_profil.dart';
import '../../screens/login/data_diri.dart/upload_foto_profil_/waiting_verification.dart';

class ControllerBiodata extends GetxController {
  String? token;
  String? namaLengkap;
  String? nomerTlp;
  String? imageProfile;

  String? messageTlp;

  setToken({required String tokenRegis}) {
    token = tokenRegis;
    log(tokenRegis);
    update();
  }

  setNamaTlp({
    required String namaLengkapRegis,
    required String nomerTlpRegis,
  }) {
    namaLengkap = namaLengkapRegis;
    nomerTlp = nomerTlpRegis;
    log(namaLengkap! + " | " + nomerTlpRegis);
    update();
  }

  // setImageProfile({required String path}) async {
  //   imageProfile = await path;

  //   // uploadBiodata();

  //   log(path);
  //   update();
  // }

  cekNomerTlp({
    required String nomerTlp,
    required String nama,
  }) async {
    messageTlp = null;
    modalLoad();
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.cekNomerTlp.toString()}';
    var res = await http.post(Uri.parse(url.trim()), body: {'telp': nomerTlp.toString(),}, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    log(nomerTlp.toString());

    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      log(res.body);
      messageTlp = null;
      setNamaTlp(namaLengkapRegis: nama, nomerTlpRegis: nomerTlp);
      Get.to(
        () => UploadFotoProfil(),
        transition: Transition.noTransition,
      );
      update();
    } else if (res.statusCode == 422) {
      if (Get.isBottomSheetOpen == true) Get.back();

      log(res.body);
      messageTlp = json.decode(res.body)["message"];
      update();
    }
    update();
  }

  uploadBiodata({required String path}) async {
    modalLoad();
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${value.token}";
    var headers = {"Authorization": bar,};
    var url = '${ApiUrl.domain.toString()}${ApiUrl.registerBiodata.toString()}';
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    request.fields.addAll({
      'name': namaLengkap!,
      'token': token!,
      'telp': nomerTlp!,
    });
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('photo_profile', path));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      log(respStr);
      if (Get.isBottomSheetOpen == true) Get.back();
      log("sukses");
      SaveRootDaftar.deleteSaveRootRegis();

      Get.offAll(
        WaitingVerification(),
      );
      print(await response.stream.bytesToString());
      update();
    } else {
      final respStr = await response.stream.bytesToString();
      log(respStr);
      if (Get.isBottomSheetOpen == true) Get.back();
      log(request.fields.toString(), name: "ini data diri");
      log(request.files[0].filename! + " " + path, name: "ini data diri foro");
      rawBottomNotif(
        message: "Gagal unggah data diri | " + response.statusCode.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );

      log("tidak sukses");
      print(response.reasonPhrase);
      update();
    }
    update();
  }
}
