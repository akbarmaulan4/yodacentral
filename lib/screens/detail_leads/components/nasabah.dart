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
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/controller/unit/unit_controller.dart';
import 'package:yodacentral/models/model_detail_nasabah.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/pipeline/pipeline_model.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/chat/chat.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/edit_dokument_form.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/edit_identitas_form.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/edit_pekerjaan_form.dart';
import 'package:yodacentral/screens/detail_leads/components/person_in_change.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/utils/utils.dart';

import 'components/form_nasabah.dart';

class Nasabah extends StatefulWidget {
  const Nasabah({
    Key? key,
    required this.isFinancing,
    required this.unit_id,
    required this.nameUnit,
    required this.idPipeline,
    required this.namePipeline,
    required this.lead_id,
  }) : super(key: key);
  final bool isFinancing;
  final int unit_id;
  final String nameUnit;
  final int idPipeline;
  final String namePipeline;
  final int lead_id;

  @override
  _NasabahState createState() => _NasabahState();
}

class _NasabahState extends State<Nasabah> {
  bool load = true;
  bool showTanggalTerbit = false;
  bool showNamaJamin = false;
  bool showNoKtpJamin = false;
  bool showHubJamin = false;
  ModelDetailNasabah? modelDetailNasabah;
  List<String> fotoUnits = [];
  late ModelSaveRoot modelLogin;
  getUnitDetail() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    setState(() {
      modelLogin = value;
      load = true;
    });

    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${widget.lead_id.toString()}';
    print('URL : $url');
    var data = await SaveRoot.callSaveRoot();
    var res = await http.get(Uri.parse(url.trim()),  headers: {'Authorization': 'Bearer ' + data.token.toString()});
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var sdsda = json.encode(jsonDecode);
      print('RESPONSE ${json.encode(jsonDecode)}');
      setState(() {
        modelDetailNasabah = modelDetailNasabahFromMap(res.body);
        initInfoTambahan(modelDetailNasabah);
        controller.changeDataNasabah(modelDetailNasabah!);
        fotoUnits =  modelDetailNasabah!.data!.document!.photoDocument!;
        load = false;
        log(res.body, name: "Unit detail");
      });
    } else {
      setState(() {
        load = false;
        log(res.body, name: "Unit detail");
      });
    }
  }

  initInfoTambahan(ModelDetailNasabah? data){
    if(data != null){
      setState(() {
        if(modelDetailNasabah!.data!.penjamin!['Nama Penjamin'] != null){
          showNamaJamin = true;
        }
        if(modelDetailNasabah!.data!.penjamin!['Nomor KTP Penjamin'] != null){
          showNoKtpJamin = true;
        }
        if(modelDetailNasabah!.data!.penjamin!['Hubungan Dengan Pemohon'] != null){
          showHubJamin = true;
        }
      });

    }
  }

  ControllerAuth auth = Get.put(ControllerAuth());
  NasabahController controller = NasabahController();
  UnitController unitController = UnitController();

  @override
  void initState() {
    super.initState();
    // controller.getDataNasabah(unit_id:widget.unit_id.toString());
    unitController.changeIdPipeline(widget.idPipeline, widget.namePipeline);
    getUnitDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: load
            ? Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: yd_Color_Primary,
                    ),
                  ),
                ],
              )
            : modelDetailNasabah == null || modelDetailNasabah!.data == null
                ? SizedBox(
                    height: Get.height / 1.5,
                    child: cantFind(
                        title: null,
                        content: "Belum ada nasabah untuk lead ini."),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imageNameDesk(
                                imageUrl: modelDetailNasabah!.data!.document!.photo_nasabah! == '' ? null : modelDetailNasabah!.data!.document!.photo_nasabah,
                                name: modelDetailNasabah!.data!.identitas!.namaLengkapSesuaiKtp != '0' ? modelDetailNasabah!.data!.identitas!.namaLengkapSesuaiKtp : '',
                                deskription:  modelDetailNasabah!.data!.identitas!.catatan == '0' ? '':modelDetailNasabah!.data!.identitas!.catatan!,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  yd_defauld_padding,
                                  0,
                                  yd_defauld_padding,
                                  yd_defauld_padding * 2,
                                ),
                                child: Column(
                                  children: [
                                    modelDetailNasabah!.data!.identitas!.jenisKelamin == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Jenis Kelamin",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.jenisKelamin!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.noKtp == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Nomor KTP",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.noKtp!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.tglTerbitKTP == ''
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                      keyUnit: "Tanggal Terbit KTP",
                                      valueUnit: modelDetailNasabah!.data!.identitas!.tglTerbitKTP!.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
                                    ),
                                    modelDetailNasabah!.data!.identitas!.tanggalLahirDdMmYyyy == null
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Tanggal Lahir",
                                            valueUnit: DateFormat("d MMMM yyyy").format(modelDetailNasabah!.data!.identitas!.tanggalLahirDdMmYyyy!,)),
                                    modelDetailNasabah!.data!.identitas!.tempatLahir == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Tempat Lahir",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.tempatLahir!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.gelarNasabah == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Pendidikan Terakhir",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.gelarNasabah!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.namaGadisIbuKandung == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Nama Gadis Ibu Kandung",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.namaGadisIbuKandung!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.nomorTelepon == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Nomor Telepon",
                                            valueUnit: "+62 " + modelDetailNasabah!.data!.identitas!.nomorTelepon!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.noNpwp == '0'
                                        ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Nomor NPWP",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.noNpwp!,
                                          ),
                                    modelDetailNasabah!.data!.identitas!.statusPernikahan == '0' ? SizedBox()
                                        : ItemCardListUnis(
                                            keyUnit: "Status Pernikahan",
                                            valueUnit: modelDetailNasabah!.data!.identitas!.statusPernikahan!,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          modelDetailNasabah!.data!.pasangan != null ? Padding(
                            padding: EdgeInsets.fromLTRB(
                              yd_defauld_padding,
                              0,
                              yd_defauld_padding,
                              yd_defauld_padding * 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Data Pasangan", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                                SizedBox(height: yd_defauld_padding,),
                                modelDetailNasabah!.data!.pasangan!['Nama pasangan'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Nama Lengkap Pasangan",
                                  valueUnit: modelDetailNasabah!.data!.pasangan!['Nama pasangan'],
                                ),
                                modelDetailNasabah!.data!.pasangan!['Nomor KTP'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                    keyUnit: "Nomor KTP Pasangan",
                                    valueUnit: modelDetailNasabah!.data!.pasangan!['Nomor KTP']),
                                modelDetailNasabah!.data!.pasangan!['Tanggal lahir pasangan'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Tanggal Lahir Pasangan",
                                  valueUnit: modelDetailNasabah!.data!.pasangan!['Tanggal lahir pasangan'],
                                ),
                                modelDetailNasabah!.data!.pasangan!['Nomor Hp'] == null || modelDetailNasabah!.data!.pasangan!['Nomor Hp'] == '0'
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Nomor Handphone Pasangan",
                                  valueUnit:  "+62 " +modelDetailNasabah!.data!.pasangan!['Nomor Hp'],
                                ),
                              ],
                            ),
                          ):SizedBox(),
                          fotoUnits.length > 0 ? fotoUnit(
                            subName: "",
                            imgUrl: fotoUnits,
                          ):SizedBox(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              yd_defauld_padding,
                              0,
                              yd_defauld_padding,
                              yd_defauld_padding * 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Domisili Nasabah", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                                SizedBox(height: yd_defauld_padding,),
                                modelDetailNasabah!.data!.domisili!.alamatKtp == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "Alamat Sesuai KTP",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.alamatKtp!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.provinsi == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "Provinsi",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.provinsi!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.kotaKabupaten == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "Kota",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.kotaKabupaten!),
                                modelDetailNasabah!.data!.domisili!.kecamatan == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "Kecamatan",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.kecamatan!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.kelurahan == null
                                    ? SizedBox(
                                        width: 0,
                                        height: 0,
                                      )
                                    : ItemCardListUnis(
                                        keyUnit: "Keluarahan",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.kelurahan!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.rt == null
                                    ? SizedBox(
                                        width: 0,
                                        height: 0,
                                      )
                                    : ItemCardListUnis(
                                        keyUnit: "RT",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.rt!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.rw == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "RW",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.rw!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.kodePos == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                        keyUnit: "Kode Pos",
                                        valueUnit: modelDetailNasabah!.data!.domisili!.kodePos!,
                                      ),
                                modelDetailNasabah!.data!.domisili!.noTlpRumah == null || modelDetailNasabah!.data!.domisili!.noTlpRumah == '0'
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Nomor Telepon Rumah",
                                  valueUnit: "+62 " + modelDetailNasabah!.data!.domisili!.noTlpRumah!,
                                ),
                              ],
                            ),
                          ),
                          modelDetailNasabah!.data!.domisili!.catatan != '0' ? Padding(
                              padding: EdgeInsets.fromLTRB(yd_defauld_padding, 0, yd_defauld_padding, yd_defauld_padding * 2,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Catatan Domisili", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                                  SizedBox(height: yd_defauld_padding,),
                                  Text(modelDetailNasabah!.data!.domisili!.catatan!),
                                  SizedBox(height: yd_defauld_padding,),
                                  Divider(height: 0),
                                ],
                              )):SizedBox(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              yd_defauld_padding,
                              0,
                              yd_defauld_padding,
                              yd_defauld_padding * 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Data Penjamin", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                                SizedBox(height: yd_defauld_padding,),
                                modelDetailNasabah!.data!.penjamin!['Nama Penjamin'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Nama Penjamin",
                                  valueUnit: modelDetailNasabah!.data!.penjamin!['Nama Penjamin'],
                                ),
                                modelDetailNasabah!.data!.penjamin!['Nomor KTP Penjamin'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                    keyUnit: "Nomor KTP Penjamin",
                                    valueUnit: controller.formatPattern(modelDetailNasabah!.data!.penjamin!['Nomor KTP Penjamin'])),
                                modelDetailNasabah!.data!.penjamin!['Hubungan Dengan Pemohon'] == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Hubugnan Dengan Pemohon",
                                  valueUnit: modelDetailNasabah!.data!.penjamin!['Hubungan Dengan Pemohon'],
                                ),
                              ],
                            ),
                          ),
                          modelDetailNasabah!.data!.pekerjaan != null ? Padding(
                            padding: EdgeInsets.fromLTRB(
                              yd_defauld_padding,
                              0,
                              yd_defauld_padding,
                              yd_defauld_padding * 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pekerjaan Nasabah", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                                SizedBox(height: yd_defauld_padding,),
                                modelDetailNasabah!.data!.pekerjaan!.pekerjaan == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Pekerjaan",
                                  valueUnit: modelDetailNasabah!.data!.pekerjaan!.pekerjaan!,
                                ),
                                modelDetailNasabah!.data!.pekerjaan!.nama_institusi == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                    keyUnit: "Nama Institusi",
                                    valueUnit: modelDetailNasabah!.data!.pekerjaan!.nama_institusi!),
                                modelDetailNasabah!.data!.pekerjaan!.jabatan == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Jabatan",
                                  valueUnit: modelDetailNasabah!.data!.pekerjaan!.jabatan!,
                                ),
                                modelDetailNasabah!.data!.pekerjaan!.lama_bekerja == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Lama Bekerja",
                                  valueUnit: '${modelDetailNasabah!.data!.pekerjaan!.lama_bekerja!}',
                                ),
                                modelDetailNasabah!.data!.pekerjaan!.nomor_tlp_inst == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Nomor Telepon Institusi",
                                  valueUnit: '${modelDetailNasabah!.data!.pekerjaan!.nomor_tlp_inst!}',
                                ),
                                modelDetailNasabah!.data!.pekerjaan!.alamat_inst == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Alamat Institusi",
                                  valueUnit: '${modelDetailNasabah!.data!.pekerjaan!.alamat_inst!}',
                                ),
                                modelDetailNasabah!.data!.pekerjaan!.catatan_kerja == null
                                    ? SizedBox()
                                    : ItemCardListUnis(
                                  keyUnit: "Catatan Pekerjaan",
                                  valueUnit: '${modelDetailNasabah!.data!.pekerjaan!.catatan_kerja!}',
                                ),
                              ],
                            ),
                          ):SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 30 * 2,
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: auth.modelSaveRoot!.userData!.role! != "Marketing Head" ? load
          ? null
          : modelDetailNasabah == null || modelDetailNasabah!.data == null
              ? GestureDetector(
                  onTap: () {
                    Utils.removeFotoNasabah();
                    Utils.removeNasabahIdentitas();
                    Utils.removeNasabahInstitusi();
                    Get.to(() => AddFormNasabah(
                        namePipeline: widget.namePipeline,
                        unit_id: widget.unit_id,
                        lead_id: widget.lead_id,
                        onBack: ()=>getUnitDetail(),
                      ),
                    );
                  },
                  child: buttonDefaulLogin(
                      backGround: yd_Color_Primary,
                      textColor: Colors.white,
                      text: "Isi Form"),
                )
              : null : null,
      floatingActionButton: load
          ? null
          : auth.modelSaveRoot!.userData!.role! == "External"
              ? null
              : modelDetailNasabah == null || modelDetailNasabah!.data == null
                  ? null
                  : GestureDetector(
                      onTap: () {
                        Get.dialog(
                          GestureDetector(
                            onTap: ()=>Get.back(),
                            child: auth.modelSaveRoot!.userData!.role == "External"
                                    ? BottomSheetMenuCustom(items: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 7.5, 30, 7.5),
                                          child: Text(
                                            "Edit Informasi Nasabah",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        ItemBottomSheetMenuCustom(
                                          icon: Icon(Icons.camera_alt_rounded, color: Colors.black,),
                                          onTap: () {},
                                          text: "Edit Informasi Unit",
                                        ),
                                      ])
                                    : BottomSheetMenuCustom(
                                        items: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                                            child: Text("Edit Informasi Nasabah", style: TextStyle(fontSize: 12,),),
                                          ),
                                          ItemBottomSheetMenuCustom(
                                            icon: Icon(Icons.assignment_ind_rounded, color: Colors.black),
                                            onTap: (){
                                              Get.back();
                                              Get.to(()=>EditFormIdentitas(
                                                lead_id: widget.lead_id,
                                                id_unit: widget.unit_id,
                                                namePipeline: widget.namePipeline,
                                                domisili: false,
                                                data: modelDetailNasabah,
                                                onBack: (data){
                                                  getUnitDetail();
                                                },
                                              ))!.then((value){
                                                if(value != null){
                                                  getUnitDetail();
                                                }
                                              });
                                            },
                                            text: "Identitas",
                                          ),
                                          ItemBottomSheetMenuCustom(
                                            icon: Icon(Icons.home_work_rounded, color: Colors.black),
                                            onTap: () {
                                              Get.back();
                                              Get.to(()=>EditFormPekerjaan(
                                                lead_id: widget.lead_id,
                                                data: modelDetailNasabah,
                                                namePipeline: widget.namePipeline,
                                                onBack: (data){
                                                  getUnitDetail();
                                                },
                                              ))!.then((value){
                                                getUnitDetail();
                                              });
                                            },
                                            text: "Pekerjaan",
                                          ),
                                          ItemBottomSheetMenuCustom(
                                            icon: Icon(Icons.file_copy, color: Colors.black),
                                            onTap: (){
                                              Get.back();
                                              Get.to(()=>EditDokumentForm(
                                                id_unit: widget.unit_id,
                                                lead_id: widget.lead_id,
                                                namePipeline: widget.namePipeline,
                                                data: modelDetailNasabah,
                                                onBack: (){
                                                  getUnitDetail();
                                                },
                                              ));
                                            },
                                            text: "Dokumen",
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Container(height: 1, color: yd_Color_Primary_Grey,),
                                          ),
                                          SizedBox(height: 5,),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15, 7.5, 30, 7.5),
                                            child: Text("Menu", style: TextStyle(fontSize: 12),),
                                          ),
                                          modelLogin != null && modelLogin.userData!.role != 'External' || modelLogin != null && modelLogin.userData!.role != 'Marketing Head' ? ItemBottomSheetMenuCustom(
                                            icon: Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                            ),
                                            onTap: () => openwhatsapp(nomerTlp: modelDetailNasabah!.data!.identitas!.nomorTelepon!,),
                                            text: "Hubungi Nasabah",
                                          ):SizedBox(),
                                          modelLogin != null && modelLogin.userData!.role != 'External' || modelLogin != null && modelLogin.userData!.role != 'Marketing Head' ? ItemBottomSheetMenuCustom(
                                            icon: Icon(Icons.chat_rounded, color: Colors.black,),
                                            onTap: () {
                                              Get.back();
                                              Get.to(
                                                () => Chat(
                                                  nameCar: widget.nameUnit,
                                                  namePipeline: widget.namePipeline,
                                                  id_unit: widget.unit_id,
                                                  pipeline: widget.idPipeline,
                                                  lead_id: widget.lead_id,
                                                ),
                                              );
                                            },
                                            text: "Chat & Aktifitas",
                                          ):SizedBox(),
                                          ItemBottomSheetMenuCustom(
                                            icon: Icon(
                                              Icons.group,
                                              color: Colors.black,
                                            ),
                                            onTap: () {
                                              Get.back();
                                              if (Get.isDialogOpen == true)
                                                Get.to(() => PesionInChange(id: widget.unit_id.toString(), namePipeline: widget.namePipeline),
                                              );
                                            },
                                            text: "PIC",
                                          ),
                                          ItemBottomSheetMenuCustom(
                                            icon: Icon(
                                              Icons.scatter_plot,
                                              color: Colors.black,
                                            ),
                                            onTap: () {
                                              Get.back();
                                              unitController.getPipeline(path: widget.isFinancing? 'Financing':'Refinancing', onSuccess: (data){
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
