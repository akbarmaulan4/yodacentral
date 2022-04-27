import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';

openwhatsapp({required String nomerTlp}) async {
  var whatsapp = "+62" + nomerTlp.replaceAll(" ", "");
  log(whatsapp);
  var whatsappURl_android = "whatsapp://send?phone=" + whatsapp + "&text=";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      rawBottomNotif(
        message: "WhatsApp tidak terinstall",
        colorFont: Colors.white,
        backGround: Colors.green,
      );
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      rawBottomNotif(
        message: "WhatsApp tidak terinstall",
        colorFont: Colors.white,
        backGround: Colors.green,
      );
    }
  }
}
