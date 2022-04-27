import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class UnggahFoto extends StatefulWidget {
  const UnggahFoto({Key? key, required this.toChangePage}) : super(key: key);
  final ValueChanged<int>? toChangePage;

  @override
  _UnggahFotoState createState() => _UnggahFotoState();
}

class _UnggahFotoState extends State<UnggahFoto>
    with AutomaticKeepAliveClientMixin {
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());
  List<File> listImage = [];
  final ImagePicker _picker = ImagePicker();
  getImageGallery({int? index}) async {
    Get.back();
    if (index != null) {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
      if (index == null) {
        if (xFile == null) {
          log("null");
        } else {
          setState(() {
            listImage.add(File(xFile.path));
          });
        }
      } else {
        setState(() {
          listImage[index] = File(xFile!.path);
          // Get.back();
        });
      }
    } else {
      List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 100);
      if (mul!.length == 0) {
        log("kosong", name: "ini unggah foto");
      } else {
        if ((listImage.length + mul.length) > 15) {
          log((listImage.length + mul.length).toString(),
              name: "jumlah keduanya");
          rawBottomNotif(
            message: "Jumlah foto melebihi batas",
            colorFont: Colors.white,
            backGround: Colors.red,
          );
        } else {
          setState(() {
            for (var q in mul) {
              listImage.add(File(q.path));
            }

            // listImage = [
            //   for (var q in mul) File(q.path),
            // ];
          });
        }
      }
    }
  }

  getImageCamera({int? index}) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (index == null) {
      if (xFile == null) {
        log("null");
      } else {
        setState(() {
          listImage.add(File(xFile.path));

          // Get.back();
        });
      }
    } else {
      setState(() {
        listImage[index] = File(xFile!.path);
        // Get.back();
      });
    }
  }

  Widget di({required bool shadow}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 2.1,
      decoration: BoxDecoration(
          color: Color(0xFFF5F9F8),
          borderRadius: BorderRadiusDirectional.circular(16),
          boxShadow: [
            shadow
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                  )
                : BoxShadow(
                    color: Colors.black.withOpacity(0.0),
                    blurRadius: 0,
                  )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageCamera();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageGallery();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Album foto",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageGallery();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.folder_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Dokumen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: di(
          shadow: true,
        ),
        elevation: 0,
      ),
    );
  }

  Widget doo({
    required File image,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 1.2,
      decoration: BoxDecoration(
          color: Color(0xFFF5F9F8),
          borderRadius: BorderRadiusDirectional.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  shwoDetailImage(
                    a: image,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.open_in_full_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text(
                        "Lihat Foto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RR",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  deleteFile(index: index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text(
                        "Hapus",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RR",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Text(
                    "Ganti Foto",
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  getImageCamera(index: index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RR",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  getImageGallery(index: index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.photo_library_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text(
                        "Album foto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RR",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  getImageGallery(index: index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.folder_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text(
                        "Dokumen",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RR",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemEdit({required File image, required int index}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: doo(
          index: index,
          image: image,
        ),
        elevation: 0,
      ),
    );
  }

  deleteFile({required int index}) {
    setState(() {
      listImage.removeAt(index);
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(yd_defauld_padding),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Unggah Foto",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: yd_defauld_padding,
              ),
              DottedBorder(
                radius: Radius.circular(8),
                color: yd_Color_Primary_Grey.withOpacity(0.1),
                strokeWidth: 2,
                borderType: BorderType.RRect,
                dashPattern: [10, 1],
                child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        GestureDetector(
                          onTap: () {
                            listImage.length >= 15
                                ? log("penuh")
                                : showDialog(
                                    context: context,
                                    builder: (context) => dialogImage(),
                                    barrierColor: Colors.white.withOpacity(0.4),
                                  );
                          },
                          child: Container(
                            width: Get.width / 2.4,
                            height: Get.width / 2.4,
                            decoration: BoxDecoration(
                              color: yd_Color_Primary_Grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  size: Get.width / 7,
                                ),
                                Text(listImage.length.toString() + "/" + "15"),
                              ],
                            ),
                          ),
                        ),
                        for (var i = 0; i < listImage.length; i++)
                          GestureDetector(
                            onTap: () {
                              log("message");
                              showDialog(
                                context: context,
                                builder: (context) => itemEdit(
                                  image: listImage[i],
                                  index: i,
                                ),
                                barrierColor: Colors.white.withOpacity(0.4),
                              );

                              // shwoDetailImage(a: listImage[i]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Container(
                                width: Get.width / 2.4,
                                height: Get.width / 2.4,
                                decoration: BoxDecoration(
                                  color: yd_Color_Primary_Grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Image.file(listImage[i], fit: BoxFit.cover),
                              ),
                            ),
                          ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: listImage.length < 5 || listImage.length > 15
          ? GestureDetector(
              onTap: () {
                // setState(() {
                //   widget.toChangePage!(3);
                // });
              },
              child: buttonDefaulLogin(
                  backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                  textColor: Colors.white,
                  text: "Selanjutnya"),
            )
          : GestureDetector(
              onTap: () {
                addLeadFinancing.inputListFoto(listFoto: listImage);
                setState(() {
                  widget.toChangePage!(2);
                });
              },
              child: buttonDefaulLogin(
                  backGround: yd_Color_Primary,
                  textColor: Colors.white,
                  text: "Selanjutnya"),
            ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

shwoDetailImage({File? a, String? urlImage}) {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Column(
          children: [
            a == null ? Expanded(child: Container(child: Image.network(urlImage!, width: double.infinity))) :
            Expanded(child: Container(child: Image.file(a, width: double.infinity))),
            GestureDetector(
              onTap: ()=>Get.back(),
              child: Container(
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Text("Keluar", style: TextStyle(color: Colors.white,)),
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
    ),
    barrierColor: Colors.white.withOpacity(0.5),
  );
}
