import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/models/model_log_activity.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:http/http.dart' as http;

class ControllerRiwayat extends GetxController {
  bool load = false;

  ModelLogActivity? modelLogActivity;

  getActiv() async {
    SaveRoot.callSaveRoot().then((value) async {
      load = true;

      var url = '${ApiUrl.domain.toString()}/api/log-activity';
      var res = await http.get(
        Uri.parse(url.trim()),
        headers: {
          'Authorization': 'Bearer ' + value.token.toString(),
        },
      );

      if (res.statusCode == 200) {
        modelLogActivity = modelLogActivityFromMap(res.body);
        load = false;

        log(res.body);
        update();
      } else {
        load = false;
        // rawBottomNotif(
        //   message: res.body,
        //   colorFont: Colors.white,
        //   backGround: Colors.red,
        // );
        log(res.body);
        update();
      }

      update();
    });
    update();
  }
}
