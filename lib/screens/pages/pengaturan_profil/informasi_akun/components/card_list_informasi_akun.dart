import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget cardListInformasiAkun({required String key, String? value = "-"}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: yd_defauld_padding,
      ),
      Text(
        key,
        style: TextStyle(
          fontSize: 12,
          color: yd_Color_Primary_Grey,
        ),
      ),
      SizedBox(
        height: 6,
      ),
      Text(
        value!,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: yd_defauld_padding,
      ),
      Divider(
        height: 0,
      ),
    ],
  );
}
