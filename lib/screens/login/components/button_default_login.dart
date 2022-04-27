import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget buttonDefaulLogin(
    {required Color backGround,
    required Color textColor,
    required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: yd_defauld_padding),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      width: Get.width,
      height: 45,
      decoration: BoxDecoration(
        color: backGround,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
