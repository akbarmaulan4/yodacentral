import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/foto/foto_controller.dart';
import 'package:yodacentral/models/model_edit/model_detail_edit_unit_image.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/unggah_foto.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/square_image_old.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/utils/utils.dart';

class EditFotoUnit extends StatefulWidget {
  const EditFotoUnit(
      {Key? key,
      required this.id_unit,
      required this.lead_id,
      required this.namePipeline,
      required this.getData})
      : super(key: key);
  final int id_unit;
  final int lead_id;
  final String namePipeline;
  final ValueChanged<bool> getData;

  @override
  _EditFotoUnitState createState() => _EditFotoUnitState();
}

class _EditFotoUnitState extends State<EditFotoUnit> {
  bool load = true;
  ModelDetailEditUnitImage? modelDetailEditUnitImage;
  List<String> imageAwall = [];
  List<String> dataAwal = [];

  int posCover = 0;

  FotoController controller = FotoController();

  getListImage() async {
    setState(() {
      load = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = '${ApiUrl.domain.toString()}/api/lead/unit/edit/photo/${widget.id_unit.toString()}';
      var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});

      if (res.statusCode == 200) {
        setState(() {
          modelDetailEditUnitImage = modelDetailEditUnitImageFromMap(res.body);
          for (var i = 0;
              i < modelDetailEditUnitImage!.data!.image!.length;
              i++) {
            imageAwall.add(modelDetailEditUnitImage!.data!.image![i]);
            dataAwal.add(modelDetailEditUnitImage!.data!.image![i]);
          }
          load = false;
        });
        log(res.body);
      } else if (res.statusCode == 404) {
        rawBottomNotif(
          message: res.body,
          colorFont: Colors.white,
          backGround: Colors.red,
        );
        Get.back();
      } else {
        log(res.statusCode.toString());
        setState(() {
          load = false;
        });
        rawBottomNotif(
          message: res.body,
          colorFont: Colors.white,
          backGround: Colors.red,
        );
        log(res.body);
      }
    });
  }

  List<File> listImage = [];
  final ImagePicker _picker = ImagePicker();
  getImageGallery({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    if (!isImageEditAwal) {
      if (index != null) {
        XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
        if (index == null) {
          if (xFile == null) {
            log("null");
          } else {
            setState(() {
              listImage.add(File(xFile.path));
              isFirstLaunch = false;
            });
          }
        } else {
          setState(() {
            listImage[index] = File(xFile!.path);
            isFirstLaunch = false;
          });
        }
      } else {
        List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 70);
        if (mul!.length == 0) {
          log("kosong", name: "ini edit foto unit");
        } else {
          if (((listImage.length + modelDetailEditUnitImage!.data!.image!.length) + mul.length) > 15) {
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
              isFirstLaunch = false;
            });
          }
        }
      }
    } else {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
        isFirstLaunch = false;
      });
    }
  }

  getImageCamera({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (!isImageEditAwal) {
      if (index == null) {
        if (xFile == null) {
          log("null");
        } else {
          setState(() {
            listImage.add(File(xFile.path));
            isFirstLaunch = false;
          });
        }
      } else {
        setState(() {
          listImage[index] = File(xFile!.path);
          isFirstLaunch = false;
        });
      }
    } else {
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
        isFirstLaunch = false;
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
            shadow ? BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)
                : BoxShadow(color: Colors.black.withOpacity(0.0), blurRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed: () {
              getImageCamera(
                isImageEditAwal: false,
              );
            },
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
            onPressed:()=>getImageGallery(isImageEditAwal: false,),
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
            onPressed:()=>getImageGallery(isImageEditAwal: false),
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
              TextButton(
                style: TextButton.styleFrom(primary: yd_Color_Primary,),
                onPressed: () {
                  Utils.messageDialog(context, 'Informasi', 'Apakah anda ingin menjadikan ini sebagai Cover?', () {
                    setState(() {
                      isFirstLaunch = false;
                      posCover = index!;
                    });
                    // simpanImage(index!);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.photo_album, color: Colors.black),
                      SizedBox(width: yd_defauld_padding,),
                      Text("Jadikan Cover", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
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

  deleteFile({required int index}) {
    setState(() {
      listImage.removeAt(index);
      isFirstLaunch = false;
      Get.back();
    });
  }

  bool isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    getListImage();
  }

  List<ModelListImageUpload> imageChange = [];

  simpanImage(int cover) async {
    SaveRoot.callSaveRoot().then((value) async {
      modalLoad();
      var headers = {'Authorization': 'Bearer ' + value.token.toString()};
      String strUrl = '${ApiUrl.domain.toString()}/api/lead/unit/edit/photo/${widget.id_unit.toString()}';
      print('URL ${strUrl}');
      var request = http.MultipartRequest('POST', Uri.parse(strUrl.trim()));
      imageAwall.isEmpty || imageAwall.length <= 0 ? request.fields.addAll({'_method': 'put'}) :
      request.fields.addAll({'_method': 'put',
        for (var i = 0; i < imageAwall.length; i++)
          'preserved_photo[$i]': imageAwall[i]
      });
      if (imageChange.isEmpty && imageChange.length <= 0 && listImage.isEmpty && listImage.length <= 0) {
        log("image file kosong");
      } else {
        List<File> f = [];
        if (imageChange.length <= 0 || imageChange.isEmpty) {
          log("image change kosong");
        } else {
          for (var i = 0; i < imageChange.length; i++) {
            f.add(File(imageChange[i].image!.path));
          }
          log("image change add");
        }

        if (listImage.length <= 0 || listImage.isEmpty) {
          log("listIMage kosong");
        } else {
          for (var i = 0; i < listImage.length; i++) {
            f.add(File(listImage[i].path));
          }
        }

        if (f.isEmpty || f.length <= 0) {
          log("tidak ada file di upload");
        } else {
          for (var i = 0; i < f.length; i++) {
            request.files.add(await http.MultipartFile.fromPath('photo_unit[$i]', f[i].path,));
          }
          request.fields.addAll({
            for (var i = 0; i < f.length; i++)
              'photo_unit[$i]': f[i].path
          });

          // if(imageAwall.isEmpty){
          //   for (var i = 0; i < f.length; i++) {
          //     request.fields.addAll({'preserved_photo[$i]': '[]'});
          //   }
          // }
        }
      }

      request.fields.addAll({'cover': cover.toString()});
      print(jsonEncode(request.fields));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      // var jsonDecode = json.decode(response.toString());
      // var dataJson = jsonDecode as Map<String, dynamic>;
      // print('RESPONSE ${json.encode(jsonDecode)}');
      if (response.statusCode == 200) {
        if (Get.isBottomSheetOpen == true) Get.back();
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Berhasil",
            content: "Edit Foto Unit berhasil",
            onTap: () {
              setState(() {
                // posCover = 0;
                widget.getData(true);
              });
              Get.back();
            },
            textButton: "Selesai",
          ),
          isScrollControlled: true,
        );
      } else {
        var a = await response.stream.bytesToString();
        if (Get.isBottomSheetOpen == true) Get.back();
        rawBottomNotif(
          message: a,
          colorFont: Colors.white,
          backGround: Colors.red,
        );
        log(response.reasonPhrase.toString());
        log(response.statusCode.toString());
        log(a);
      }
    });
  }

  Future<bool> _onWillPop() async {
    if(posCover > 0){
      Utils.messageDialog(context, 'Informasi', 'Apakah anda yakin ingin keluar?', () {
        Get.back();
        // setState(() {
        //   isFirstLaunch = false;
        //   posCover = index!;
        // });
        // simpanImage(index!);
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          widget.getData(true);
        });
        log("back");
        if(posCover > 0){
          Utils.messageDialog(context, 'Informasi', 'Apakah anda yakin ingin keluar?', () {
            Navigator.pop(context);
          });
        }else{
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              setState(() {
                widget.getData(true);
              });
              if(posCover > 0){
                Utils.messageDialog(context, 'Informasi', 'Apakah anda yakin ingin keluar?', () {
                  Navigator.pop(context);
                });
              }else{
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.namePipeline,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "#" + widget.lead_id.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(yd_defauld_padding),
            child: load
                ? widgetLoadPrimary()
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Edit Foto",
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
                                    (listImage.length + modelDetailEditUnitImage!.data!.image!.length) >= 15
                                        ? log("penuh")
                                        : showDialog(
                                            context: context,
                                            builder: (context) => dialogImage(),
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
                                        Icon(Icons.camera_alt_rounded, size: Get.width / 7),
                                        Text((listImage.length + modelDetailEditUnitImage!.data!.image!.length).toString() + "/" + "15"),
                                      ],
                                    ),
                                  ),
                                ),
                                if (modelDetailEditUnitImage!.data!.image!.length <= 0 || modelDetailEditUnitImage!.data!.image!.isEmpty)
                                  SizedBox(width: 0, height: 0)
                                else
                                  for (var i = 0; i < modelDetailEditUnitImage!.data!.image!.length; i++)
                                    SquareImage(
                                      hapusFoto: (v) {
                                        log(modelDetailEditUnitImage!.data!.image![i].toString());
                                        v == null ? log("null") : log(v.path);
                                        setState(() {
                                          isFirstLaunch = false;
                                          if(posCover == i){
                                            posCover = 0;
                                          }
                                          imageAwall.removeWhere((element) => element == modelDetailEditUnitImage!.data!.image![i]);
                                          modelDetailEditUnitImage!.data!.image!.removeWhere((element) => element == modelDetailEditUnitImage!.data!.image![i],);
                                        });
                                      },
                                      onCover: (index){
                                        Utils.messageDialog(context, 'Informasi', 'Apakah anda ingin menjadikan ini sebagai Cover?', () {
                                          // simpanImage(index);
                                          setState(() {
                                            isFirstLaunch = false;
                                            posCover = index;
                                          });
                                        });
                                      },
                                      urlImage: modelDetailEditUnitImage!.data!.image![i],
                                      index: i,
                                      onClick: (file) {
                                        if (imageChange.where((element) => element.index == i).isNotEmpty) {
                                          setState(() {
                                            imageChange.where((element) => element.index == i).first.image = file.image;
                                            // imageAwall.removeAt(i);
                                          });
                                          imageAwall.where((element) => element == modelDetailEditUnitImage!.data!.image![i]).isEmpty
                                              ? log("tidak remove")
                                              : imageAwall.removeWhere((element) => element == modelDetailEditUnitImage!.data!.image![i]);
                                          log("ini where");
                                        } else {
                                          setState(() {
                                            imageChange.add(file);
                                            imageAwall.where((element) =>element ==modelDetailEditUnitImage!.data!.image![i]).isEmpty
                                                ? log("tidak remove")
                                                : imageAwall.removeWhere((element) => element == modelDetailEditUnitImage!.data!.image![i]);
                                          });
                                        }
                                      },
                                    ),
                                for (var i = 0; i < listImage.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => itemEdit(
                                          image: listImage[i],
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
        bottomNavigationBar: load ? null :
        (listImage.length + modelDetailEditUnitImage!.data!.image!.length) < 5 || (listImage.length + modelDetailEditUnitImage!.data!.image!.length) > 15 ?
          buttonDefaulLogin(
            backGround: yd_Color_Primary_Grey.withOpacity(0.3),
            textColor: Colors.white,
            text: "Simpan") :
          GestureDetector(
            onTap: ()=> !isFirstLaunch ? simpanImage(posCover):null,
            child: buttonDefaulLogin(
                backGround: !isFirstLaunch ? yd_Color_Primary : yd_Color_Primary_Grey.withOpacity(0.3),
                textColor: Colors.white,
                text: "Simpan"),
          ),
      ),
    );
  }
}

class ModelListImageUpload {
  int? index;
  File? image;
  ModelListImageUpload({
    this.image,
    this.index,
  });
}
