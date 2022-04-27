import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget cardItemOmnisearch({String? name, String? section, String? urlImage}) {
  return Container(
    padding: EdgeInsets.all(yd_defauld_padding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: Get.width / 6,
            height: Get.width / 6,
            decoration: BoxDecoration(
              color: yd_Color_Primary_Grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: imageNetworkHandler(
              urlImage: urlImage,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              section!,
              style: TextStyle(
                fontSize: 14,
                color: yd_Color_Primary_Grey,
              ),
            )
          ],
        )
      ],
    ),
  );
}
