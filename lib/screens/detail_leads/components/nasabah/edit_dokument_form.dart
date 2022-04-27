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
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/models/model_detail_nasabah.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/square_image_old.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/widget/dynamic_foto.dart';
import 'package:yodacentral/utils/utils.dart';

class EditDokumentForm extends StatefulWidget {
  int? id_unit;
  int? lead_id;
  String? namePipeline;
  ModelDetailNasabah? data;
  Function? onBack;
  EditDokumentForm({this.id_unit, this.lead_id, this.namePipeline, this.data, this.onBack});

  @override
  _EditDokumentFormState createState() => _EditDokumentFormState();
}

class _EditDokumentFormState extends State<EditDokumentForm> with AutomaticKeepAliveClientMixin{

  NasabahController controller = NasabahController();

  List<File> listDoc = [];
  File? finalImage;
  final ImagePicker _picker = ImagePicker();

  getImageGalleryNasabah({int? index}) async {
    Get.back();
    if (index != null) {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
      if (xFile != null) {
        controller.setEnableButtonFoto(xFile.path);
        setState(() {
          finalImage = File(xFile.path);
        });
      }
    } else {
      List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 100);
      if (mul!.length == 0) {
        log("kosong", name: "ini unggah foto");
      } else {
        if ((listDoc.length + mul.length) > 15) {
          log((listDoc.length + mul.length).toString(),
              name: "jumlah keduanya");
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
  }

  getImageCameraNasabah({int? index}) async {
    Get.back();
    XFile? xFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (index != null) {
      if (xFile != null) {
        controller.setEnableButtonFoto(xFile.path);
        setState(() {
          finalImage = File(xFile.path);
        });
      }
    } else {
      setState(() {
        listDoc[index!] = File(xFile!.path);
      });
    }
  }

  getImageGallery({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    if (!isImageEditAwal) {
      if (index != null) {
        XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
        if (index == null) {
          if (xFile == null) {
            log("null");
          } else {
            setState(() {
              listDoc.add(File(xFile.path));
            });
          }
        } else {
          setState(() {
            listDoc[index] = File(xFile!.path);
          });
        }
      } else {
        List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 100);
        if (mul!.length == 0) {
          log("kosong", name: "ini edit foto unit");
        } else {
          setState(() {
            for (var q in mul) {
              listDoc.add(File(q.path));
            }
          });
        }
      }
    } else {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
      });
    }
  }
  //
  getImageCamera({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (!isImageEditAwal) {
      if (index == null) {
        if (xFile == null) {
          log("null");
        } else {
          setState(() {
            listDoc.add(File(xFile.path));
          });
        }
      } else {
        setState(() {
          listDoc[index] = File(xFile!.path);
        });
      }
    } else {
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
      });
    }
  }

  Widget dialogImage(bool isDoc) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: di(
            shadow: false,
            isDoc: isDoc
        ),
      ),
    );
  }

  Widget dialogImageFotoNasabah() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: di(
            shadow: false,
            isDoc: false
        ),
      ),
    );
  }

  Widget di({required bool shadow, bool? isDoc}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 2.1,
      decoration: BoxDecoration(
          color: Color(0xFFF5F9F8),
          borderRadius: BorderRadiusDirectional.circular(16),
          boxShadow: [
            shadow ? BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)
                : BoxShadow(color: Colors.black.withOpacity(0.0), blurRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed: ()=> isDoc! ? getImageCamera(isImageEditAwal: false,):getImageCameraNasabah(index: 1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Colors.black),
                  SizedBox(width: yd_defauld_padding),
                  Text("Camera", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed:()=>isDoc! ? getImageGallery(isImageEditAwal: false): getImageGalleryNasabah(index: 1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.photo_library_rounded, color: Colors.black,),
                  SizedBox(width: yd_defauld_padding),
                  Text("Album foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black)),
                ],
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary),
            onPressed:()=> isDoc! ?  getImageGallery(isImageEditAwal: false):getImageGalleryNasabah(index: 1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.folder_rounded, color: Colors.black,),
                  SizedBox(width: yd_defauld_padding),
                  Text("Dokumen", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<String> imageAwal = [];
  List<ModelListImageUpload> imageChange = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.enableButton.value = true;
    if(widget.data!.data!.document!.photoDocument!.length > 0){
      imageAwal = widget.data!.data!.document!.photoDocument!;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.namePipeline!, style: TextStyle(color: Colors.black, fontSize: 16,),),
                Text("#" + widget.lead_id.toString(), style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
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
                    builder: (context) => dialogImageFotoNasabah(),
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
                        Text("Foto Nasabah", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                        SizedBox(height: 15),
                        finalImage != null ?  SizedBox(
                          width: Get.width,
                          height: Get.width - 30,
                          child: finalImage == null
                              ? Icon(Icons.camera_alt, size: Get.width / 5)
                              : Image.file(
                            finalImage!,
                            fit: BoxFit.cover,
                          ),
                        ): SizedBox(
                          width: Get.width,
                          height: Get.width - 30,
                          child: widget.data!.data!.document!.photo_nasabah! != '' ?
                            imageNetworkHandler(urlImage: widget.data!.data!.document!.photo_nasabah!, nama: null,):noImage(false)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(15), child: DottedBorder(
              radius: Radius.circular(8),
              color: yd_Color_Primary_Grey.withOpacity(0.1),
              strokeWidth: 2,
              borderType: BorderType.RRect,
              dashPattern: [10, 1],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Foto Dokumen", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                  ),
                  Container(
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
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => dialogImage(true),
                                  barrierColor: Colors.white.withOpacity(0.4));
                            },
                            child: Container(
                              width: Get.width / 2.4,
                              height: Get.width / 2.4,
                              decoration: BoxDecoration(
                                color: yd_Color_Primary_Grey
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.attach_file_rounded, size: Get.width / 7),
                                ],
                              ),
                            ),
                          ),
                          if (widget.data!.data!.document!.photoDocument!.length <= 0 || widget.data!.data!.document!.photoDocument!.isEmpty)
                            SizedBox(width: 0, height: 0)
                          else
                            for (var i = 0; i < widget.data!.data!.document!.photoDocument!.length; i++)
                              DynamicFoto(
                                hapusFoto: (v) {
                                  setState(() {
                                    imageAwal.removeWhere((element) => element == widget.data!.data!.document!.photoDocument![i]);
                                    widget.data!.data!.document!.photoDocument!.removeWhere((element) => element == widget.data!.data!.document!.photoDocument!);
                                  });
                                },
                                // onCover: (index){
                                //   Utils.messageDialog(context, 'Informasi', 'Apakah anda mau menjadikan ini sebgai Cover?', () {
                                //     simpanImage(index);
                                //   });
                                // },
                                urlImage: widget.data!.data!.document!.photoDocument![i],
                                index: i,
                                onClick: (file) {
                                  if (imageChange.where((element) => element.index == i).isNotEmpty) {
                                    setState(() {
                                      imageChange.where((element) => element.index == i).first.image = file.image;
                                      // imageAwall.removeAt(i);
                                    });
                                    imageAwal.where((element) => element == widget.data!.data!.document!.photoDocument![i]).isEmpty
                                        ? log("tidak remove")
                                        : imageAwal.removeWhere((element) => element == widget.data!.data!.document!.photoDocument![i]);
                                    log("ini where");
                                  } else {
                                    setState(() {
                                      imageChange.add(file);
                                      imageAwal.where((element) =>element == widget.data!.data!.document!.photoDocument!).isEmpty
                                          ? log("tidak remove")
                                          : imageAwal.removeWhere((element) => element == widget.data!.data!.document!.photoDocument![i]);
                                    });
                                  }
                                },
                              ),
                          for (var i = 0; i < listDoc.length; i++)
                            GestureDetector(
                              onTap: () {
                                log("message");
                                showDialog(
                                  context: context,
                                  builder: (context) => itemEdit(
                                    image: listDoc[i],
                                    index: i,
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
                                  child: Image.file(listDoc[i], fit: BoxFit.cover),
                                ),
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            )),
            SizedBox(height: yd_defauld_padding * 6),
            Container(
              child: btnKirim(
                  backGround: controller.enableButton.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                  textColor: Colors.white,
                  text: 'Kirim',
                  onClick: (){
                    // var ssda = listDoc;
                    // var sdaa = finalImage;
                    // var dasd = imageAwal;
                    // var adsdsa = imageChange;
                    // var doc = widget.data!.data!.document!.photoDocument!;
                    // List<File> fileImgChange = [];
                    // for (var i = 0; i < imageChange.length; i++) {
                    //   fileImgChange.add(File(imageChange[i].image!.path));
                    // }
                    if(controller.enableButton.value){
                      controller.updateDokumentNasabah(
                          context, widget.lead_id.toString(),
                          finalImage != null ? finalImage!.path:'',
                          listDoc, imageChange, imageAwal,
                          ()=>widget.onBack!()
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

  noImage(bool isDoc){
    return GestureDetector(
      onTap: () {
        if(isDoc){
          listDoc.length >= 15
              ? log("penuh")
              : showDialog(
            context: context,
            builder: (context) => dialogImage(isDoc),
            barrierColor: Colors.white.withOpacity(0.4),
          );
        }else{
          showDialog(
            context: context,
            builder: (context) => dialogImage(isDoc),
            barrierColor: Colors.white.withOpacity(0.4),
          );
        }

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

  Widget itemEdit({required File image, required int index}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: doo(
          index: index,
          image: image,
          isImageEdit: false,
        ),
        elevation: 0,
      ),
    );
  }

  Widget doo(
      {String? urlImage,
        File? image,
        int? index,
        required bool isImageEdit,
        ValueChanged<File>? imageFile}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 1,
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
                onPressed:()=>shwoDetailImage(a: image, urlImage: urlImage),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.open_in_full_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding),
                      Text("Lihat Foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary),
                onPressed:()=>deleteFile(index: index!),
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
              // TextButton(
              //   style: TextButton.styleFrom(primary: yd_Color_Primary,),
              //   onPressed: () {
              //     Utils.messageDialog(context, 'Informasi', 'Apakah anda mau menjadikan ini sebgai Cover?', () {
              //       simpanImage(index!);
              //     });
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              //     child: Row(
              //       children: [
              //         Icon(Icons.photo_album, color: Colors.black),
              //         SizedBox(width: yd_defauld_padding,),
              //         Text("Jadikan Cover", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
              //       ],
              //     ),
              //   ),
              // ),
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
                  child: Text("Ganti Foto", style: TextStyle(fontSize: 11,),),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary),
                onPressed: () {
                  getImageCamera(
                    index: index,
                    isImageEditAwal: isImageEdit,
                    imageFile: (f) {
                      setState(() {
                        imageFile!(f);
                      });
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding),
                      Text("Camera", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black),),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary),
                onPressed: () {
                  getImageGallery(
                    index: index,
                    isImageEditAwal: isImageEdit,
                    imageFile: (f) {
                      setState(() {
                        imageFile!(f);
                      });
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.photo_library_rounded, color: Colors.black),
                      SizedBox(width: yd_defauld_padding,),
                      Text("Album foto", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black),),
                    ],
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary,),
                onPressed: () {
                  getImageGallery(
                    index: index,
                    isImageEditAwal: isImageEdit,
                    imageFile: (f) {
                      setState(() {
                        imageFile!(f);
                      });
                    },
                  );
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

  deleteFile({required int index}) {
    setState(() {
      listDoc.removeAt(index);
      Get.back();
    });
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
