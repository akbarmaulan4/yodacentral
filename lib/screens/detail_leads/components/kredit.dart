import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/bottom_sheet_floating_add.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/function_wa_me.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/components/yd_text_style.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/controller/kredit/kredit_controller.dart';
import 'package:yodacentral/controller/unit/unit_controller.dart';
import 'package:yodacentral/models/model_detail_kredit.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/pipeline/pipeline_model.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/chat/chat.dart';
import 'package:yodacentral/screens/detail_leads/components/components/form_kredit.dart';
import 'package:yodacentral/screens/detail_leads/components/kredit/edit_jaminan_kredit.dart';
import 'package:yodacentral/screens/detail_leads/components/kredit/edit_kontrak_kredit.dart';
import 'package:yodacentral/screens/detail_leads/components/person_in_change.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/utils/utils.dart';

class Kredit extends StatefulWidget {
  const Kredit({
    Key? key,
    required this.isFinancing,
    required this.unit_id,
    required this.nameUnit,
    required this.idPipeline,
    required this.namePipeline,
    required this.lead_id,
  })
      : super(key: key);
  final int unit_id;
  final int lead_id;
  final bool isFinancing;
  final String nameUnit;
  final int idPipeline;
  final String namePipeline;

  @override
  _KreditState createState() => _KreditState();
}

class _KreditState extends State<Kredit> {
  bool load = true;
  // ModelDetailKredit? modelDetailKredit;
  List<String> fotoJaminan = [];
  List<String> fotoKontrak = [];
  List<String> allFoto = [];
  ControllerAuth auth = Get.put(ControllerAuth());
  UnitController unitController = UnitController();
  KreditController controller = KreditController();
  @override
  void initState() {
    super.initState();
    // getUnitDetail();
    unitController.changeIdPipeline(widget.idPipeline, widget.namePipeline);
    controller.getUnit(unitId: widget.lead_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(()=>Container(
        // padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: controller.dataKredit.value.data == null ? SizedBox(
            height: Get.height / 1.5,
            child: cantFind(
                title: null,
                content: "Belum ada Kredit untuk lead ini."),
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      // controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.dataUnit!.name ?? "-":'',
                      controller.id_kredir.value.toString(),
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Text('Data Jaminan', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    Text(
                      controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.dataUnit!.name ?? "-":'',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 15),
                    Text(controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.dataUnit!.note ?? "-":'',),
                    SizedBox(height: 30),
                    leftRighView('Kondisi Mobil',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.kondisi!:'', false),
                    leftRighView('Merek',  controller.dataUnit.value.data != null ?  controller.dataUnit.value.data!.spekUnit!.merek!:'', false),
                    leftRighView('Model',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.model! :'', false),
                    leftRighView('Varian',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.varian!:'', false),
                    leftRighView('Tahun',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.tahun!.toString():'', false),
                    leftRighView('Jarak Tempuh',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.jarakTempuh!:'', false),
                    leftRighView('Bahan Bakar',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.bahanBakar!:'', false),
                    leftRighView('Transmisi',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.transmisi!:'', false),
                    leftRighView('Warna',  controller.dataUnit.value.data != null ? controller.dataUnit.value.data!.spekUnit!.warna!:'', false),
                    leftRighView('Tipe Bodi',  "-", false),
                    leftRighView('Kategori Unit', "-", false),
                    leftRighView('Harga Jual',  controller.dataKredit.value.data != null ?  '${controller.dataKredit.value.data!.biaya!.hargaKendaraanBaru}':'', true),
                    leftRighView('Harga OTR',  controller.dataKredit.value.data != null ?  '${controller.dataKredit.value.data!.biaya!.hargaOnTheRoad}':'', true),
                    leftRighView('Maksimum Pembayaran',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.maxPembiayaanTrukKepu}':'', true)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Surat Kendaraan', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Nomor Rangka',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.spekUnit!.nomorRangka!:'', false),
                    leftRighView('Nomor Mesin',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.spekUnit!.nomorMesin!:'', false),
                    leftRighView('Nama Pemilik BPKB',  controller.dataKredit.value.data!.surat!.namaPemilikBpkb != null ? controller.dataKredit.value.data!.surat!.namaPemilikBpkb!:'', false),
                    leftRighView('Nomor BPKB',  controller.dataKredit.value.data!.surat!.nomorBpkb != null ? controller.dataKredit.value.data!.surat!.nomorBpkb!:'', false),
                    leftRighView('Kota Terbit BPKB',  controller.dataKredit.value.data!.surat!.kotaTerbitBpk != null ? controller.dataKredit.value.data!.surat!.kotaTerbitBpk.toString():'', false),
                    leftRighView('Tanggal Kadaluarsa BPKB',  controller.dataKredit.value.data!.surat!.tanggalBerlakuBpkb != null ? DateFormat("yyyy-MM-dd").format(controller.dataKredit.value.data!.surat!.tanggalBerlakuBpkb!):'', false),
                    leftRighView('Tanggal Kadaluarsa STNK',  controller.dataKredit.value.data!.surat!.masaBerlakuStnk != null ? DateFormat("yyyy-MM-dd").format(controller.dataKredit.value.data!.surat!.masaBerlakuStnk!):'', false)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kredit', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Tenor',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.tenor!}':'', false),
                    leftRighView('Down Payment',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.dp}':'', true),
                    leftRighView('Pokok Pinjaman',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.pokokPinjaman}':'', true),
                    leftRighView('Bunga',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.bunga}':'', false),
                    leftRighView('Suku Bunga Flat',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.sukuBungaFlat}':'', false),
                    leftRighView('Suku Bunga Efektif',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.sukuBungaEfektif}':'', false),
                    leftRighView('Total Pinjaman',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.totalPinjaman}':'', true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Asuransi', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Pembayaran',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.biaya!.pembayaranAsuransi!:'', false),
                    leftRighView('Kesertaan',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.biaya!.kesertaanAsuransi!:'', false),
                    leftRighView('Jenis',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.biaya!.jenisAsuransi! :'', false),
                    leftRighView('Premi',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.premiAsuransi}%':'', false),
                   ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Biaya', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Administrasi',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.biayaAdministrasi}':'', true),
                    leftRighView('Fidusia',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.biayaFudicia}':'', true),
                    leftRighView('Provisi',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.biayaProvisi}':'', true),
                    leftRighView('Nilai Pertanggungan',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.nilaiPertanggungan}':'', false),
                    leftRighView('Survey & Verifikasi',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.biayaSurveyVerifikasi}':'', true),
                    leftRighView('Notaris',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.biayaNotaris}':'', true),
                    leftRighView('Total Biaya',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.totalBiaya}':'', true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Angsuran', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Angsuran',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.angsuran}':'', true),
                    leftRighView('Angsuran Pertama',  controller.dataKredit.value.data != null ? controller.dataKredit.value.data!.biaya!.angsuranPertama!:'', false),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nilai Pencairan', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Nilai Pencairan (Rp)',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.nilaiPencairan}':'', true),
                    leftRighView('Nilai Total DP',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.nilaiTotalDP}':'', true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Komisi Seller', style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                    SizedBox(height: 20),
                    leftRighView('Komisi Seller',  controller.dataKredit.value.data != null ? '${controller.dataKredit.value.data!.biaya!.komisiSeller}':'', true),
                  ],
                ),
              ),
              controller.allFoto.value.length > 0 ? fotoUnit(
                subName: "",
                imgUrl: [
                  for (var a in controller.allFoto) a,
                  // for (var a in controller.dataKredit.value.data!.photo_document!.document_jaminan!) a,
                ],
                imgUrlFile: null,
              ):SizedBox(),
            ],
          ),
        ),
      )),

      bottomNavigationBar: auth.modelSaveRoot!.userData!.role! != "Marketing Head" ? Obx(()=> controller.dataKredit.value.data == null ? GestureDetector(
          onTap: () {
            Utils.removeKreditJaminan();
            Utils.removeKreditKontrak();
            Get.to(() => FormKredit(
              unit_id: widget.unit_id, lead_id: widget.lead_id,
              onBack: ()=>controller.getKreditDetail(unitId: widget.lead_id),
            ));
          },
          child: buttonDefaulLogin(
              backGround: yd_Color_Primary,
              textColor: Colors.white,
              text: "Isi Form"
          )):SizedBox()):SizedBox(),

      floatingActionButton: auth.modelSaveRoot!.userData!.role! != "Marketing Head" ?
        Obx(()=> controller.dataKredit.value.data == null ? SizedBox():floatingButton(data: controller.dataKredit.value, onClick: ()=>popUpFloating(controller.dataKredit.value))):SizedBox(),
    );
  }

  leftRighView(String label, String value, bool isCurr){
    if(value != ''){
      return value != '0' ? Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text(label, style: TextStyle(fontSize: 16,)),
                Expanded(child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(isCurr ? 'Rp. ${numberFor.format(int.parse(value != '' ? value:'0'))}' : label.contains('Bunga') ? '${value}%':value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ))
              ],
            ),
            SizedBox(
              height: yd_defauld_padding,
            ),
            Divider()
          ],
        ),
      ):SizedBox();
    }else{
      return SizedBox();
    }

  }

  floatingButton({ModelDetailKredit? data, Function? onClick}){
    return data != null ? InkWell(
      onTap: ()=>onClick!(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFFEDF5F4),
          borderRadius: BorderRadius.circular(
            yd_defauld_padding,
          ),
          boxShadow: [
            BoxShadow(
              color: yd_Color_Primary_Grey.withOpacity(0.3),
              offset: Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: Icon(Icons.storage_rounded),
      ),
    ):SizedBox();
  }

  popUpFloating(ModelDetailKredit data){
    return Get.dialog(
      GestureDetector(
        onTap: ()=>Get.back(),
        child: auth.modelSaveRoot!.userData!.role == "External"
            ? BottomSheetMenuCustom(
            items: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                child: Text("Menu", style: TextStyle(fontSize: 12,),),
              ),
              ItemBottomSheetMenuCustom(
                icon: Icon(Icons.phone, color: Colors.black),
                onTap: ()=>Get.back(),
                text: "Hubungi PIC",
              ),
            ]) :
        BottomSheetMenuCustom(
          items: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
              child: Text("Edit Informasi Kredit", style: TextStyle(fontSize: 12,),),
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(CupertinoIcons.square_list_fill, color: Colors.black),
              onTap: () {
                Get.back();
                if(data.data != null){
                  Get.to(()=>EditJaminanKredit(
                    lead_id: widget.lead_id,
                    namePipeline: widget.namePipeline,
                    id_unit: widget.unit_id,
                    data: data,
                    onBack: (data){
                      controller.getKreditDetail(unitId: widget.lead_id);
                    },
                  ));
                }else{
                  Utils.messageDialog(context, 'Alert', 'Tidak ada data kredit untuk Unit ID ${widget.unit_id}', () { Get.back(); });
                }
              },
              text: "Jaminan",
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(CupertinoIcons.doc_fill, color: Colors.black),
              onTap: () {
                Get.back();
                if(data.data != null){
                  Get.to(()=>EditKontrakKredit(
                    lead_id: widget.lead_id,
                    namePipeline: widget.namePipeline,
                    id_unit: widget.unit_id,
                    data: data,
                    onBack: (data){
                      controller.getKreditDetail(unitId: widget.lead_id);
                    },
                  ));
                }else{
                  Utils.messageDialog(context, 'Alert', 'Tidak ada data kredit untuk Unit ID ${widget.unit_id}', () { Get.back(); });
                }

              },
              text: "Kontrak",
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(height: 1, color: yd_Color_Primary_Grey,),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
              child: Text("Menu", style: TextStyle(fontSize: 12,),),
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(Icons.phone, color: Colors.black),
              onTap: () {
                Get.back();
                if(data.data != null){
                  openwhatsapp(nomerTlp: data == null ? "+6282140111456" : '${data.data!.nasabah!.telp!.removeAllWhitespace}',);
                }else{
                  Utils.messageDialog(context, 'Alert', 'Tidak ada data kredit untuk Unit ID ${widget.unit_id}', () { Get.back(); });
                }

              },
              text: "Hubungi Nasabah",
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(
                Icons.chat_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Get.back();
                Get.to(() => Chat(
                  nameCar: '${data.data!.spekUnit!.merek!} ${data.data!.spekUnit!.model!}',
                  namePipeline: widget.namePipeline,
                  pipeline: widget.idPipeline,
                  id_unit: widget.unit_id,
                  lead_id: widget.lead_id,
                ));

              },
              text: "Chat & Aktifitas",
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(
                Icons.group,
                color: Colors.black,
              ),
              onTap: () {
                Get.back();
                if (Get.isDialogOpen == true) Get.back();
                Get.to(() => PesionInChange(id: widget.unit_id.toString(), namePipeline: widget.namePipeline));
              },
              text: "Assign PIC",
            ),
            ItemBottomSheetMenuCustom(
              icon: Icon(
                Icons.scatter_plot,
                color: Colors.black,
              ),
              onTap: () {
                unitController.getPipeline(path: widget.isFinancing? 'Financing':'Refinancing', onSuccess: (data){
                  Get.back();
                  gantiPipline(data, unitController.idPipeline.value);
                });
              },
              text: "Ganti Pipeline",
            ),
          ],
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );
  }

  gantiPipline(Map data, int idPipeline){
    var dataOpen = data['open'] as List<PipelineModel>;
    var dataClose = data['close'] as List<PipelineModel>;
    Get.dialog(
      GestureDetector(
        onTap: ()=>Get.back(),
        child: BottomSheetMenuCustom(
          items: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
              child: Text("Open", style: TextStyle(fontSize: 12,),
              ),
            ),
            Column(
              children: dataOpen.map((e) =>ItemBottomSheetMenuCustom(
                active: idPipeline == e.id,
                icon: Icon(
                  getIconPipeline(e.title),
                  color: Colors.black,
                ),
                onTap: () {
                  unitController.updatePipeline(
                    leadId: widget.lead_id,
                    idPipeline: e.id,
                    titlePipe: e.title.toString(),
                    onSuccess: (val){}
                  );
                  Get.back();
                },
                text: e.title.toString(),
              )).toList(),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(height: 1, color: yd_Color_Primary_Grey,),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
              child: Text("Close", style: TextStyle(fontSize: 12,),
              ),
            ),
            Column(
              children: dataClose.map((e) =>ItemBottomSheetMenuCustom(
                active: idPipeline == e.id,
                icon: Icon(
                  getIconPipeline(e.title),
                  color: Colors.black,
                ),
                onTap: () {
                  unitController.updatePipeline(
                    leadId: widget.lead_id,
                    idPipeline: e.id,
                    titlePipe: e.title.toString(),
                    onSuccess: (val){}
                  );
                  Get.back();
                },
                text: e.title.toString(),
              )).toList(),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );
  }

  getIconPipeline(String label){
    switch(label){
      case '[Unit] Listing':
        return Icons.list_rounded;
      case '[Unit] Visiting':
        return Icons.airport_shuttle;
      case '[Unit] Visit done':
        return CupertinoIcons.check_mark_circled_solid;
      case 'Assigning Credit Surveyor':
        return Icons.supervised_user_circle_rounded;
      case '[Credit] Surveying':
        return Icons.description;
      case '[Credit] Approval':
        return Icons.done_all_rounded;
      case '[Unit] Not Available':
        return Icons.browser_not_supported_rounded;
      case '[Credit] Purchasing order':
        return Icons.attach_money;
      case '[Credit] Rejected':
        return CupertinoIcons.clear_circled_solid;
    }
  }
}
