import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/models/model_list_role.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';

class ControllerListRole extends GetxController {
  bool loadRole = true;
  ModelListRole? modelListRole;

  getListRole() async {
    loadRole = true;
    var url = '${ApiUrl.domain.toString()}/api/admin/role';
    SaveRoot.callSaveRoot().then((value) async {
      try {
        var res = await http.get(Uri.parse(url.trim()), headers: {
          'Authorization': 'Bearer ' + value.token.toString(),
        });
        if (res.statusCode == 200) {
          loadRole = false;
          modelListRole = modelListRoleFromMap(res.body);

          log(res.body);
          update();
        } else {
          loadRole = false;
          // rawBottomNotif(
          //   message: res.body,
          //   colorFont: Colors.white,
          //   backGround: Colors.red,
          // );
          update();
        }
      } catch (e) {
        log(e.toString());
        // rawBottomNotif(
        //   message: e.toString(),
        //   colorFont: Colors.white,
        //   backGround: Colors.red,
        // );
        update();
      }
      update();
    });

    update();
  }
}
