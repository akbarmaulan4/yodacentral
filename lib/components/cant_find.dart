import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget cantFind({
  String? title,
  required String content,
}) {
  return SizedBox(
    width: Get.width,
    child: Padding(
      padding: EdgeInsets.all(yd_defauld_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/Omnisearch-undraw_File_searching_re_3evy.svg",
          ),
          SizedBox(height: yd_defauld_padding),
          title == null
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
          SizedBox(
            height: 6,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: yd_Color_Primary_Grey,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
