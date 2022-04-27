import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/bottom_sheet_floating_add.dart';
import 'package:yodacentral/components/function_wa_me.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/controller/unit/unit_controller.dart';
import 'package:yodacentral/models/model_detail_lead_unit.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/unggah_foto.dart';
import 'package:yodacentral/screens/chat/chat.dart';
import 'package:yodacentral/screens/detail_leads/components/person_in_change.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_info_seller/edit_info_seller.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_informasi_unit/edit_informasi_unit.dart';
import 'package:yodacentral/models/pipeline/pipeline_model.dart';
import 'package:yodacentral/utils/images_constant.dart';
import 'package:yodacentral/utils/utils.dart';

class Unit extends StatefulWidget {
  const Unit({
    Key? key,
    required this.unit_id,
    required this.unitForSeller,
    this.nomerTlp,
    required this.isFinancing,
    required this.idPipeline,
    required this.namePipeline,
    required this.nameUnit,
    required this.lead_id,
    required this.onUpdate
  }) : super(key: key);
  final int unit_id;
  final ValueChanged<String>? nomerTlp;
  final ValueChanged<String>? nameUnit;
  final bool isFinancing;
  final int idPipeline;
  final String namePipeline;
  final int lead_id;
  final int unitForSeller;
  final Function onUpdate;

  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  bool load = true;
  String strSellerName = '';
  String strSellerProvinsi = '';
  String strSellerKab = '';
  String strSellerKec= '';
  String strSellerPhone = '';
  ModelLeadDetailUnit? modelLeadDetailUnit;
  late ModelSaveRoot modelLogin;
  getUnitDetail() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    setState(() {
      modelLogin = value;
      load = true;
    });
    Utils.removeKecID();
    var strUrl = '${ ApiUrl.domain.toString()}/api/lead/detail_unit/${widget.lead_id.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString(),});
    print('URL ${strUrl}');
    print('TOKEN ${value.token.toString()}');
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      setState(() {
        modelLeadDetailUnit = modelLeadDetailUnitFromMap(res.body);
        load = false;
        if(modelLeadDetailUnit!.data!.dataPenjual != null){
          strSellerName = modelLeadDetailUnit!.data!.dataPenjual!.name!;
          strSellerProvinsi = modelLeadDetailUnit!.data!.dataPenjual!.provinsi!;
          strSellerKab = modelLeadDetailUnit!.data!.dataPenjual!.kotaKabupaten!;
          strSellerKec = modelLeadDetailUnit!.data!.dataPenjual!.kecamatan!;
          strSellerPhone = "+62 " + modelLeadDetailUnit!.data!.dataPenjual!.nomorTelepon!;
        }

        Utils.saveKreditJaminan(modelLeadDetailUnit!.data!.lokasiUnit!.kecamatan_id.toString());
        widget.nameUnit!(modelLeadDetailUnit!.data!.dataUnit!.name!);
      });
      log(res.body, name: "Unit detail");
    } else {
      setState(() {
        load = false;
      });
      log(res.body, name: "Unit detail");
    }
  }

  ControllerAuth auth = Get.put(ControllerAuth());
  UnitController controller = UnitController();

  @override
  void initState() {
    super.initState();
    getUnitDetail();
    controller.changeIdPipeline(widget.idPipeline, widget.namePipeline);
    // log(widget.unit_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            load
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: yd_Color_Primary,
                  ))
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          shwoDetailImage(urlImage: modelLeadDetailUnit!.data!.fotoUnit!.length == 0 ? "" : modelLeadDetailUnit!.data!.fotoUnit![0].toString());
                        },
                        child: imageNameDesk(
                          imageUrl: modelLeadDetailUnit!.data!.fotoUnit!.length == 0 ? "" : modelLeadDetailUnit!.data!.fotoUnit![0],
                          name: modelLeadDetailUnit!.data!.dataUnit!.name ?? "-",
                          deskription: modelLeadDetailUnit!.data!.dataUnit!.note ?? "-",
                        ),
                      ),
                      spekUnit(subName: "Spesifikasi unit", items: [
                        ItemListUnit(
                          keyUnit: "Nomor Polisi",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.nomerPolisi ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Kondisi Mobil",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.kondisi ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Merek",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.merek ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Model",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.model ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Varian",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.varian ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Tahun",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.tahun == null ? "-" : modelLeadDetailUnit!.data!.spekUnit!.tahun.toString(),
                        ),
                        ItemListUnit(
                          keyUnit: "Jarak Tempuh",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.jarakTempuh ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Bahan Bakar",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.bahanBakar ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Transmisi",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.transmisi ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Warna",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.warna ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Harga",
                          valueUnit: modelLeadDetailUnit!.data!.spekUnit!.harga ?? "-",
                        ),
                      ]),
                      spekUnit(subName: "Lokasi unit", items: [
                        ItemListUnit(
                          keyUnit: "Provinsi",
                          valueUnit: modelLeadDetailUnit!.data!.lokasiUnit!.provinsi ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Kota/Kabupaten",
                          valueUnit: modelLeadDetailUnit!.data!.lokasiUnit!.kotaKabupaten ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Kecamatan",
                          valueUnit: modelLeadDetailUnit!.data!.lokasiUnit!.kecamatan ?? "-",
                        ),
                        ItemListUnit(
                          keyUnit: "Cabang Pengelola",
                          valueUnit: modelLeadDetailUnit!.data!.lokasiUnit!.cabangPengelola ?? "-",
                        ),
                      ]),
                      fotoUnit(
                        subName: "Foto unit",
                        imgUrl: [
                          for (var a in modelLeadDetailUnit!.data!.fotoUnit!) a,
                        ],
                        imgUrlFile: null,
                      ),
                      !widget.isFinancing
                          ? SizedBox(width: 0, height: 0)
                          : modelLeadDetailUnit!.data!.dataPenjual == null
                              ? SizedBox(width: 0, height: 0,)
                              : informasiSeller(
                                  subName: "Informasi seller",
                                  nameSeller: strSellerName,
                                  alamat: modelLeadDetailUnit!.data!.dataPenjual!.address ?? "-",
                                  items: [
                                      ItemListUnit(
                                        keyUnit: "Provinsi",
                                        valueUnit: strSellerProvinsi,
                                      ),
                                      ItemListUnit(
                                        keyUnit: "Kota/Kabupaten",
                                        valueUnit: strSellerKab,
                                      ),
                                      ItemListUnit(
                                        keyUnit: "Kecamatan",
                                        valueUnit: strSellerKec,
                                      ),
                                      ItemListUnit(
                                        keyUnit: "Nomor Telepon",
                                        valueUnit: strSellerPhone,
                                      ),
                                    ]),
                      SizedBox(height: 30 * 2),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: load
          ? null
          : GestureDetector(
              onTap: () {
                Get.dialog(
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
                          icon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            openwhatsapp(
                              nomerTlp: modelLeadDetailUnit!.data!.kontak_pic == null ? "+6282140111456"
                                  : modelLeadDetailUnit!.data!.kontak_pic!.telp!.removeAllWhitespace,
                            );
                          },
                          text: "Hubungi PIC",
                        ),
                      ]) :
                    BottomSheetMenuCustom(
                      items: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                          child: Text("Edit Informasi", style: TextStyle(fontSize: 12,),),
                        ),
                        ItemBottomSheetMenuCustom(
                          icon: Icon(
                            Icons.directions_car_rounded,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            Navigator.push(context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    EditInformasiUnit(
                                        namePipeline: widget.namePipeline,
                                        id_unit: widget.unitForSeller,
                                        lead_id: widget.lead_id,
                                        getData: (b) {b ? getUnitDetail() : log("tidak get");}
                                    ),
                              ),
                            );
                          },
                          text: "Edit Informasi Unit",
                        ),
                        ItemBottomSheetMenuCustom(
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => EditFotoUnit(
                                  namePipeline: widget.namePipeline,
                                  id_unit: widget.unit_id,
                                  lead_id: widget.lead_id,
                                  getData: (b) {b ? getUnitDetail() : log("tidak get");
                                  },
                                ),
                              ),
                            );
                          },
                          text: "Edit Foto Unit",
                        ),
                        widget.isFinancing ?
                        ItemBottomSheetMenuCustom(
                          icon: Icon(Icons.store_rounded, color: Colors.black,),
                          onTap: () {
                            Get.back();
                            Get.to(EditInfoSeller(
                              id_unit: widget.unitForSeller,
                              lead_id: widget.lead_id,
                              namePipeline: widget.namePipeline,
                              namaSeller: strSellerName,
                              isFinancing: widget.isFinancing,
                              onBack: (val){
                                getUnitDetail();
                              },
                            ));
                          },
                          text: "Ubah Seller",
                        ) : SizedBox(height: 0, width: 0),
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
                          icon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            openwhatsapp(
                              nomerTlp: modelLeadDetailUnit!.data!.dataPenjual == null ? "+6282140111456"
                                  : modelLeadDetailUnit!.data!.dataPenjual!.nomorTelepon!,
                            );
                          },
                          text: "Hubungi Seller",
                        ),
                        ItemBottomSheetMenuCustom(
                          icon: Icon(
                            Icons.chat_rounded,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            Get.to(() => Chat(
                                nameCar: modelLeadDetailUnit!.data!.dataUnit!.name!,
                                namePipeline: widget.namePipeline,
                                pipeline: widget.idPipeline,
                                id_unit: widget.unit_id,
                                lead_id: widget.lead_id,
                              ),
                            );
                          },
                          text: "Chat & Aktifitas",
                        ),
                        modelLogin != null && modelLogin.userData!.role == 'Marketing Head'? ItemBottomSheetMenuCustom(
                          icon: Icon(
                            Icons.group,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Get.back();
                            if (Get.isDialogOpen == true) Get.back();
                            Get.to(() => PesionInChange(id: widget.lead_id.toString(), namePipeline: widget.namePipeline));
                          },
                          text: "PIC",
                        ):SizedBox(),
                        ItemBottomSheetMenuCustom(
                          icon: Icon(
                            Icons.scatter_plot,
                            color: Colors.black,
                          ),
                          onTap: () {
                            controller.getPipeline(path: widget.isFinancing ? 'Financing':'Refinancing', onSuccess: (data){
                              Get.back();
                              gantiPipline(
                                  data,
                                  controller.idPipeline.value,
                                  (val)=>widget.onUpdate(val)
                              );
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
              },
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
            ),
    );
  }

  gantiPipline(Map data, int idPipeline, Function onUpdate){
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
                  controller.updatePipeline(
                      leadId: widget.lead_id,
                      idPipeline: e.id,
                      titlePipe: e.title.toString(),
                    onSuccess: (val)=>onUpdate(val)
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
                  controller.updatePipeline(
                      leadId: widget.lead_id,
                      idPipeline: e.id,
                      titlePipe: e.title.toString(),
                      onSuccess: (val)=>onUpdate(val));
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

Widget imageNameDesk({String? imageUrl, String? name, String? deskription}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      imageUrl == null
          ? SizedBox(width: 0, height: 0)
          : Container(
              width: Get.width,
              height: Get.width / 1.5,
              color: yd_Color_Primary_Grey.withOpacity(0.3),
              child: imageNetworkHandler(
                urlImage: imageUrl,
                nama: null,
              ),
            ),
      Padding(
        padding: EdgeInsets.fromLTRB(
          yd_defauld_padding,
          yd_defauld_padding * 2,
          yd_defauld_padding,
          yd_defauld_padding * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: yd_defauld_padding,
            ),
            deskription == null
                ? SizedBox(
                    width: 0,
                    height: 0,
                  )
                : Text(
                    deskription,
                  ),
          ],
        ),
      )
    ],
  );
}

Widget spekUnit({String? subName, List<ItemListUnit>? items}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      yd_defauld_padding,
      0,
      yd_defauld_padding,
      yd_defauld_padding * 2,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subName!,
          style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),
        ),
        SizedBox(height: 7,),
        for (var a in items!)
          a.valueUnit != 'Rp 0' ? ItemCardListUnis(
            keyUnit: a.keyUnit,
            valueUnit: a.valueUnit,
          ):SizedBox(),
      ],
    ),
  );
}

Widget fotoUnit(
    {String? subName, List<String>? imgUrl, List<File>? imgUrlFile}) {
  return Padding(
    padding: imgUrlFile != null
        ? EdgeInsets.all(0)
        : EdgeInsets.fromLTRB(
            yd_defauld_padding,
            0,
            yd_defauld_padding,
            yd_defauld_padding * 2,
          ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subName!, style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),
        ),
        SizedBox(height: 7),
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
              child: imgUrl == null
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var a in imgUrlFile!)
                          GestureDetector(
                            onTap: () {
                              shwoDetailImage(a: a);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  width: Get.width / 3.65,
                                  height: Get.width / 3.65,
                                  decoration: BoxDecoration(
                                    color: yd_Color_Primary_Grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.file(a, fit: BoxFit.cover)),
                            ),
                          ),
                      ],
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var a in imgUrl)
                          GestureDetector(
                            onTap: () {
                              shwoDetailImage(urlImage: a);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: Get.width / 3.65,
                                height: Get.width / 3.65,
                                decoration: BoxDecoration(
                                  color: yd_Color_Primary_Grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: imageNetworkHandler(urlImage: a, nama: null,),
                              ),
                            ),
                          ),
                      ],
                    )),
        )
      ],
    ),
  );
}

Widget informasiSeller(
    {required String subName,
    String? nameSeller,
    String? alamat,
    required List<ItemListUnit> items}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      yd_defauld_padding,
      0,
      yd_defauld_padding,
      yd_defauld_padding * 2,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subName,
          style: TextStyle(
            fontSize: 12,
            color: yd_Color_Primary_Grey,
          ),
        ),
        SizedBox(
          height: yd_defauld_padding,
        ),
        Text(
          nameSeller ?? "-",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: yd_defauld_padding - 5,
        ),
        Text(
          alamat!,
        ),
        SizedBox(
          height: yd_defauld_padding,
        ),
        for (var a in items)
          ItemCardListUnis(
            keyUnit: a.keyUnit,
            valueUnit: a.valueUnit,
          ),
      ],
    ),
  );
}

class ItemListUnit {
  ItemListUnit({required this.keyUnit, this.valueUnit = "-"});
  final String keyUnit;
  final String valueUnit;
}

class ItemCardListUnis extends StatelessWidget {
  const ItemCardListUnis(
      {Key? key, required this.keyUnit, this.valueUnit = "-"})
      : super(key: key);
  final String keyUnit;
  final String valueUnit;

  @override
  Widget build(BuildContext context) {
    return valueUnit != '0'? Container(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: yd_defauld_padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 3.5,
                child: Text(keyUnit, style: TextStyle(fontSize: 16,),),
              ),
              SizedBox(
                width: Get.width / 2,
                child: Text(
                  valueUnit, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
          SizedBox(
            height: yd_defauld_padding,
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    ):SizedBox();
  }
}
