import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_size.dart';

rawBottomNotif({String? message, Color? colorFont, Color? backGround}) {
  Get.rawSnackbar(
    forwardAnimationCurve: Curves.elasticInOut,
    reverseAnimationCurve: Curves.elasticOut,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.all(yd_defauld_padding),
    borderRadius: 5,
    messageText: Text(
      message!,
      style: TextStyle(
        color: colorFont,
      ),
    ),
    backgroundColor: backGround!,
  );
}
