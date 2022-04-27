import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';

modalLoad() {
  Get.bottomSheet(
    Center(
      child: CircularProgressIndicator(
        // color: yd_Color_Primary,
      ),
    ),
    isDismissible: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
  );
}
