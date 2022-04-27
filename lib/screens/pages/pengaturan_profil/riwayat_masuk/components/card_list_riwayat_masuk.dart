import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget cardListRiwayatMasuk({
  String? devices,
  String? tgl,
  String? kategori,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: yd_defauld_padding),
    child: Column(
      children: [
        SizedBox(
          height: yd_defauld_padding,
        ),
        Row(
          children: [
            Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: yd_Color_Primary_Grey.withOpacity(0.0),
                  border: Border.all(
                    color: yd_Color_Primary_Grey.withOpacity(0.3),
                  ),
                ),
                child: kategori == "Mobile"
                    ? Icon(
                        Icons.phone_android_rounded,
                      )
                    : Icon(
                        Icons.desktop_windows_rounded,
                      )),
            SizedBox(
              width: yd_defauld_padding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tgl!,
                  style: TextStyle(
                    color: yd_Color_Primary_Grey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: Text(
                    devices!,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: yd_defauld_padding,
        ),
        Divider(
          height: 0,
        ),
      ],
    ),
  );
}
