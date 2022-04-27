import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_biodata/controller_biodata.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class UploadFotoProfil extends StatefulWidget {
  const UploadFotoProfil({Key? key}) : super(key: key);

  @override
  _UploadFotoProfilState createState() => _UploadFotoProfilState();
}

class _UploadFotoProfilState extends State<UploadFotoProfil> {
  File? photo;
  final ImagePicker _picker = ImagePicker();

  ControllerBiodata controllerBiodata = Get.put(ControllerBiodata());

  getImageGallery() async {
    XFile? xFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (xFile == null) {
      log("null");
    } else {
      setState(() {
        photo = File(xFile.path);

        Get.back();
      });
    }
  }

  getImageCamera() async {
    XFile? xFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    if (xFile == null) {
      log("null");
    } else {
      setState(() {
        photo = File(xFile.path);
        Get.back();
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
          color: Colors.white,
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
          // TextButton.icon(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.camera_alt_rounded,
          //     color: Colors.black,
          //   ),
          //   label: Text(
          //     "Camera",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontFamily: "RR",
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     getImageCamera();
          //   },
          //   leading: Icon(
          //     Icons.camera_alt_rounded,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     "Camera",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontFamily: "RR",
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     getImageCamera();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          // child: Row(
          //   children: [
          //     Icon(Icons.camera_alt_rounded),
          //     SizedBox(
          //       width: yd_defauld_padding,
          //     ),
          //     Text(
          //       "Camera",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontFamily: "RR",
          //       ),
          //     ),
          //   ],
          // ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     getImageGallery();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          //     child: Row(
          //       children: [
          //         Icon(Icons.photo_library_rounded),
          //         SizedBox(
          //           width: yd_defauld_padding,
          //         ),
          //         Text(
          //           "Album foto",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: "RR",
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     getImageGallery();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          //     child: Row(
          //       children: [
          //         Icon(Icons.folder_rounded),
          //         SizedBox(
          //           width: yd_defauld_padding,
          //         ),
          //         Text(
          //           "Dokumen",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: "RR",
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget dialogBottomImage() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          children: [
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: di(shadow: true),
            )
          ],
        ),
      ),
    );
  }

  Widget dialogImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: di(
          shadow: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: yd_Color_Primary_Grey,
      child: Padding(
        padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(yd_defauld_padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialog(),
                                barrierColor: Colors.black.withOpacity(0.7));
                          },
                          child: Center(
                            child: Text(
                              "Batalkan",
                              style: TextStyle(
                                color: yd_Color_Primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: yd_defauld_padding * 2,
                    ),
                    Text(
                      "Unggah Foto Profil",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: yd_defauld_padding * 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        photo == null
                            ? showDialog(
                                context: context,
                                builder: (context) => dialogImage(),
                              )
                            : log("ada");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          width: Get.width / 1.6,
                          height: Get.width / 1.6,
                          decoration: BoxDecoration(
                            color: yd_Color_Primary_Grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: photo == null
                              ? Icon(
                                  Icons.camera_alt_rounded,
                                  size: Get.width / 4,
                                )
                              : Image.file(
                                  photo!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: Get.width / 2.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  photo == null
                      ? SizedBox(
                          width: 0,
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            log("hmm");
                            showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              builder: (context) => dialogBottomImage(),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            width: Get.width,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Ubah foto",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: yd_Color_Primary,
                                ),
                              ),
                            ),
                          ),
                        ),

                  // PortalEntry(
                  //     visible: true,
                  //     portal: di(shadow: true),
                  //     portalAnchor: Alignment.topCenter,
                  //     childAnchor: Alignment.topRight,
                  //     child:
                  //     Container(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: 0, horizontal: 10),
                  //       width: Get.width,
                  //       height: 45,
                  //       decoration: BoxDecoration(
                  //         color: Colors.transparent,
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           "Ubah foto",
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: yd_Color_Primary,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     // IgnorePointer(
                  //     //   ignoring: true,
                  //     //   child: Text("data"),
                  //     // ),
                  //   ),
                  photo == null
                      ? buttonDefaulLogin(
                          backGround: yd_Color_Primary_Grey.withOpacity(0.2),
                          textColor: yd_Color_Primary_Grey,
                          text: "Selanjutnya")
                      : GestureDetector(
                          onTap: () {
                            controllerBiodata.uploadBiodata(
                              path: photo!.path,
                            );
                            // controllerBiodata.setImageProfile(
                            //     path: photo!.path);
                            // Get.to(() => WaitingVerification());
                          },
                          child: buttonDefaulLogin(
                              backGround: yd_Color_Primary,
                              textColor: Colors.white,
                              text: "Selanjutnya"),
                        ),
                ],
              ),
            ),
            //       ? GestureDetector(
            //           onTap: () {
            //             Get.to(
            //               () => UploadFotoProfil(),
            //               transition: Transition.noTransition,
            //             );
            //           },
            //           child: buttonDefaulLogin(
            //             backGround: yd_Color_Primary,
            //             textColor: Colors.white,
            //             text: "Selanjutnya",
            //           ),
            //         )
          ),
        ),
      ),
    );
  }
}
