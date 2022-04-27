import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/controller/controller_list_role/controller_list_role.dart';
import 'package:yodacentral/screens/login/email_send.dart/email_send.dart';
import 'package:yodacentral/screens/login/login.dart';
import 'package:yodacentral/screens/pages/bottomnaviga.dart';

class Wraping extends StatefulWidget {
  const Wraping({Key? key}) : super(key: key);

  @override
  _WrapingState createState() => _WrapingState();
}

class _WrapingState extends State<Wraping> {
  ControllerListRole controllerListRole = Get.put(ControllerListRole());
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());

  @override
  void initState() {
    super.initState();
    controllerListRole.getListRole();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAuth>(
      init: ControllerAuth(),
      builder: (val) {
        val.ambilSaveRoot();
        if (val.modelSaveRoot == null) {
          return Login();
        } else if (val.modelSaveRoot != null) {
          // print('MASUK SINI');
          return BottomNaviga();
        }

        return Login();
      },
    );
  }
}

class WrapingRegis extends StatefulWidget {
  const WrapingRegis({Key? key}) : super(key: key);

  @override
  _WrapingRegisState createState() => _WrapingRegisState();
}

class _WrapingRegisState extends State<WrapingRegis> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Regis>(
        init: Regis(),
        builder: (vv) {
          vv.ambilSaveRootRegis();
          if (vv.modelSaveAkunRegister == null) {
            return Login();
          } else if (vv.modelSaveAkunRegister!.email == null) {
            return Login();
          } else if (vv.modelSaveAkunRegister!.email != null) {
            return EmailSend();
          }
          return Login();
        });
  }
}
