import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/modal_Load.dart';
// import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/controller/controller_biodata/controller_biodata.dart';
import 'package:yodacentral/models/model_response_login.dart';
import 'package:yodacentral/models/model_response_message.dart';
import 'package:yodacentral/models/model_save_akun_register.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/data_diri.dart/data_diri.dart';
import 'package:yodacentral/screens/login/email_send.dart/email_send.dart';
import 'package:yodacentral/utils/utils.dart';

class ControllerAuth extends GetxController {
  RxInt infoUnit = 0.obs;
  RxInt infoNasabah = 0.obs;
  RxInt infoKredit = 0.obs;
  RxList<String> menuLeads = <String>[].obs;

  bool loadLogin = true;
  ModelSaveRoot? modelSaveRoot;
  String? errorEmail;
  String? errorKataSandi;
  ControllerBiodata controllerBiodata = Get.put(ControllerBiodata());

  detailLead({String? id, Function? onError}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/lead/detail_lead/${id}';
    print('URL ${url}');
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var das = jsonEncode(dataJson);
      infoUnit.value  = dataJson['access']['mobile_access']['Info Unit (Informasi lead)'];
      infoNasabah.value = dataJson['access']['mobile_access']['Info Nasabah (Informasi lead)'];
      infoKredit.value = dataJson['access']['mobile_access']['Info Kredit (Informasi lead)'];
      List<String> data = [];
      if(infoUnit.value > 0){
        data.add('Unit');
      }
      if(infoNasabah.value > 0){
        data.add('Nasabah');
      }

      if(infoKredit.value > 0 && value.userData!.role != 'External'){
        data.add('Kredit');
      }
      menuLeads.value = data;
      print('RESPONSE ${json.encode(jsonDecode)}');
    } else {
      onError!(res.body);
    }
  }


  ambilSaveRoot() {
    SaveRoot.callSaveRoot().then((value) {
      value.token == null ? modelSaveRoot = null : modelSaveRoot = value;
       // update();
    });
    // update();
  }

  login({
    required String email,
    required String kata_sandi,
    bool? remember,
    required String device,
  }) async {
    modalLoad();
    errorEmail = null;
    errorKataSandi = null;

    loadLogin = true;

    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.login.toString()}';
    var res = await  http.post(
      Uri.parse(strUrl.trim()),
      body: {
        'email': email,
        'password': kata_sandi,
        'category': 'Mobile',
        'device': device,
        'remember_me': remember == null ? "0" : "1",
      },
    );

    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      loadLogin = false;
      final resData = modelResponseLoginFromMap(res.body);

      SaveRoot.saveRoot(
          token: resData.token!,
          email: resData.userData!.email!,
          name: resData.userData!.name!,
          telp: resData.userData!.telp!,
          avatar: resData.userData!.avatar!,
          role: resData.userData!.role!,
          kantor: resData.userData!.kantor ?? "",
          kode: resData.userData!.kode!,
          markNotif: resData.userData!.markNotif!,
          ingat: remember! ? 1 : 0);

      ambilSaveRoot();
      if (Get.isBottomSheetOpen == true) Get.back();
      log(res.body);
      update();
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      final modelResponseMessage = modelResponseMessageFromMap(res.body);

      if (modelResponseMessage.message == "Password Salah") {
        errorKataSandi = modelResponseMessage.message;
        update();
      } else if (modelResponseMessage.message == "Email Belum Terdaftar") {
        errorEmail = modelResponseMessage.message;
        update();
      } else if (modelResponseMessage.message == "Mohon menunggu") {
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Mohon menunggu",
            content:
                "Akun Anda sedang melalui proses persetujuan. Silahkan cek email Anda dalam 1x24 Jam (waktu jam kerja) untuk menunggu info lebih lanjut.",
            textButton: "Keluar",
            onTap: () {
              Get.back();
            },
          ),
          isScrollControlled: true,
        );
      } else if (modelResponseMessage.message == "Email Belum Terverifikasi") {
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Mohon menunggu",
            content:
                "Akun Anda sedang melalui proses persetujuan. Silahkan cek email Anda dalam 1x24 Jam (waktu jam kerja) untuk menunggu info lebih lanjut.",
            textButton: "Tutup",
            onTap: () {
              Get.back();
            },
          ),
          isScrollControlled: true,
        );
      } else if (modelResponseMessage.message ==
          "Anda Tidak Bisa Mengakses Yoda Central") {
        errorEmail = modelResponseMessage.message;
        update();
      } else if (modelResponseMessage.message ==
          "Anda Tidak Bisa Mengakses Mobile") {
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Mohon maaf",
            content:
                "Akun Anda tidak memiliki izin untuk mengakses Yodacentral mobile. Harap hubungi Customer Relation apabila terjadi kendala.",
            textButton: "Tutup",
            onTap: () {
              Get.back();
            },
          ),
          isScrollControlled: true,
        );
      } else if (modelResponseMessage.message == "Silahkan Lengkapi Biodata") {
        var tok = json.decode(res.body);
        controllerBiodata.setToken(tokenRegis: tok['token']);
        Get.to(() => DataDiri());
      } else {
        log(res.body);
        errorEmail = modelResponseMessage.message;

        update();
      }

      // rawBottomNotif();
      loadLogin = false;
      log(errorEmail.toString());
      log(res.body);
      update();
    }

    update();
  }

  logout() {
    modalLoad();
    Future.delayed(Duration(milliseconds: 300), () {
      modelSaveRoot = null;
      SaveRoot.deleteSaveRoot();
      if (Get.isBottomSheetOpen == true) Get.back();
      update();
    });

    // modelSaveRoot = null;
    update();
  }

  postPlayerID(String playerid) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.postPlayerID.toString()}';
    print('URL : $strUrl');
    print('ID : $playerid');
    print('TOKEN : ${value.token.toString()}');
    var res = await  http.post(
      Uri.parse(strUrl.trim()),
      body: {
        "player_id": playerid
      },
      headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      }
    );

    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      Utils.savePlayerID(true);
    }
  }
}

class Regis extends GetxController {
  String? res422Regis;
  ModelSaveAkunRegister? modelSaveAkunRegister;
  ambilSaveRootRegis() {
    SaveRootDaftar.callSaveRootRegis().then((value) {
      modelSaveAkunRegister = value;
      update();
    });
    update();
  }

  regis({required String email, required String pw}) async {
    res422Regis = null;
    modalLoad();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.regis}';
    var res = await http.post(Uri.parse(url.trim()), body: {
      'email': email,
      'password': pw,
      'category': 'mobile',
    });
    if (res.statusCode == 200) {
      log(res.body);
      SaveRootDaftar.saveRootRegis(emailRegis: email, pwRegis: pw);

      if (Get.isBottomSheetOpen == true) Get.back();
      Get.back();
      Get.bottomSheet(
        EmailSend(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
      // Get.back();
      // Get.to(
      //   () => EmailSend(),
      // );
      update();
    } else if (res.statusCode == 422) {
      log(res.body);
      res422Regis = "Email Sudah Terdaftar";
      if (Get.isBottomSheetOpen == true) Get.back();
      update();
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      log(res.body);
      update();
    }
    update();
  }
}
