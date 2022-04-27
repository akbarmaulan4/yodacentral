import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, this.backI, this.batal}) : super(key: key);
  final Function()? backI;
  final Function()? batal;
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            // width: Get.width,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFFEDF5F4),
              borderRadius: BorderRadiusDirectional.circular(26),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Anda Yakin Ingin Keluar?",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    Text(
                      "Perubahan tidak akan tersimpan\nbila anda keluar.",
                      style: TextStyle(
                        color: Color(0xFF3F4947),
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: widget.backI == null
                            ? () {
                                for (var i = 0; i < 8; i++) {
                                  Get.back();
                                }

                                // Get.offAll(Wraping());
                              }
                            : widget.backI,
                        child: Text(
                          "Keluar",
                          style: TextStyle(
                            color: yd_Color_Primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: yd_defauld_padding * 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // widget.batal!();
                        },
                        child: Text(
                          "Batal",
                          style: TextStyle(
                            color: yd_Color_Primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
