import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/lupa_kata_sandi/cek_email_anda_pw.dart';

class ControllerLupaSandi extends GetxController {
  RxBool passActive = false.obs;
  RxBool confPassActive = false.obs;
  RxBool buttonActive = false.obs;

  changeButtonActive(){

  }

  String? emailLupa;
  String? tokenLupa;
  String? msg;

  inputEmail({required String email}) {
    emailLupa = email;

    update();
  }

  sendEmail({required String email, required BuildContext context}) async {
    msg = null;
    modalLoad();
    var url = '${ApiUrl.domain.toString()}/api/forget/send-email';
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var res = await http.post(
      Uri.parse(url.trim()),
      body: {
        'email': email,
        'category': 'mobile',
      },
      headers: {'Authorization': 'Bearer ' + value.token.toString()}
    );

    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      Get.back();
      inputEmail(email: email);
      showModalBottomSheet(
        context: context,
        builder: (_) => CekEmailAndaPw(
          email: email,
          title: "Cek E-mail Anda",
          content:
              "Kami sudah mengirimkan link agar Anda dapat mengubah kata sandi Anda.",
          onTap: () {
            Get.back();
          },
          textButton: "Kembali ke Halaman Masuk",
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
      log(res.body);
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      msg = json.decode(res.body)['message'];
      // rawBottomNotif(
      //   message: res.body,
      //   colorFont: Colors.white,
      //   backGround: Colors.red,
      // );
      log(res.body);
    }

    update();
  }
}
