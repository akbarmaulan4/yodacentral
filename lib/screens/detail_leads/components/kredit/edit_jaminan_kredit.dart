import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/kredit/kredit_controller.dart';
import 'package:yodacentral/models/model_detail_kredit.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/cek_nomor-polisi.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/mobil_diiklan.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/unggah_foto.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/widget/dynamic_foto.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';

class EditJaminanKredit extends StatefulWidget {

  int? id_unit;
  int? lead_id;
  String? namePipeline;
  ModelDetailKredit? data;
  Function? onBack;
  EditJaminanKredit({this.id_unit, this.namePipeline, this.data, this.lead_id, this.onBack});

  @override
  _EditJaminanKreditState createState() => _EditJaminanKreditState();
}

class _EditJaminanKreditState extends State<EditJaminanKredit> {


  KreditController controller = KreditController();
  final ImagePicker _picker = ImagePicker();
  List<String> imageAwal = [];
  List<ModelListImageUpload> imageChange = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initFocusKredit();
    controller.setEnableJaminan();
    controller.getUnit(unitId: widget.lead_id);
    controller.initJaminan(widget.data!);
    imageAwal = widget.data!.data!.photo_document!.document_jaminan!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("#" + widget.id_unit.toString(), style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
      body: Obx(()=>Container(
        padding: EdgeInsets.all(yd_defauld_padding),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(child: Text('Edit Jaminan', style: TextStyle(fontSize: 22,), textAlign: TextAlign.center)),
              SizedBox(height: 30),
              Text(controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.dataUnit!.name! : '',  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Text(controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.dataUnit!.note!:''),
              SizedBox(height: 20),
              leftRighView('Nomor Polisi', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.nomerPolisi!:''),
              leftRighView('Kondisi Mobil', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.kondisi!:''),
              leftRighView('Merek', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.merek!:''),
              leftRighView('Model', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.model!:''),
              leftRighView('Varian', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.varian!:''),
              leftRighView('Tahun', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.tahun.toString():''),
              leftRighView('Jarak Tempuh', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.jarakTempuh!:''),
              leftRighView('Bahan Bakar', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.bahanBakar!:''),
              leftRighView('Transmisi', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.transmisi!:''),
              leftRighView('Warna', controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.warna!:''),
              leftRighView('Tipe Body', '-'),
              leftRighView('Kategori Unit', '-'),
              SizedBox(height: 10,),
              Text('Harga dan Pembiayaan'),
              SizedBox(height: 15),
              customeField(
                label: 'Harga Jual',
                controller: controller.edtHargaJual,
                focusNode: controller.focusHargaJual,
                onChanged: (val)=>controller.setEnableJaminan(),
                focused: controller.hargaJualFocus.value,
                type: TextInputType.number,
              ),
              SizedBox(height: 15),
              customeField(
                label: 'Harga OTR',
                controller: controller.edtHargaOTR,
                focusNode: controller.focusHargaOTR,
                onChanged: (val)=>controller.setEnableJaminan(),
                focused: controller.OTRFocus.value,
                type: TextInputType.number,
              ),
              SizedBox(height: 15),
              customeField(
                label: 'Maximum Pembayaran',
                controller: controller.edtMaxBayar,
                focusNode: controller.focusMaxBayar,
                onChanged: (val)=>controller.setEnableJaminan(),
                focused: controller.maxBayarFocus.value,
                type: TextInputType.number,
              ),
              SizedBox(height: 25),
              Text('Surat Kendaraan'),
              SizedBox(height: 15),
              standartField(label: 'Nomor Rangka',
                controller: controller.edtNoRangka,
                node: controller.focusNoRangka,
                focused: controller.noRangkaFocus.value,
                onChange: (val)=>controller.setEnableJaminan(),),
              standartField(label: 'Nomor Mesin',
                controller: controller.edtNoMesin, node: controller.focusNoMesin,
                focused: controller.noMesinFocus.value,
                onChange: (val)=>controller.setEnableJaminan(),),
              standartField(label: 'Nama Pemilik BPKB',
                controller: controller.edtNamaBPKB, node: controller.focusNamaBPKB,
                focused: controller.namaBPKBFocus.value,
                onChange: (val)=>controller.setEnableJaminan(),),
              standartField(label: 'Nomor BPKB',
                controller: controller.edtNoBPKB, node: controller.focusNoBPKB,
                focused: controller.noBPKBFocus.value,
                onChange: (val)=>controller.setEnableJaminan(),),
              fieldFree(
                label: controller.provLoad.value ? "Memuat..." : "Provinsi",
                value: controller.selectedProv.value,
                ctrl: controller.edtProvinsi,
                items: controller.provLoad.value ? []: controller.modelProv.value.data,
                focusNode: controller.focusProvisi,
                focused: controller.provinsiFocus.value
              ),
              SizedBox(height: yd_defauld_padding,),
              fieldFree(
                label: controller.kotaLoad.value ? "Memuat..." : "Kota/Kabupaten",
                value: controller.selectedKota.value,
                ctrl: controller.edtKota,
                items: controller.kotaLoad.value? []: controller.modelKota.value.data,
                focusNode: controller.focusKota,
                focused: controller.kotaFocus.value
              ),
              SizedBox(height: yd_defauld_padding,),
              customeField(
                  onTap: ()=>controller.openDatePicker(context, controller.edtTglExBPKB),
                  onChanged: (val)=>controller.setEnableJaminan(),
                  focusNode: controller.focusTglExBPKB,
                  label: "Tanggal Kadaluarsa BPKB",
                  controller: controller.edtTglExBPKB,
                  readOnly: true,
                  focused: controller.tglExBPKBFocus.value,
                  sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,)
              ),
              SizedBox(height: 15),
              customeField(
                  onTap: ()=>controller.openDatePicker(context, controller.edtTglExSTNK),
                  onChanged:(val)=>controller.setEnableJaminan(),
                  focusNode: controller.focusTglExSTNK,
                  label: "Tanggal Kadaluarsa STNK",
                  controller: controller.edtTglExSTNK,
                  readOnly: true,
                  focused: controller.tglExSTNKFocus.value,
                  sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,)
              ),
              SizedBox(height: yd_defauld_padding * 2),
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
                            showDialog(
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
                                Icon(Icons.attach_file_rounded, size: Get.width / 7),
                              ],
                            ),
                          ),
                        ),
                        if (widget.data!.data!.photo_document!.document_jaminan!.length <= 0 || widget.data!.data!.photo_document!.document_jaminan!.isEmpty)
                          SizedBox(width: 0, height: 0)
                        else
                          for (var i = 0; i < widget.data!.data!.photo_document!.document_jaminan!.length; i++)
                            DynamicFoto(
                              hapusFoto: (v) {
                                setState(() {
                                  imageAwal.removeWhere((element) => element == widget.data!.data!.photo_document!.document_jaminan![i]);
                                  widget.data!.data!.photo_document!.document_jaminan!.removeWhere((element) => element == widget.data!.data!.photo_document!.document_jaminan!);
                                });
                              },
                              urlImage: widget.data!.data!.photo_document!.document_jaminan![i],
                              index: i,
                              onClick: (file) {
                                if (imageChange.where((element) => element.index == i).isNotEmpty) {
                                  setState(() {
                                    imageChange.where((element) => element.index == i).first.image = file.image;

                                    imageAwal.where((element) => element == widget.data!.data!.photo_document!.document_jaminan![i]).isEmpty
                                        ? log("tidak remove")
                                        : imageAwal.removeWhere((element) => element == widget.data!.data!.photo_document!.document_jaminan![i]);
                                  });
                                  log("ini where");
                                } else {
                                  setState(() {
                                    imageChange.add(file);
                                    imageAwal.where((element) =>element == widget.data!.data!.photo_document!.document_jaminan!).isEmpty
                                        ? log("tidak remove")
                                        : imageAwal.removeWhere((element) => element == widget.data!.data!.photo_document!.document_jaminan![i]);
                                  });
                                }
                              },
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
              ),
              SizedBox(height: yd_defauld_padding * 3),
              btnKirim(
                  backGround: controller.enableButtonJaminan.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                  textColor: Colors.white,
                  text: 'Simpan',
                  onClick: (){
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if(controller.enableButtonJaminan.value){
                        controller.updateJaminan(context, widget.lead_id!, (data)=> controller.updateDokumenJaminan(
                            context: context,
                            imageAwal: imageAwal,
                            imageChange: imageChange,
                            id: widget.lead_id.toString(),
                            imageBaru: listImage,
                            onSucess: ()=>widget.onBack!('OK')
                        ));
                      }
                    });
                  }
              )
            ],
          ),
        ),
      )),
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
      listImage.removeAt(index);
      Get.back();
    });
  }
  noImage(bool isDoc){
    return GestureDetector(
      onTap: () {
        if(isDoc){
          imageAwal.length >= 15
              ? log("penuh")
              : showDialog(
            context: context,
            builder: (context) => dialogImage(),
            barrierColor: Colors.white.withOpacity(0.4),
          );
        }else{
          showDialog(
            context: context,
            builder: (context) => dialogImage(),
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

  List<File> listImage = [];
  getImageGallery({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    if (!isImageEditAwal) {
      if (index != null) {
        XFile? xFile = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 30);
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
          });
        }
      } else {
        List<XFile>? mul = await _picker.pickMultiImage(imageQuality: 30);
        if (mul!.length == 0) {
          log("kosong", name: "ini edit foto unit");
        } else {
          if (((listImage.length + widget.data!.data!.photo_document!.document_jaminan!.length) + mul.length) > 15) {
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
            });
          }
        }
      }
    } else {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
      });
    }
  }

  getImageCamera({int? index, required bool isImageEditAwal, ValueChanged<File>? imageFile}) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    if (!isImageEditAwal) {
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
        });
      }
    } else {
      log("ini edit image awal");
      setState(() {
        imageFile!(File(xFile!.path));
      });
    }
  }

  leftRighView(String label, String value){
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontSize: 16,)),
              Expanded(child: Container(
                alignment: Alignment.centerRight,
                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ))
            ],
          ),
          SizedBox(
            height: yd_defauld_padding,
          ),
          Divider()
        ],
      ),
    );
  }

  customeField({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    bool focused = false,
    TextInputType? type,
    String? messageApi,
    bool? show = true,
    Widget? sufix,
    bool readOnly = false,
    Function()? onTap,
  }){
    return TextFormField(
        inputFormatters:
        label == "Catatan" ? null : label == "Nomor Polisi" ? [UpperCaseTextFormatter()] :
        [FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),ThousandsSeparatorInputFormatter(),
          if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
          CreditCardFormatter()
        ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v){},
      onChanged: (v) => onChanged(v),
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: type,
      maxLines: label == "Catatan" ? 4 : 1,
      decoration: InputDecoration(
      prefix: label.toLowerCase().contains('harga') ||  label.toLowerCase().contains('pembayaran') ? Text("Rp ") : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: label == "Catatan" ? 8 : 0),
      errorText: messageApi == null ? null : messageApi,
      labelText: label,
      labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),borderRadius: BorderRadius.circular(4),),
      border: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary, width: 2), borderRadius: BorderRadius.circular(4)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary, width: 2),borderRadius: BorderRadius.circular(4)))
    );
  }

  standartField({
    String? label,
    TextEditingController? controller,
    TextInputType? type,
    Function? onChange,
    FocusNode? node,
    bool focused = false,
  }){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        focusNode: node,
        controller: controller,
        keyboardType: type,
        onChanged: (val) => onChange!(val),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: yd_Color_Primary, width: 2)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          fillColor: Colors.white,
          hintText: label,
          labelText: label,
          labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        ),
        // onChanged: (val)=> controller.isEnableLogin(),
      ),
    );
  }

  fieldFree({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController ctrl,
    required FocusNode focusNode,
    bool focused = false
  }) {
    return TypeAheadField<Datum?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      hideOnError: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: ctrl,
        focusNode: focusNode,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.arrow_drop_down_rounded,
              color: yd_Color_Primary_Grey,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            // hintText: label,
            labelText: label,
            labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
        ),
      ),
      suggestionsCallback: (search) {
        return items!.where((element) => element.name!.toLowerCase().contains(search.toLowerCase())).toList();
      },
      itemBuilder: (context, Datum? datum) {
        return ListTile(title: Text(datum!.name!),);
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text('tidak ditemukan', style: TextStyle(fontSize: 12),),
        ),
      ),
      onSuggestionSelected: (Datum? data) {
        if (label == "Provinsi") {
          controller.setProvinsi(data!);
        } else if (label == "Kota/Kabupaten") {
          controller.setKota(data!);
        } else if (label == "Kecamatan") {
          controller.setKecamatan(data!);
        }
        controller.setEnableJaminan();
      },
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
}
