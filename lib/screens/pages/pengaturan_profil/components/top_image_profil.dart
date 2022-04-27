import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget topImageProfil({
  required String name,
  required String registerNumber,
  String? imgUrl,
}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: Container(
          width: Get.width / 3,
          height: Get.width / 3,
          decoration: BoxDecoration(
            color: yd_Color_Primary_Grey.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: imageNetworkHandler(
            urlImage: imgUrl,
            nama: name,
          ),
        ),
      ),
      SizedBox(
        height: yd_defauld_padding,
      ),
      Text(
        name,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        registerNumber,
        style: TextStyle(
          color: yd_Color_Primary_Grey,
        ),
      )
    ],
  );
}
