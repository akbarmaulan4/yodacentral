import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

class FormIDokumen extends StatefulWidget {
  Function? onSave;
  bool? hasComplete;
  bool? allComplete;
  int? lead_id;
  Function? onNext;
  FormIDokumen({this.onSave, this.hasComplete, this.allComplete, this.lead_id, this.onNext});

  @override
  _FormIDokumenState createState() => _FormIDokumenState();
}

class _FormIDokumenState extends State<FormIDokumen>
    with AutomaticKeepAliveClientMixin {

  NasabahController controller = Get.put(NasabahController());

  List<File> listDoc = [];
  File? finalImage;
  final ImagePicker _picker = ImagePicker();
  getImageGallery(bool isDoc, bool isEdit, int index) async {
    Get.back();
    if(isDoc){
      if(isEdit){
        XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
        if(xFile != null){
          setState(() {
            listDoc[index] = File(xFile.path);
          });
        }
      }else{
        List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 100);
        if (mul!.length == 0) {
          log("kosong", name: "ini unggah foto");
        } else {
          if ((listDoc.length + mul.length) > 15) {
            log((listDoc.length + mul.length).toString(), name: "jumlah keduanya");
            rawBottomNotif(
              message: "Jumlah foto melebihi batas",
              colorFont: Colors.white,
              backGround: Colors.red,
            );
          } else {
            setState(() {
              for (var q in mul) {
                listDoc.add(File(q.path));
              }
            });
          }
        }
      }
    }else{
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
      if (xFile != null) {
        controller.setEnableButtonFoto(xFile.path);
        controller.changeFinalImage(File(xFile.path));
        setState(() {
          finalImage = File(xFile.path);
        });
      }
    }

    if(listDoc.length > 0){
      controller.enableButtonFoto.value = true;
      controller.changeListDoc(listDoc);
    }
  }

  getImageCamera(bool isDoc, bool isEdit, int index) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if(isDoc){
      if(isEdit){
        setState(() {
          listDoc[index] = File(xFile!.path);
        });
      }else{
        setState(() {
          listDoc.add(File(xFile!.path));
        });
      }
    }else{
      if (xFile != null) {
        controller.setEnableButtonFoto(xFile.path);
        controller.changeFinalImage(File(xFile.path));
        setState(() {
          finalImage = File(xFile.path);
        });
      }
    }
    if(listDoc.length > 0){
      controller.enableButtonFoto.value = true;
      controller.changeListDoc(listDoc);
    }
  }

  Widget dialogImageDokument(bool isDoc, isEdit) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: menuDialogImage(
          shadow: false,
          isDoc: isDoc,
          isEdit: isEdit
        ),
      ),
    );
  }

  Widget dialogImageNasabah() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: menuDialogImage(
            shadow: false,
            isDoc: false,
            isEdit: false
        ),
      ),
    );
  }

  Widget menuDialogImage({required bool shadow, bool? isDoc, bool? isEdit}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 2.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(16),
          boxShadow: [
            shadow ? BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5,) :
            BoxShadow(color: Colors.black.withOpacity(0.0), blurRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed: ()=> getImageCamera(isDoc!, isEdit!, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Colors.black),
                  SizedBox(width: yd_defauld_padding),
                  Text("Camera", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed: () =>  getImageGallery(isDoc!, isEdit!, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.photo_library_rounded, color: Colors.black),
                  SizedBox(width: yd_defauld_padding,),
                  Text("Album foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,),),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () =>  getImageGallery(isDoc!, isEdit!, 0),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.enableButtonFoto.value = true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(()=>SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => dialogImageNasabah(),
                  );
                },
                child: DottedBorder(
                  radius: Radius.circular(8),
                  color: yd_Color_Primary_Grey.withOpacity(0.1),
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  dashPattern: [10, 1],
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foto Nasabah",
                          style: TextStyle(
                            fontSize: 12,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.width - 30,
                          child: finalImage == null
                              ? Icon(Icons.camera_alt, size: Get.width / 5)
                              : Image.file(
                            finalImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            listDoc.length == 0 ? Container(
              margin: EdgeInsets.only(left: 15),
              child: DottedBorder(
                radius: Radius.circular(8),
                color: yd_Color_Primary_Grey.withOpacity(0.1),
                strokeWidth: 2,
                borderType: BorderType.RRect,
                dashPattern: [10, 1],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Foto Dokumen",
                        style: TextStyle(
                          fontSize: 12,
                          color: yd_Color_Primary_Grey,
                        ),
                      ),
                      noImage(true)
                    ],
                  ),
                ),
              ),
            ):
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DottedBorder(
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
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        noImage(true),
                        for (var i = 0; i < listDoc.length; i++)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => itemEdit(
                                    image:  listDoc[i],
                                    index: i,
                                    onRefresh: (){}
                                ),
                                barrierColor: Colors.white.withOpacity(0.4),
                              );
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
                                child: Image.file( listDoc[i], fit: BoxFit.cover),
                              ),
                            ),
                          ),
                      ],
                    )),
              ),
            ),
            SizedBox(height: yd_defauld_padding * 6),
            Container(
              child: btnKirim(
                  backGround: controller.enableButtonFoto.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                  textColor: Colors.white,
                  text: 'Kirim',
                  onClick: (){
                    if(controller.enableButtonFoto.value){
                      controller.postIdentitas(context: context, id: widget.lead_id.toString(),
                          onSuccess:(){
                            if(controller.enableButtonInstitusi.value){
                              controller.postPekerjaan(context: context, id: widget.lead_id.toString(), onSuccess:(){
                                if(controller.enableButtonFoto.value){
                                  controller.postDokumentNasabah(
                                      context: context, id: widget.lead_id.toString(),
                                      path: controller.finalImage.value.path, docs:controller.listDoc,
                                      imageChange: [], imgDefault: [],
                                      onSuccess:(){
                                        successPost();
                                      }
                                  );
                                }else{
                                  successPost();
                                }
                              });
                            }else{
                              if(controller.enableButtonFoto.value){
                                controller.postDokumentNasabah(
                                    context: context, id: widget.lead_id.toString(),
                                    path: controller.finalImage.value.path, docs:controller.listDoc,
                                    imageChange: [], imgDefault: [],
                                    onSuccess:(){
                                      successPost();
                                    }
                                );
                              }else{
                                successPost();
                              }
                            }
                          }
                      // controller.postDokumentNasabah(context: context, id: widget.lead_id.toString(),
                      //   path: finalImage!.path, docs: listDoc,
                      //   imageChange: [], imgDefault: [], onSuccess: (){
                      //     if(controller.enableButton.value){
                      //       controller.postIdentitas(context: context, id: widget.lead_id.toString(),
                      //           onSuccess: (){
                      //             if(controller.enableButtonInstitusi.value){
                      //               controller.postPekerjaan(context: context, id: widget.lead_id.toString(), onSuccess:(){
                      //                 successPost();
                      //               });
                      //             }else{
                      //               successPost();
                      //             }
                      //           }
                      //       );
                      //     }else{
                      //       if(controller.enableButtonInstitusi.value){
                      //         controller.postPekerjaan(context: context, id: widget.lead_id.toString(), onSuccess:(){
                      //           successPost();
                      //         });
                      //       }else{
                      //         successPost();
                      //       }
                      //     }
                      //   }
                      );
                    }
                  }
              ),
            )
          ],
        ),
      )),
    );
  }

  successPost(){
    Get.bottomSheet(
      GlobalScreenNotif(
        title: "Berhasil",
        content: "Data Nasabah Berhasil dikirim",
        onTap: () {
          Get.back();
          Get.back();
          widget.onNext!();
        },
        textButton: "Selesai",
      ),
      isScrollControlled: true,
    );
  }

  noImage(bool isDoc){
    return GestureDetector(
      onTap: () {
        listDoc.length >= 15
            ? log("penuh")
            : showDialog(
          context: context,
          builder: (context) => dialogImageDokument(isDoc, false),
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
              Icons.attach_file_rounded,
              size: Get.width / 7,
            ),
            // Text(controller.listImages.value.length.toString() + "/" + "15"),
          ],
        ),
      ),
    );
  }

  btnKirim({
    required Color backGround,
    required Color textColor,
    required String text,
    Function? onClick
  }){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: yd_defauld_padding),
      child: InkWell(
        onTap: ()=>onClick!(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          width: Get.width,
          height: 45,
          decoration: BoxDecoration(
            color: backGround,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemEdit({
    required File image,
    required int index,
    Function? onRefresh
    }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: menuEditImage(
            index: index,
            image: image,
            onRefresh: onRefresh!()
        ),
        elevation: 0,
      ),
    );
  }

  Widget menuEditImage({
    required File image,
    required int index,
    Function? onRefresh
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
                onPressed: () =>shwoDetailImage( a:image),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.open_in_full_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding),
                      Text("Lihat Foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,),),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary,),
                onPressed: () {
                  setState(() {
                    listDoc.removeAt(index);
                    Get.back();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding),
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
                  child: Text("Ganti Foto",style: TextStyle(fontSize: 11)),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary,
                ),
                onPressed: () {
                  getImageCamera(true, true, index);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding),
                      Text("Camera",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "RR",color: Colors.black,)),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary),
                onPressed: ()=>getImageGallery(true, true, index),
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
                onPressed: ()=>getImageGallery(true, true, index),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}