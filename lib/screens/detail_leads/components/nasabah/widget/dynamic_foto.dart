import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/unggah_foto.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';

class DynamicFoto extends StatefulWidget {
  const DynamicFoto({Key? key,
    this.urlImage = "https:",
    required this.index,
    this.onClick,
    this.hapusFoto,
    this.onCover
  })
      : super(key: key);
  final String urlImage;
  final int index;
  final ValueChanged<ModelListImageUpload>? onClick;
  final ValueChanged<File?>? hapusFoto;
  final ValueChanged<int>? onCover;

  @override
  _SquareImageState createState() => _SquareImageState();
}

class _SquareImageState extends State<DynamicFoto> {
  File? imageFiles;

  final ImagePicker _picker = ImagePicker();
  getImageGallery() async {
    Get.back();
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (xFile != null) {
      setState(() {
        imageFiles = File(xFile.path);
        widget.onClick!(ModelListImageUpload(index: widget.index, image: imageFiles!));
      });
    }
  }

  getImageCamera() async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    if (xFile != null) {
      setState(() {
        imageFiles = File(xFile.path);
        widget.onClick!(ModelListImageUpload(index: widget.index, image: imageFiles!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("message");
        showPopup();
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
          child: imageFiles == null
              ? imageNetworkHandler(urlImage: widget.urlImage,)
              : Image.file(imageFiles!, fit: BoxFit.cover),
        ),
      ),
    );
    ;
  }

  showPopup(){
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(vertical: 10),
            width: Get.width,
            height: Get.width / 1.3,
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
                      style: TextButton.styleFrom(primary: yd_Color_Primary),
                      onPressed: () {
                        Navigator.pop(context);
                        imageFiles == null
                            ? shwoDetailImage(a: null, urlImage: widget.urlImage,)
                            : shwoDetailImage(a: imageFiles, urlImage: null);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Icon(Icons.open_in_full_rounded, color: Colors.black),
                            SizedBox(width: yd_defauld_padding,),
                            Text("Lihat Foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(primary: yd_Color_Primary,),
                      onPressed: () {
                        setState(() {
                          widget.hapusFoto!(imageFiles == null ? null : imageFiles);
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded, color: Colors.black),
                            SizedBox(width: yd_defauld_padding,),
                            Text("Hapus", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 0),
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
                        getImageCamera();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_rounded,
                                color: Colors.black),
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
                            Icon(Icons.photo_library_rounded,
                                color: Colors.black),
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
          ),
          elevation: 0,
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.4),
    );
  }
}
