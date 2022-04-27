import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/cek_nomor-polisi.dart';
import 'package:yodacentral/utils/utils.dart';

class BottomSheetFloatingAdd extends StatefulWidget {
  // const BottomSheetFloatingAdd({this.tambahUnit});
  // final int? tambahUnit;

  @override
  _BottomSheetFloatingAddState createState() => _BottomSheetFloatingAddState();
}

class _BottomSheetFloatingAddState extends State<BottomSheetFloatingAdd> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: yd_surface_barrier.withOpacity(0.5),
        insetPadding: EdgeInsets.all(0),
        elevation: 0,
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.transparent,
          child: Stack(children: [
            Positioned(
              bottom: 50,
              right: 25,
              child: Container(
                decoration: BoxDecoration(
                    color: yd_surface_menu,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(yd_defauld_padding)),
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: yd_Color_Primary,
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen == true) Get.back();
                          Utils.saveUpdatePipeline(false);
                          Get.to(() => CekNomorPolisi(isFinancing: true),
                          );
                        },
                        child:  Row(
                          children: [
                            Icon(
                              Icons.drive_eta,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: yd_defauld_padding,
                            ),
                            Text(
                              "Financing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: yd_defauld_padding + 5,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: yd_Color_Primary,
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen == true) Get.back();
                          Utils.saveUpdatePipeline(false);
                          Get.to(
                            () => CekNomorPolisi(
                              isFinancing: false,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: yd_defauld_padding,
                            ),
                            Text(
                              "Refinancing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: yd_defauld_padding + 5,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class BottomSheetMenuCustom extends StatefulWidget {
  const BottomSheetMenuCustom({Key? key, required this.items})
      : super(key: key);
  final List<Widget> items;

  @override
  _BottomSheetMenuCustomState createState() => _BottomSheetMenuCustomState();
}

class _BottomSheetMenuCustomState extends State<BottomSheetMenuCustom> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: yd_surface_barrier.withOpacity(0.5),
        insetPadding: EdgeInsets.all(0),
        elevation: 0,
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.transparent,
          child: Stack(children: [
            Positioned(
              bottom: 50,
              right: 25,
              child: Container(
                width: Get.width / 1.8,
                decoration: BoxDecoration(
                    color: yd_surface_menu,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(yd_defauld_padding)),
                padding: EdgeInsets.symmetric(
                  vertical: 7.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.items,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ItemBottomSheetMenuCustom extends StatelessWidget {
  const ItemBottomSheetMenuCustom(
      {Key? key, required this.icon, required this.text, required this.onTap, this.active = false})
      : super(key: key);
  final Icon icon;
  final String text;
  final Function() onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: yd_Color_Primary,
      ),
      onPressed: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        width: Get.width / 2.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: active ? Color(0xFFD9EDE9):Colors.transparent,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: yd_defauld_padding),
            Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12,))
          ],
        ),
      ),
    );
  }
}

class BottomSheetFloatingAddNotif extends StatefulWidget {
  const BottomSheetFloatingAddNotif({Key? key, this.onTap}) : super(key: key);
  final ValueChanged<String>? onTap;

  @override
  _BottomSheetFloatingAddNotifState createState() =>
      _BottomSheetFloatingAddNotifState();
}

class _BottomSheetFloatingAddNotifState
    extends State<BottomSheetFloatingAddNotif> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: yd_surface_barrier.withOpacity(0.5),
        insetPadding: EdgeInsets.all(0),
        elevation: 0,
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.transparent,
          child: Stack(children: [
            Positioned(
              top: 100,
              left: 25,
              child: Container(
                decoration: BoxDecoration(
                    color: yd_surface_menu,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(yd_defauld_padding)),
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: yd_Color_Primary,
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen == true) Get.back();
                          setState(() {
                            widget.onTap!("Semua Product");
                          });
                          // Get.to(
                          //   () => CekNomorPolisi(
                          //     isFinancing: false,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.border_all_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: yd_defauld_padding,
                            ),
                            Text(
                              "Semua Product",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: yd_defauld_padding + 5,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: yd_Color_Primary,
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen == true) Get.back();
                          setState(() {
                            widget.onTap!("Financing");
                          });
                          // Get.to(
                          //   () => CekNomorPolisi(
                          //     isFinancing: true,
                          //     // toChangePage: (i) {
                          //     //   setState(() {
                          //     //     controller.animateToPage(i,
                          //     //         duration: Duration(milliseconds: 300),
                          //     //         curve: Curves.easeInOut);
                          //     //   });
                          //     // },
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.drive_eta,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: yd_defauld_padding,
                            ),
                            Text(
                              "Financing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: yd_defauld_padding + 5,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: yd_Color_Primary,
                        ),
                        onPressed: () {
                          if (Get.isDialogOpen == true) Get.back();
                          setState(() {
                            widget.onTap!("Refinancing");
                          });
                          // Get.to(
                          //   () => CekNomorPolisi(
                          //     isFinancing: false,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: yd_defauld_padding,
                            ),
                            Text(
                              "Refinancing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: yd_defauld_padding + 5,
                            ),
                          ],
                        ),
                      ),
                      // InkWell(
                      //   hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   onTap: () {
                      //     if (Get.isDialogOpen == true) Get.back();
                      //     Get.to(
                      //       () => AddNewLeadFinancing(
                      //         isFinancing: true,
                      //       ),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.drive_eta,
                      //         ),
                      //         SizedBox(
                      //           width: yd_defauld_padding,
                      //         ),
                      //         Text(
                      //           "Financing",
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      //   onTap: () {
                      //     if (Get.isDialogOpen == true) Get.back();
                      //     Get.to(
                      //       () => AddNewLeadFinancing(
                      //         isFinancing: false,
                      //       ),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.attach_money_rounded),
                      //         SizedBox(
                      //           width: yd_defauld_padding,
                      //         ),
                      //         Text(
                      //           "Refinancing",
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
