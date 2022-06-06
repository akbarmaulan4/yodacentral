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
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/kredit/kredit_controller.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/cek_nomor-polisi.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/mobil_diiklan.dart';
import 'package:yodacentral/utils/debouncher.dart';
import 'package:yodacentral/utils/utils.dart';

class KontrakView extends StatefulWidget {
  int? unit_id;
  int? lead_id;
  Function? onNext;
  KontrakView({this.unit_id, this.lead_id, this.onNext});
  @override
  _KontrakViewState createState() => _KontrakViewState();
}

class _KontrakViewState extends State<KontrakView> {

  KreditController controller = Get.put(KreditController());
  final ImagePicker _picker = ImagePicker();
  var debouncher = new Debouncer(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setEnableKontrak();
    controller.initFormKredit();
    controller.getTenor(false);
    controller.initKontrakKredit();
    // controller.getNewProv();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(()=>Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kontrak'),
            SizedBox(height: 15),
            standartField(
              label: "Nomor Kontrak Kredit",
              controller: controller.edtNoKontrak,
              type: TextInputType.number,
              focused: controller.noKontrakFocus.value,
              node: controller.focusNoKontrak,
              errorMessag: controller.msgErrorNoKontrak.value,
              onChange: (val){
                debouncher.run(() {
                  controller.checkNoKontrak(context, controller.edtNoKontrak.text, widget.lead_id!.toString());
                });
              }
            ),
            SizedBox(height: 15),
            Text('Kredit'),
            SizedBox(height: 15),
            fieldFree(
              label: controller.tenorLoad.value ? "Memuat..." : "Tenor",
              ctrl: controller.edtTenor,
              items: controller.modelTenor.value.data,
              value: controller.selectedTenor.value,
              focusNode: controller.focusTenor,
              focused: controller.tenorFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Down Payment',
              controller: controller.edtDP,
              focusNode: controller.focusDP,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.dpFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Pokok Pinjaman',
              controller: controller.edtPokokPinjam,
              focusNode: controller.focusPokokPinjam,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.pokokPinjamFocus.value
            ),
            SizedBox(height: 15),
            standartField(label: "Bunga (%)",
                controller: controller.edtBunga,
                type: TextInputType.number,
                node: controller.focusBunga,
                onChange: (val){
                  controller.setEnableKontrak();
                  if(val != ''){
                    if(int.parse(val) > 100){
                      val = '100';
                      controller.edtBunga.text = val;
                      controller.edtBunga.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                    }
                  }
                },
                focused: controller.bungaFocus.value),
            SizedBox(height: 15),
            standartField(label: "Suku Bunga Flat (%)",
                node: controller.focusBungaFlat,
                controller: controller.edtBungaFlat, type: TextInputType.number,
                focused: controller.bungaFlatFocus.value,
                onChange: (val){
                  controller.setEnableKontrak();
                  if(val != ''){
                    if(int.parse(val) > 100){
                      val = '100';
                      controller.edtBungaFlat.text = val;
                      controller.edtBungaFlat.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                    }
                  }
                }
            ),
            SizedBox(height: 15),
            standartField(label: "Suku Bunga Efektif (%)",
                node: controller.focusBungaEfektif,
                controller: controller.edtBungaEfektif, type: TextInputType.number,
                focused: controller.bungaEfektifFocus.value,
                onChange: (val){
                  controller.setEnableKontrak();
                  if(val != ''){
                    if(int.parse(val) > 100){
                      val = '100';
                      controller.edtBungaEfektif.text = val;
                      controller.edtBungaEfektif.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                    }
                  }
                }
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Total Pinjaman',
              controller: controller.edtTotalPinjam,
              focusNode: controller.focusTotalPinjam,
              onChanged: (val)=>controller.setEnableKontrak(),
              focused: controller.totalPinjamFocus.value,
              type: TextInputType.number,
            ),
            SizedBox(height: 15),
            SizedBox(height: 15),
            Text('Asuransi'),
            SizedBox(height: 15),
            fieldFree(
                label: controller.bayarAsuransiLoad.value ? "Memuat..." : "Pembayaran",
                ctrl: controller.edtPembayaran,
                items: controller.modelBayarAsuransi.value.data,
                value: controller.selectedBayarAsuransi.value,
                focusNode: controller.focusPembayaran,
                focused: controller.pembayaranFocus.value
            ),
            SizedBox(height: 15),
            fieldFree(
                label: controller.sertaAsuransiLoad.value ? "Memuat..." : "Kesertaan",
                ctrl: controller.edtKesertaan,
                items: controller.modelKesertaanAsuransi.value.data,
                value: controller.selectedKesertaanAsuransi.value,
                focusNode: controller.focusKesetaan,
                focused: controller.kesertaanFocus.value
            ),
            SizedBox(height: 15),
            fieldFree(
                label: controller.jenisLoad.value ? "Memuat..." : "Jenis",
                ctrl: controller.edtJenis,
                items: controller.modelJenis.value.data,
                value: controller.selectedJenis.value,
                focusNode: controller.focusJenis,
                focused: controller.jenisFocus.value
            ),
            SizedBox(height: 15),
            standartField(label: "Premi (%)",
                node: controller.focusPremi,
                controller: controller.edtPremi,
                type: TextInputType.number,
                focused: controller.premiFocus.value,
                onChange: (val){
                  controller.setEnableKontrak();
                  if(val != ''){
                    if(int.parse(val) > 100){
                      val = '100';
                      controller.edtPremi.text = val;
                      controller.edtPremi.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                    }
                  }

                }),
            SizedBox(height: 15),
            Text('Biaya'),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Administrasi',
              controller: controller.edtAdmin,
              focusNode: controller.focusAdmin,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.adminFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Fidusila',
              controller: controller.edtFidusila,
              focusNode: controller.focusFidusila,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.fidusiaFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Provisi',
              controller: controller.edtProvisi,
              focusNode: controller.focusProvisi,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.provinsiFocus.value
            ),
            SizedBox(height: 15),
            fieldFree(
                label: controller.nilaiTanggungLoad.value ? "Memuat..." : "Nilai Pertanggungan",
                ctrl: controller.edtNilaiTanggung,
                items: controller.modelNilaiTanggung.value.data,
                value: controller.selectedNilaiTanggung.value,
                focusNode: controller.focusNilaiTanggung,
                focused: controller.nilaiaTanggungFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Survey & Verifikasi',
              controller: controller.edtSurveyVerify,
              focusNode: controller.focusSurvey,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.surveyFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Notaris',
              controller: controller.edtNotaris,
              focusNode: controller.focusNotaris,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.notarisFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Total Biaya',
              controller: controller.edtTotalBiaya,
              focusNode: controller.focusTotalBiaya,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.totalBiayaFocus.value
            ),
            SizedBox(height: 15),
            Text('Angsuran'),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Angsuran(Rp)',
              controller: controller.edtAngsuran,
              focusNode: controller.focusAngsuran,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.angsuranFocus.value
            ),
            SizedBox(height: 15),
            fieldFree(
                label: controller.angsuranLoad.value ? "Memuat..." : "Angsuran Pertama",
                ctrl: controller.edtAngsuranPertama,
                items: controller.modelAngsuran.value.data,
                value: controller.selectedAngsuran.value,
                focusNode: controller.focusAngsuranPertama,
                focused: controller.angsuranPertanaFocus.value
            ),
            SizedBox(height: 15),
            Text('Nilai Pencairan'),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Nilai Pencairan(Rp)',
              controller: controller.edtNilaiCair,
              focusNode: controller.focusCair,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.cairFocus.value
            ),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Nilai Total DP',
              controller: controller.edtNilaiTotalDP,
              focusNode: controller.focusTotalDP,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.totalDPFocus.value
            ),
            SizedBox(height: 15),
            Text('Komisi Seller/Supplier'),
            SizedBox(height: 15),
            fieldRupiah(
              label: 'Dari NVP',
              controller: controller.edtNVP,
              focusNode: controller.focusNVP,
              onChanged: (val)=>controller.setEnableKontrak(),
              type: TextInputType.number,
              focused: controller.nvpFocus.value
            ),
            SizedBox(height: 15),
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
                      noImage(),
                      for (var i = 0; i < controller.listImagesKontrak.value.length; i++)
                        GestureDetector(
                          onTap: () {
                            log("message");
                            showDialog(
                              context: context,
                              builder: (context) => itemEdit(
                                  image: controller.listImagesKontrak.value[i],
                                  index: i,
                                  onRefresh: (){}
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
                              child: Image.file(controller.listImagesKontrak.value[i], fit: BoxFit.cover),
                            ),
                          ),
                        ),
                    ],
                  )),
            ),
            SizedBox(height: yd_defauld_padding * 3),
            btnKirim(
              backGround: controller.enableButtonKontrak.value ? yd_Color_Primary:yd_Color_Primary_Grey,
              textColor: Colors.white,
              text: 'Kirim',
              onClick: (){
                if(controller.enableButtonKontrak.value){
                  controller.postKreditKontrak(context, widget.lead_id.toString(), listImage, (){
                    controller.postDokumenKontrak(
                        context: context,
                        imageAwal: [],
                        imageChange: [],
                        id: widget.lead_id.toString(),
                        imageBaru: listImage,
                        onSuccess: (){
                          if(controller.enableButtonJaminan.value){
                            controller.postKreditJaminan(context, widget.lead_id.toString(), controller.listImagesJaminan.value, (){
                              controller.postDokumenJaminan(
                                  context: context,
                                  imageAwal: [],
                                  imageChange: [],
                                  id: widget.lead_id.toString(),
                                  imageBaru: controller.listImagesJaminan.value,
                                  onSuccess: (){
                                    Get.bottomSheet(
                                      GlobalScreenNotif(
                                        title: "Berhasil",
                                        content: "Kontrak Kredit Berhasil dikirim",
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
                              );
                            });
                          }else{
                            Get.bottomSheet(
                              GlobalScreenNotif(
                                title: "Berhasil",
                                content: "Kontrak Kredit Berhasil dikirim",
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
                        }
                    );
                  });
                }

              }
            )
          ],
        )),
      ),
    );
  }

  noImage(){
    return GestureDetector(
      onTap: () {
        controller.listImages.value.length >= 15
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
              Icons.attach_file_rounded,
              size: Get.width / 7,
            ),
            // Text(controller.listImages.value.length.toString() + "/" + "15"),
          ],
        ),
      ),
    );
  }

  Widget itemEdit({required File image, required int index, Function? onRefresh}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: doo(
          index: index,
          image: image,
          onRefresh: onRefresh!()
        ),
        elevation: 0,
      ),
    );
  }

  Widget doo({
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
                    listImage.removeAt(index);
                    Get.back();
                  });
                  // controller.removeImage(index, ()=>onRefresh);
                  // Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded, color: Colors.black),
                      SizedBox(
                        width: yd_defauld_padding,
                      ),
                      Text("Hapus", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RR", color: Colors.black,)),
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

  List<File> listImage = [];
  getImageGallery({int? index}) async {
    Get.back();
    if (index != null) {
      XFile? xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
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
          });
        }
      }
    }
    controller.changeImageKontrak(listImage);
  }

  getImageCamera({int? index}) async {
    Get.back();
    XFile? xFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
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
    controller.changeImageKontrak(listImage);
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
            shadow ? BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5,) :
            BoxShadow(color: Colors.black.withOpacity(0.0), blurRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(primary: yd_Color_Primary,),
            onPressed: ()=>getImageCamera(),
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
            onPressed: () =>getImageGallery(),
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

  standartField({
    String? label,
    TextEditingController? controller,
    TextInputType? type,
    Function? onChange,
    FocusNode? node,
    bool focused = false,
    String? errorMessag,
  }){
    return  Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        focusNode: node,
        inputFormatters:(label!.contains('Bunga') || label.contains('Premi')) ? [
          LengthLimitingTextInputFormatter(3),
        ]:[],
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
          errorText: errorMessag != '' ? errorMessag : null,
          fillColor: Colors.white,
          hintText: label,
          labelText: label,
          labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          suffix: (label.contains('Bunga') || label.contains('Premi')) ? Text('%'):null
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
    bool focused = false,
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
        if (label == "Tenor") {
          controller.setTenor(data!);
        } else if (label == "Pembayaran") {
          controller.setPembayaran(data!);
        } else if (label == "Kesertaan") {
          controller.setKesertaan(data!);
        } else if (label == "Jenis") {
          controller.setJenis(data!);
        } else if (label == "Nilai Pertanggungan") {
          controller.setPertanggungan(data!);
        } else if (label == "Angsuran Pertama") {
          controller.setAngsuran(data!);
        }
        controller.setEnableKontrak();
      },
    );
  }

  customeField({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
    bool? show = true,
    Widget? sufix,
    bool readOnly = false,
    Function()? onTap,
    bool focused = false,
  }){
    return TextFormField(
      inputFormatters:
      label == "Catatan" ? null : label == "Nomor Polisi" ? [UpperCaseTextFormatter()] :
      [FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),ThousandsSeparatorInputFormatter(),
        if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
        CreditCardFormatter()
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {},
      onChanged: (v)=>onChanged(v),
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
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary, width: 2),borderRadius: BorderRadius.circular(4)),
      )
    );
  }

  fieldRupiah({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
    bool? show = true,
    Widget? sufix,
    bool readOnly = false,
    Function()? onTap,
    bool focused = false,
  }){
    return TextFormField(
        inputFormatters: label == "Catatan" ? null : label == "Nomor Polisi" ? [UpperCaseTextFormatter()] :
        [FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),ThousandsSeparatorInputFormatter(),
    if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
    CreditCardFormatter()
    ],
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (v) {},
    onChanged: (v)=>onChanged(v),
    onTap: onTap,
    readOnly: readOnly,
    controller: controller,
    focusNode: focusNode,
    keyboardType: type,
    maxLines: label == "Catatan" ? 4 : 1,
    decoration: InputDecoration(
    prefix: Text("Rp "),
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: label == "Catatan" ? 8 : 0),
    errorText: messageApi == null ? null : messageApi,
    labelText: label,
    labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),borderRadius: BorderRadius.circular(4),),
    border: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary, width: 2), borderRadius: BorderRadius.circular(4)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary, width: 2),borderRadius: BorderRadius.circular(4)),
    )
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
