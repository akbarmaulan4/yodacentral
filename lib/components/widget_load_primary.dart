import 'package:flutter/material.dart';
import 'package:yodacentral/components/yd_colors.dart';

Widget widgetLoadPrimary() {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Center(
        child: CircularProgressIndicator(
      // color: yd_Color_Primary,
    )),
  );
}
