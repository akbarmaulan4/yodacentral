
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_text_style.dart';
import 'package:yodacentral/models/model_detail_kredit.dart';
import 'package:yodacentral/models/model_detail_lead_unit.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';
import 'package:yodacentral/utils/utils.dart';

class KreditController extends GetxController{
  RxInt pageKredir = 0.obs;
  RxString id_kredir = ''.obs;
  Rx<ModelLeadDetailUnit> dataUnit = ModelLeadDetailUnit().obs;
  Rx<ModelDetailKredit> dataKredit = ModelDetailKredit().obs;
  RxList<File> listImages =  <File>[].obs;
  RxList<File> listImagesKontrak =  <File>[].obs;
  RxList<File> listImagesJaminan =  <File>[].obs;
  RxList<String> allFoto =  <String>[].obs;
  RxString msgErrorNoKontrak =  ''.obs;

  TextEditingController edtHargaJual = TextEditingController();
  TextEditingController edtHargaOTR = TextEditingController();
  TextEditingController edtMaxBayar = TextEditingController();

  TextEditingController edtNoRangka = TextEditingController();
  TextEditingController edtNoMesin = TextEditingController();
  TextEditingController edtNamaBPKB = TextEditingController();
  TextEditingController edtNoBPKB = TextEditingController();

  TextEditingController edtTglExBPKB = TextEditingController();
  TextEditingController edtTglExSTNK = TextEditingController();
  TextEditingController edtProvinsi = TextEditingController();
  TextEditingController edtKota = TextEditingController();
  TextEditingController edtKecamatan = TextEditingController();

  //kontrak
  TextEditingController edtNoKontrak = TextEditingController();
  TextEditingController edtTenor = TextEditingController();
  TextEditingController edtDP = TextEditingController();
  TextEditingController edtPokokPinjam = TextEditingController();
  TextEditingController edtBunga = TextEditingController();
  TextEditingController edtBungaFlat = TextEditingController();
  TextEditingController edtBungaEfektif = TextEditingController();
  TextEditingController edtTotalPinjam = TextEditingController();
  TextEditingController edtPembayaran = TextEditingController();
  TextEditingController edtKesertaan = TextEditingController();
  TextEditingController edtJenis = TextEditingController();
  TextEditingController edtPremi = TextEditingController();
  TextEditingController edtAdmin = TextEditingController();
  TextEditingController edtFidusila = TextEditingController();
  TextEditingController edtProvisi = TextEditingController();
  TextEditingController edtNilaiTanggung = TextEditingController();
  TextEditingController edtSurveyVerify = TextEditingController();
  TextEditingController edtNotaris = TextEditingController();
  TextEditingController edtTotalBiaya = TextEditingController();
  TextEditingController edtAngsuran = TextEditingController();
  TextEditingController edtAngsuranPertama = TextEditingController();
  TextEditingController edtNilaiCair = TextEditingController();
  TextEditingController edtNilaiTotalDP = TextEditingController();
  TextEditingController edtNVP = TextEditingController();
  // TextEditingController edtTotalBiaya = TextEditingController();

  FocusNode focusHargaJual = FocusNode();
  FocusNode focusHargaOTR = FocusNode();
  FocusNode focusMaxBayar = FocusNode();
  FocusNode focusTglExBPKB = FocusNode();
  FocusNode focusTglExSTNK = FocusNode();
  FocusNode focusNoRangka = FocusNode();
  FocusNode focusNoMesin = FocusNode();
  FocusNode focusNamaBPKB = FocusNode();
  FocusNode focusNoBPKB= FocusNode();

  //kontrak
  FocusNode focusNoKontrak = FocusNode();
  FocusNode focusTenor = FocusNode();
  FocusNode focusDP = FocusNode();
  FocusNode focusPokokPinjam = FocusNode();
  FocusNode focusBunga = FocusNode();
  FocusNode focusBungaFlat = FocusNode();
  FocusNode focusBungaEfektif = FocusNode();
  FocusNode focusTotalPinjam = FocusNode();
  FocusNode focusPembayaran = FocusNode();
  FocusNode focusKesetaan = FocusNode();
  FocusNode focusJenis = FocusNode();
  FocusNode focusPremi = FocusNode();
  FocusNode focusAdmin = FocusNode();
  FocusNode focusFidusila = FocusNode();
  FocusNode focusProvisi = FocusNode();
  FocusNode focusKota = FocusNode();
  FocusNode focusNilaiTanggung = FocusNode();
  FocusNode focusSurvey = FocusNode();
  FocusNode focusNotaris = FocusNode();
  FocusNode focusTotalBiaya = FocusNode();
  FocusNode focusAngsuranPertama = FocusNode();
  FocusNode focusAngsuran = FocusNode();
  FocusNode focusCair = FocusNode();
  FocusNode focusTotalDP = FocusNode();
  FocusNode focusNVP = FocusNode();


  RxBool provLoad = false.obs;
  RxBool kotaLoad = false.obs;
  RxBool kecLoad = false.obs;
  RxBool tenorLoad = false.obs;
  RxBool bayarAsuransiLoad = false.obs;
  RxBool sertaAsuransiLoad = false.obs;
  RxBool jenisLoad = false.obs;
  RxBool nilaiTanggungLoad = false.obs;
  RxBool angsuranLoad = false.obs;

  RxBool enableButtonJaminan = false.obs;
  RxBool enableButtonKontrak = false.obs;
  RxBool allDocComplete = false.obs;

  Rx<Datum> selectedProv = Datum().obs;
  Rx<Datum> selectedKota = Datum().obs;
  Rx<Datum> selectedKec = Datum().obs;
  Rx<Datum> selectedTenor = Datum().obs;
  Rx<Datum> selectedBayarAsuransi = Datum().obs;
  Rx<Datum> selectedKesertaanAsuransi = Datum().obs;
  Rx<Datum> selectedJenis= Datum().obs;
  Rx<Datum> selectedNilaiTanggung = Datum().obs;
  Rx<Datum> selectedAngsuran = Datum().obs;

  Rx<ModelWilayah> modelProv = ModelWilayah().obs;
  Rx<ModelWilayah> modelKota = ModelWilayah().obs;
  Rx<ModelWilayah> modelKec = ModelWilayah().obs;
  Rx<ModelWilayah> modelTenor = ModelWilayah().obs;
  Rx<ModelWilayah> modelBayarAsuransi = ModelWilayah().obs;
  Rx<ModelWilayah> modelKesertaanAsuransi = ModelWilayah().obs;
  Rx<ModelWilayah> modelJenis = ModelWilayah().obs;
  Rx<ModelWilayah> modelNilaiTanggung = ModelWilayah().obs;
  Rx<ModelWilayah> modelAngsuran= ModelWilayah().obs;

  RxBool hargaJualFocus = false.obs;
  RxBool OTRFocus = false.obs;
  RxBool maxBayarFocus = false.obs;
  RxBool noRangkaFocus = false.obs;
  RxBool noMesinFocus = false.obs;
  RxBool namaBPKBFocus = false.obs;
  RxBool noBPKBFocus = false.obs;
  RxBool provinsiFocus = false.obs;
  RxBool kotaFocus = false.obs;
  RxBool tglExBPKBFocus = false.obs;
  RxBool tglExSTNKFocus = false.obs;


  RxBool noKontrakFocus = false.obs;
  RxBool tenorFocus = false.obs;
  RxBool dpFocus = false.obs;
  RxBool pokokPinjamFocus = false.obs;
  RxBool bungaFocus = false.obs;
  RxBool bungaFlatFocus = false.obs;
  RxBool bungaEfektifFocus = false.obs;
  RxBool totalPinjamFocus = false.obs;
  RxBool pembayaranFocus = false.obs;
  RxBool kesertaanFocus = false.obs;
  RxBool jenisFocus = false.obs;
  RxBool premiFocus = false.obs;
  RxBool adminFocus = false.obs;
  RxBool fidusiaFocus = false.obs;
  RxBool provisiFocus = false.obs;
  RxBool nilaiaTanggungFocus = false.obs;
  RxBool surveyFocus = false.obs;
  RxBool notarisFocus = false.obs;
  RxBool totalBiayaFocus = false.obs;
  RxBool angsuranFocus = false.obs;
  RxBool angsuranPertanaFocus = false.obs;
  RxBool cairFocus = false.obs;
  RxBool totalDPFocus = false.obs;
  RxBool nvpFocus = false.obs;

  initKontrakKredit(){
    focusNoKontrak.addListener(() {
      changeFocusKredit('noKontrak', focusNoKontrak.hasFocus);
    });
    focusTenor.addListener(() {
      changeFocusKredit('tenor', focusTenor.hasFocus);
    });
    focusDP.addListener(() {
      changeFocusKredit('dp', focusDP.hasFocus);
    });
    focusPokokPinjam.addListener(() {
      changeFocusKredit('pokokPinjam', focusPokokPinjam.hasFocus);
    });
    focusBunga.addListener(() {
      changeFocusKredit('bunga', focusBunga.hasFocus);
    });
    focusBungaFlat.addListener(() {
      changeFocusKredit('bungaFLat', focusBungaFlat.hasFocus);
    });
    focusBungaEfektif.addListener(() {
      changeFocusKredit('bungaEfektif', focusBungaEfektif.hasFocus);
    });
    focusTotalPinjam.addListener(() {
      changeFocusKredit('totalPinjam', focusTotalPinjam.hasFocus);
    });
    focusPembayaran.addListener(() {
      changeFocusKredit('bayar', focusPembayaran.hasFocus);
    });
    focusKesetaan.addListener(() {
      changeFocusKredit('serta', focusKesetaan.hasFocus);
    });
    focusJenis.addListener(() {
      changeFocusKredit('jenis', focusJenis.hasFocus);
    });
    focusPremi.addListener(() {
      changeFocusKredit('premi', focusPremi.hasFocus);
    });
    focusAdmin.addListener(() {
      changeFocusKredit('admin', focusAdmin.hasFocus);
    });
    focusFidusila.addListener(() {
      changeFocusKredit('fidusia', focusFidusila.hasFocus);
    });
    focusProvisi.addListener(() {
      changeFocusKredit('provisi', focusProvisi.hasFocus);
    });
    focusNilaiTanggung.addListener(() {
      changeFocusKredit('nilaiTanggung', focusNilaiTanggung.hasFocus);
    });
    focusSurvey.addListener(() {
      changeFocusKredit('survey', focusSurvey.hasFocus);
    });
    focusNotaris.addListener(() {
      changeFocusKredit('notaris', focusNotaris.hasFocus);
    });
    focusTotalBiaya.addListener(() {
      changeFocusKredit('totalBiaya', focusTotalBiaya.hasFocus);
    });
    focusAngsuran.addListener(() {
      changeFocusKredit('angsuran', focusTotalBiaya.hasFocus);
    });
    focusAngsuranPertama.addListener(() {
      changeFocusKredit('angsuranPertama', focusTotalBiaya.hasFocus);
    });
    focusCair.addListener(() {
      changeFocusKredit('cair', focusCair.hasFocus);
    });
    focusTotalDP.addListener(() {
      changeFocusKredit('totalDP', focusTotalDP.hasFocus);
    });
    focusNVP.addListener(() {
      changeFocusKredit('nvp', focusNVP.hasFocus);
    });
  }

  initFocusKredit(){
    focusHargaJual.addListener(() {
      changeFocusKredit('hargaJual', focusHargaJual.hasFocus);
    });
    focusHargaOTR.addListener(() {
      changeFocusKredit('otr', focusHargaOTR.hasFocus);
    });
    focusMaxBayar.addListener(() {
      changeFocusKredit('maxBayar', focusMaxBayar.hasFocus);
    });
    focusNoRangka.addListener(() {
      changeFocusKredit('noRangka', focusNoRangka.hasFocus);
    });
    focusNoMesin.addListener(() {
      changeFocusKredit('noMesin', focusNoMesin.hasFocus);
    });
    focusNamaBPKB.addListener(() {
      changeFocusKredit('namaBPKB', focusNamaBPKB.hasFocus);
    });
    focusNoBPKB.addListener(() {
      changeFocusKredit('noBPKB', focusNoBPKB.hasFocus);
    });
    focusProvisi.addListener(() {
      changeFocusKredit('provinsi', focusProvisi.hasFocus);
    });
    focusKota.addListener(() {
      changeFocusKredit('kota', focusKota.hasFocus);
    });
    focusTglExBPKB.addListener(() {
      changeFocusKredit('tglExBPKB', focusTglExBPKB.hasFocus);
    });
    focusTglExSTNK.addListener(() {
      changeFocusKredit('tglExSTNK', focusTglExSTNK.hasFocus);
    });
  }

  changeFocusKredit(String type, bool val){
    switch(type){
      case 'hargaJual':
        hargaJualFocus.value = val;
        return;
      case 'otr':
        OTRFocus.value = val;
        return;
      case 'maxBayar':
        maxBayarFocus.value = val;
        return;
      case 'noRangka':
        noRangkaFocus.value = val;
        return;
      case 'noMesin':
        noMesinFocus.value = val;
        return;
      case 'namaBPKB':
        namaBPKBFocus.value = val;
        return;
      case 'noBPKB':
        noBPKBFocus.value = val;
        return;
      case 'provinsi':
        provinsiFocus.value = val;
        return;
      case 'kota':
        kotaFocus.value = val;
        return;
      case 'tglExBPKB':
        tglExBPKBFocus.value = val;
        return;
      case 'tglExSTNK':
        tglExSTNKFocus.value = val;
        return;
      case 'noKontrak':
        noKontrakFocus.value = val;
        return;
      case 'tenor':
        tenorFocus.value = val;
        return;
      case 'dp':
        dpFocus.value = val;
        return;
      case 'pokokPinjam':
        pokokPinjamFocus.value = val;
        return;
      case 'bunga':
        bungaFocus.value = val;
        return;
      case 'bungaFLat':
        bungaFlatFocus.value = val;
        return;
      case 'bungaEfektif':
        bungaEfektifFocus.value = val;
        return;
      case 'totalPinjam':
        totalPinjamFocus.value = val;
        return;
      case 'bayar':
        pembayaranFocus.value = val;
        return;
      case 'serta':
        kesertaanFocus.value = val;
        return;
      case 'jenis':
        jenisFocus.value = val;
        return;
      case 'premi':
        premiFocus.value = val;
        return;
      case 'admin':
        adminFocus.value = val;
        return;
      case 'fidusia':
        fidusiaFocus.value = val;
        return;
      case 'provisi':
        provisiFocus.value = val;
        return;
      case 'nilaiTanggung':
        nilaiaTanggungFocus.value = val;
        return;
      case 'survey':
        surveyFocus.value = val;
        return;
      case 'notaris':
        notarisFocus.value = val;
        return;
      case 'totalBiaya':
        totalBiayaFocus.value = val;
        return;
      case 'angsuran':
        angsuranFocus.value = val;
        return;
      case 'angsuranPertama':
        angsuranPertanaFocus.value = val;
        return;
      case 'cair':
        cairFocus.value = val;
        return;
      case 'totalDP':
        totalDPFocus.value = val;
        return;
      case 'nvp':
        nvpFocus.value = val;
        return;
    }
  }

  ModelDetailKredit? _detailKredit;
  ModelDetailKredit get detailKredit => _detailKredit!;

  changeDetailKredit(ModelDetailKredit data){
    _detailKredit = data;
  }

  List<File> _dataImage = [];
  List<File> get dataImage => _dataImage;

  changeImageKontrak(List<File> data){
    // listImagesKontrak.value.clear();
    listImagesKontrak.value = data;
  }
  changeImageJaminan(List<File> data){
    // listImagesJaminan.value.clear();
    listImagesJaminan.value = data;
  }

  setEnableJaminan(){
    // enableButtonJaminan.value = true;
    if(edtHargaJual.text != '' ||
        edtHargaOTR.text != '' ||
        edtMaxBayar.text != '' ||
        edtNoRangka.text != '' ||
        edtNoMesin.text != '' ||
        edtNamaBPKB.text != '' ||
        edtNoBPKB.text != '' ||
        edtProvinsi.text != '' ||
        edtKota.text != '' ||
        edtTglExBPKB.text != '' ||
        edtTglExSTNK.text != ''
    ) {
      enableButtonJaminan.value = true;
    }else{
      enableButtonJaminan.value = false;
    }
  }

  setEnableKontrak(){
    // enableButtonKontrak.value = true;
    if(edtNoKontrak.text != '' ||
        edtTenor.text != '' ||
        edtDP.text != '' ||
        edtPokokPinjam.text != '' ||
        edtBunga.text != '' ||
        edtBungaFlat.text != '' ||
        edtBungaEfektif.text != '' ||
        edtTotalPinjam.text != '' ||
        edtPembayaran.text != '' ||
        edtKesertaan.text != '' ||
        edtJenis.text != '' ||
        edtPremi.text != '' ||
        edtAdmin.text != '' ||
        edtFidusila.text != '' ||
        edtProvisi.text != '' ||
        edtNilaiTanggung.text != '' ||
        edtSurveyVerify.text != '' ||
        edtNotaris.text != '' ||
        edtTotalBiaya.text != '' ||
        edtAngsuran.text != '' ||
        edtAngsuranPertama.text != '' ||
        edtNilaiCair.text != '' ||
        edtNilaiTotalDP.text != '' ||
        edtNVP.text != ''
    ) {
      enableButtonKontrak.value = true;
    }else{
      enableButtonKontrak.value = false;
    }
    if(msgErrorNoKontrak.value != ''){
      enableButtonKontrak.value = false;
    }
  }

  setProvinsi(Datum data){
    edtKecamatan.text = '';
    edtKota.text = '';
    edtProvinsi.text = data.name.toString();
    selectedProv.value = data;
    selectedKota.value = Datum();
    selectedKec.value = Datum();
    modelKota.value = ModelWilayah();
    modelKec.value = ModelWilayah();
    getNewKota(id: data.id!);
    // setEnableNext();
  }

  setKota(Datum data){
    edtKecamatan.text = '';
    edtKota.text = data.name.toString();
    _kotaID = data.id.toString();
    selectedKota.value = data;
    selectedKec.value = Datum();
    modelKec.value = ModelWilayah();
    getNewKec(id: data.id!);
    // setEnableNext();
  }

  String _kotaID = '';
  String get kotaID => _kotaID;

  setKecamatan(Datum data){
    edtKecamatan.text = data.name.toString();
    // _kecamatanID = data.id.toString();
    selectedKec.value = data;
    // setEnableNext();
  }

  setTenor(Datum data){
    edtTenor.text = data.name.toString();
    selectedTenor.value = data;
  }
  setPembayaran(Datum data){
    edtPembayaran.text = data.name.toString();
    selectedBayarAsuransi.value = data;
  }
  setKesertaan(Datum data){
    edtKesertaan.text = data.name.toString();
    selectedKesertaanAsuransi.value = data;
  }
  setJenis(Datum data){
    edtJenis.text = data.name.toString();
    selectedJenis.value = data;
  }
  setPertanggungan(Datum data){
    edtNilaiTanggung.text = data.name.toString();
    selectedNilaiTanggung.value = data;
  }
  setAngsuran(Datum data){
    edtAngsuranPertama.text = data.name.toString();
    selectedAngsuran.value = data;
  }

  getTenor(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    tenorLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.tenor.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      tenorLoad.value = false;
      modelTenor.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if( edtTenor.text != ''){
          var tenor = modelTenor.value.data!.singleWhere((element) => element.name == edtTenor.text);
          selectedTenor.value = tenor;
        }
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      tenorLoad.value = false;
      print(jsonEncode(res.body));
    }
    getPembayaranAsuransi(isEdit);
  }

  getPembayaranAsuransi(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    bayarAsuransiLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.pembayaranAsuransi.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      bayarAsuransiLoad.value = false;
      modelBayarAsuransi.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if(edtPembayaran.text != ''){
          var tenor = modelBayarAsuransi.value.data!.singleWhere((element) => element.name == edtPembayaran.text);
          selectedBayarAsuransi.value = tenor;
        };
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      bayarAsuransiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getKesertaanAsuransi(isEdit);
  }

  getKesertaanAsuransi(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    sertaAsuransiLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kesertaanAsuransi.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      sertaAsuransiLoad.value = false;
      modelKesertaanAsuransi.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if(edtKesertaan.text != ''){
          var tenor = modelKesertaanAsuransi.value.data!.singleWhere((element) => element.name == edtKesertaan.text);
          selectedKesertaanAsuransi.value = tenor;
        }

      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      sertaAsuransiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getJenis(isEdit);
  }

  getJenis(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    jenisLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.jenisAsuransi.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      jenisLoad.value = false;
      modelJenis.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if(edtJenis.text != ''){
          var tenor = modelJenis.value.data!.singleWhere((element) => element.name == edtJenis.text);
          selectedJenis.value = tenor;
        }
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      jenisLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNilaiPertanggungan(isEdit);
  }

  getNilaiPertanggungan(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    nilaiTanggungLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.nilaiTanggung.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      nilaiTanggungLoad.value = false;
      modelNilaiTanggung.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if(edtNilaiTanggung.text != ''){
          var tenor = modelNilaiTanggung.value.data!.singleWhere((element) => element.name == edtNilaiTanggung.text);
          selectedNilaiTanggung.value = tenor;
        }
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      nilaiTanggungLoad.value = false;
      print(jsonEncode(res.body));
    }
    getAngsuran(isEdit);
  }

  getAngsuran(bool isEdit) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    angsuranLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.angsuranPertama.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      angsuranLoad.value = false;
      modelAngsuran.value = modelProvinsiFromMap(res.body);
      if(isEdit){
        if(edtAngsuranPertama.text != ''){
          var tenor = modelAngsuran.value.data!.singleWhere((element) => element.name == edtAngsuranPertama.text);
          selectedAngsuran.value = tenor;
        }
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      angsuranLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getNewProv() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    provLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.prov.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      provLoad.value = false;
      modelProv.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      provLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getNewKota({required int id}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kotaLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kotaKab.toString()}${id.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      kotaLoad.value = false;
      modelKota.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kotaLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getNewKec({required int id}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kecLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kec.toString()}${id.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      kecLoad.value = false;
      modelKec.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kecLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  changePage(int val){
    pageKredir.value = val;
  }

  getUnit({int? unitId}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var strUrl = '${ ApiUrl.domain.toString()}/api/lead/detail_unit/${unitId.toString()}';
    print('URL ${strUrl}');
    print('TOKEN ${value.token.toString()}');
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      dataUnit.value = modelLeadDetailUnitFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      print(jsonEncode(res.body));
    }
    getNewProv();
    getKreditDetail(unitId: unitId);

    // var generateCode = generate();
    // if(generateCode){
    //   if(hitGene < 10){
    //     generate();
    //   }else{
    //     generateTambahDIgit();
    //   }
    // }
  }

  // var hitGene = 0;
  //8 digit
  // generate(){
  //   hitGene++;
  //   if(hitGene < 10){
  //     //do something
  //   }else{
  //     //tambah 1 digit
  //   }
  //   // if()
  // }
  //
  // //9 digit
  // generateTambahDIgit(){
  //   hitGene++;
  //   return true;
  // }

  getKreditDetail({int? unitId}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var strUrl = '${ ApiUrl.domain.toString()}/api/lead/kredit/${unitId.toString()}';
    print('URL ${strUrl}');
    print('TOKEN ${value.token.toString()}');
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      id_kredir.value = dataJson['data']['credit_number'];
      dataKredit.value = modelDetailKreditFromMap(res.body);
      if(dataKredit.value != null){
        changeDetailKredit(dataKredit.value);
        List<String> fotoJ =  dataKredit.value.data!.photo_document!.document_jaminan!;
        List<String> fotoK =  dataKredit.value.data!.photo_document!.document_kontrak!;
        allFoto.value = fotoJ+fotoK;

        // var suratKedaraanVisible = false;
        // if(dataKredit.value.data!.spekUnit!.nomorRangka != '' || dataKredit.value.data!.spekUnit!.nomorMesin !='' || dataKredit.value.data!.surat!.namaPemilikBpkb != '' ||
        //     dataKredit.value.data!.surat!.nomorBpkb != '' || dataKredit.value.data!.surat!.kotaTerbitBpk != ''){
        //   suratKedaraanVisible = true;
        // }
      }
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      print(jsonEncode(res.body));
    }
  }

  openDatePicker(BuildContext context, TextEditingController controller) async {
    DateTime dateTime;
    dateTime = DateTime.now();
    final DateTime picked = (await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: yd_Color_Primary, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black87, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: yd_Color_Primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate:  dateTime,
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100)
    ))!;
    if (picked != null){
      final dateFormat = DateFormat("yyyy-MM-dd");
      controller.text = dateFormat.format(picked);
      setEnableJaminan();
    }
  }

  saveDataJaminan({Function? onSuccess}){
    String jaminan = edtHargaJual.text.toString()+'|'+
        edtHargaOTR.text.toString()+'|'+
        edtMaxBayar.text.toString()+'|'+
        edtNoRangka.text.toString()+'|'+
        edtNoMesin.text.toString()+'|'+
        edtNamaBPKB.text.toString()+'|'+
        edtNoBPKB.text.toString()+'|'+
        edtProvinsi.text.toString()+'|'+
        edtKota.text.toString()+'|'+
        edtTglExBPKB.text.toString()+'|'+
        edtTglExSTNK.text.toString()+'|'+
        kotaID
    ;

    Utils.saveKreditJaminan(jaminan);
    onSuccess!();
  }

  initFormKredit() async{
    var data = await Utils.getKreditJaminan();
    bool completeJaminan = false;
    if(data != ''){
      var strData = data.split('|');
      if(strData.length > 0){
        completeJaminan = true;
      }else{
        completeJaminan = false;
      }
    }else {
      completeJaminan = false;
    }

    var dataInstitusi = await Utils.getKreditKontrak();
    bool completeKontrak = false;
    if(dataInstitusi != ''){
      var strData = dataInstitusi.split('|');
      if(strData.length > 0){
        completeKontrak = true;
      }else{
        completeKontrak = false;
      }
    }else {
      completeKontrak = false;
    }

    if(completeJaminan && completeKontrak){
      allDocComplete.value = true;
    }else{
      allDocComplete.value = false;
    }
  }

  postKreditJaminan(BuildContext context, String id, List<File> images, Function onSuccess) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}/api/lead/kredit/jaminan/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');
    request.fields.addAll({'_method':'put'});
    request.fields.addAll({
      'new_price': edtHargaJual.text.toString().replaceAll(',', ''),
      'price_on_road': edtHargaOTR.text.toString().replaceAll(',', ''),
      'max_financing': edtMaxBayar.text.toString().replaceAll(',', ''),
      'chassis_number': edtNoRangka.text.toString(),
      'machine_number': edtNoMesin.text.toString(),
      'name': edtNamaBPKB.text.toString(),
      'bpkb_number': edtNoBPKB.text.toString(),
      'kabupaten_id': kotaID,
      'bpkb_validity_period': edtTglExBPKB.text.toString(),
      'stnk_validity_period': edtTglExSTNK.text.toString()
    });

    print(jsonEncode(request.fields));

    for(int i=0; i<images.length; i++){
      request.files.add(await http.MultipartFile.fromPath('photo_document[$i]', images[i].path));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Get.back();
    if (response.statusCode == 200) {
      onSuccess();
    } else {
      log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      log(await response.stream.bytesToString());
    }
  }

  postKreditKontrak(BuildContext context, String id, List<File> images, Function onSuccess) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}/api/lead/kredit/kontrak/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');
    request.fields.addAll({'_method':'put'});
    request.fields.addAll({
      'credit_number': edtNoKontrak.text.toString().replaceAll(',', ''),
      'tenor_id': selectedTenor.value == null ? selectedTenor.value.id.toString():'',
      'down_payment': edtDP.text.toString().replaceAll(',', ''),
      'loan_principal': edtPokokPinjam.text.toString().replaceAll(',', ''),
      'interest': edtBunga.text.toString().replaceAll(',', ''),
      'flat_interest_rate': edtBungaFlat.text.toString().replaceAll(',', ''),
      'effective_interest_rate': edtBungaEfektif.text.toString().replaceAll(',', ''),
      'total_loan': edtTotalPinjam.text.toString().replaceAll(',', ''),

      'insurance_payment_id': selectedBayarAsuransi.value.id != null ? selectedBayarAsuransi.value.id.toString():'',
      'insurance_participation_id': selectedKesertaanAsuransi.value.id != null ? selectedKesertaanAsuransi.value.id.toString():'',
      'insurance_type_id': selectedJenis.value.id != null ? selectedJenis.value.id.toString():'',
      'insurance_premium': edtPremi.text.toString().replaceAll(',', ''),

      'administrasi_fee': edtAdmin.text.toString().replaceAll(',', ''),
      'fudicia_fee': edtFidusila.text.toString().replaceAll(',', ''),
      'provisi_fee': edtProvisi.text.toString().replaceAll(',', ''),
      'coverage_value_id': selectedNilaiTanggung.value.id != null ? selectedNilaiTanggung.value.id.toString():'',
      'survey_fee': edtSurveyVerify.text.toString().replaceAll(',', ''),
      'notaris_fee': edtNotaris.text.toString().replaceAll(',', ''),
      'total': edtTotalBiaya.text.toString().replaceAll(',', ''),

      'first_installment_id': selectedAngsuran.value.id != null ? selectedAngsuran.value.id.toString().replaceAll(',', ''):'',
      'installment': edtAngsuran.text.toString().replaceAll(',', ''),
      'disbursement_value': edtNilaiCair.text.toString().replaceAll(',', ''),
      'total_value_dp': edtNilaiTotalDP.text.toString().replaceAll(',', ''),
      'fee_seller': edtNVP.text.toString().replaceAll(',', ''),
    });

    for(int i=0; i<images.length; i++){
      request.fields.addAll({'photo_document[$i]': images[i].path});
      request.files.add(await http.MultipartFile.fromPath('photo_document[$i]', images[i].path));
    }
    var das = jsonEncode(request.fields);
    print(jsonEncode(request.fields));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      onSuccess();
    } else {
      log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      log(await response.stream.bytesToString());
    }
  }

  initJaminan(ModelDetailKredit data){
    edtHargaJual.text = data.data!.biaya!.hargaKendaraanBaru! > 0 ? numberFor.format(data.data!.biaya!.hargaKendaraanBaru!):'';
    edtHargaOTR.text = data.data!.biaya!.hargaOnTheRoad! > 0 ? numberFor.format(data.data!.biaya!.hargaOnTheRoad!):'';
    edtMaxBayar.text = data.data!.biaya!.maxPembiayaanTrukKepu! > 0 ? numberFor.format(data.data!.biaya!.maxPembiayaanTrukKepu!):'';
    edtNoRangka.text = Utils.clearTextfield(data.data!.spekUnit!.nomorRangka.toString());
    edtNoMesin.text = Utils.clearTextfield(data.data!.spekUnit!.nomorMesin.toString());
    edtNamaBPKB.text = Utils.clearTextfield(data.data!.surat!.namaPemilikBpkb.toString());
    edtNoBPKB.text = Utils.clearTextfield(data.data!.surat!.nomorBpkb.toString());
    edtProvinsi.text = Utils.clearTextfield(data.data!.domisiliSurat!.provinsi.toString());
    edtKota.text = Utils.clearTextfield(data.data!.domisiliSurat!.kabupaten.toString());
    edtTglExBPKB.text = data.data!.surat!.tanggalBerlakuBpkb != null ? DateFormat("yyyy-MM-dd").format(DateTime.parse(data.data!.surat!.tanggalBerlakuBpkb.toString())):'';
    edtTglExSTNK.text = data.data!.surat!.masaBerlakuStnk != null ? DateFormat("yyyy-MM-dd").format(DateTime.parse(data.data!.surat!.masaBerlakuStnk.toString())):'';

    setEnableJaminan();
    getNewProvEdit(edtProvinsi.text.toString());
  }

  initKontrak(ModelDetailKredit data){
    //kredit
    edtNoKontrak.text = Utils.clearTextfield(data.data!.biaya!.noKontrak!)!;
    edtTenor.text = Utils.clearTextfield(data.data!.biaya!.tenor!);
    edtDP.text = data.data!.biaya!.dp! > 0 ? numberFor.format(data.data!.biaya!.dp!):Utils.clearTextfield(data.data!.biaya!.dp!.toString());
    edtPokokPinjam.text = data.data!.biaya!.pokokPinjaman! > 0 ? numberFor.format(data.data!.biaya!.pokokPinjaman):'';
    edtBunga.text = Utils.clearTextfield(data.data!.biaya!.bunga.toString());
    edtBungaFlat.text = Utils.clearTextfield(data.data!.biaya!.sukuBungaFlat.toString());
    edtBungaEfektif.text = Utils.clearTextfield(data.data!.biaya!.sukuBungaEfektif.toString());
    edtTotalPinjam.text = data.data!.biaya!.totalPinjaman! > 0 ? numberFor.format(data.data!.biaya!.totalPinjaman):'';

    //asuransi
    edtPembayaran.text = Utils.clearTextfield(data.data!.biaya!.pembayaranAsuransi.toString());
    edtKesertaan.text = Utils.clearTextfield(data.data!.biaya!.kesertaanAsuransi.toString());
    edtJenis.text = Utils.clearTextfield(data.data!.biaya!.jenisAsuransi.toString());
    edtPremi.text = Utils.clearTextfield(data.data!.biaya!.premiAsuransi.toString());

    //admin
    edtAdmin.text = data.data!.biaya!.biayaAdministrasi! > 0 ? numberFor.format(data.data!.biaya!.biayaAdministrasi):'';
    edtFidusila.text = data.data!.biaya!.biayaFudicia! > 0 ? numberFor.format(data.data!.biaya!.biayaFudicia):'';
    edtProvisi.text = data.data!.biaya!.biayaProvisi! > 0 ? numberFor.format(data.data!.biaya!.biayaProvisi):'';
    edtNilaiTanggung.text = Utils.clearTextfield(data.data!.biaya!.nilaiPertanggungan.toString());
    edtSurveyVerify.text = data.data!.biaya!.biayaSurveyVerifikasi! > 0 ? numberFor.format(data.data!.biaya!.biayaSurveyVerifikasi):'';
    edtNotaris.text = data.data!.biaya!.biayaNotaris! > 0 ? numberFor.format(data.data!.biaya!.biayaNotaris):'';
    edtTotalBiaya.text = data.data!.biaya!.totalBiaya! > 0 ? numberFor.format(data.data!.biaya!.totalBiaya):'';

    //angsuran
    edtAngsuran.text = data.data!.biaya!.angsuran! > 0 ? numberFor.format(data.data!.biaya!.angsuran):'';
    edtAngsuranPertama.text = Utils.clearTextfield(data.data!.biaya!.angsuranPertama.toString());

    //pencairan
    edtNilaiCair.text = int.parse(data.data!.biaya!.nilaiPencairan!) > 0 ? numberFor.format(int.parse(data.data!.biaya!.nilaiPencairan!)):'';
    edtNilaiTotalDP.text = data.data!.biaya!.nilaiTotalDP! > 0 ? numberFor.format(data.data!.biaya!.nilaiTotalDP!):'';
    edtNVP.text = data.data!.biaya!.komisiSeller! > 0 ? numberFor.format(data.data!.biaya!.komisiSeller):'';

    getTenor(true);

  }


  setProvinsiEdit(Datum data){
    // edtKecamatan.text = '';
    // edtKota.text = '';
    edtProvinsi.text = data.name.toString();
    selectedProv.value = data;
    selectedKota.value = Datum();
    selectedKec.value = Datum();
    modelKota.value = ModelWilayah();
    modelKec.value = ModelWilayah();
    getNewKotaEdit(id: data.id!, kotaName: edtKota.text.toString());
    // setEnableNext();
  }

  setKotaEdit(Datum data){
    _kotaID = data.id.toString();
    edtKota.text = data.name.toString();
    selectedKota.value = data;
  }

  getNewProvEdit(String strProv) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    provLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.prov.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      provLoad.value = false;
      modelProv.value = modelProvinsiFromMap(res.body);
      var dataProv = modelProv.value.data!.singleWhere((element) => element.name == strProv );
      setProvinsiEdit(dataProv);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      provLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getNewKotaEdit({required int id, String? kotaName}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kotaLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kotaKab.toString()}${id.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      kotaLoad.value = false;
      modelKota.value = modelProvinsiFromMap(res.body);
      var dataKota = modelKota.value.data!.singleWhere((element) => element.name == kotaName );
      setKotaEdit(dataKota);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kotaLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  updateJaminan(BuildContext context, int id, onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/kredit/jaminan/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'new_price': edtHargaJual.text.toString().replaceAll(',', ''),
      'price_on_road': edtHargaOTR.text.toString().replaceAll(',', ''),
      'max_financing': edtMaxBayar.text.toString().replaceAll(',', ''),
      'chassis_number': edtNoRangka.text.toString(),
      'machine_number': edtNoMesin.text.toString(),
      'name': edtNamaBPKB.text.toString(),
      'bpkb_number': edtNoBPKB.text.toString(),
      'kabupaten_id': kotaID,
      'bpkb_validity_period': edtTglExBPKB.text.toString(),
      'stnk_validity_period': edtTglExSTNK.text.toString()
    };
    print('BODY ${jsonEncode(body)}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailKredit modelDetail = modelDetailKreditFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess(modelDetail);
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  updateKontrak(BuildContext context, int id, onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/kredit/kontrak/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'credit_number': edtNoKontrak.text.toString().replaceAll(',', ''),
      'tenor_id': selectedTenor.value.id != null ? selectedTenor.value.id.toString():'',
      'down_payment': edtDP.text.toString().replaceAll(',', ''),
      'loan_principal': edtPokokPinjam.text.toString().replaceAll(',', ''),
      'interest': edtBunga.text.toString().replaceAll(',', ''),
      'flat_interest_rate': edtBungaFlat.text.toString().replaceAll(',', ''),
      'effective_interest_rate': edtBungaEfektif.text.toString().replaceAll(',', ''),
      'total_loan': edtTotalPinjam.text.toString().replaceAll(',', ''),

      'insurance_payment_id': selectedBayarAsuransi.value.id != null ? selectedBayarAsuransi.value.id.toString():'',
      'insurance_participation_id': selectedKesertaanAsuransi.value.id != null ? selectedKesertaanAsuransi.value.id.toString():'',
      'insurance_type_id': selectedJenis.value.id != null ? selectedJenis.value.id.toString():'',
      'insurance_premium': edtPremi.text.toString().replaceAll(',', ''),

      'administrasi_fee': edtAdmin.text.toString().replaceAll(',', ''),
      'fudicia_fee': edtFidusila.text.toString().replaceAll(',', ''),
      'provisi_fee': edtProvisi.text.toString().replaceAll(',', ''),
      'coverage_value_id': selectedNilaiTanggung.value.id != null ? selectedNilaiTanggung.value.id.toString():'',
      'survey_fee': edtSurveyVerify.text.toString().replaceAll(',', ''),
      'notaris_fee': edtNotaris.text.toString().replaceAll(',', ''),
      'total': edtTotalBiaya.text.toString().replaceAll(',', ''),

      'first_installment_id': selectedAngsuran.value.id != null ? selectedAngsuran.value.id.toString().replaceAll(',', ''):'',
      'installment': edtAngsuran.text.toString().replaceAll(',', ''),
      'disbursement_value': edtNilaiCair.text.toString().replaceAll(',', ''),
      'total_value_dp': edtNilaiTotalDP.text.toString().replaceAll(',', ''),
      'fee_seller': edtNVP.text.toString().replaceAll(',', ''),
    };
    var datasda = jsonEncode(body);
    print('BODY ${jsonEncode(body)}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailKredit modelDetail = modelDetailKreditFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess(modelDetail);
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  postDokumenKontrak({
    BuildContext? context,
    String? id,
    List<String>? imageAwal,
    List<ModelListImageUpload>? imageChange,
    List<File>? imageBaru,
    Function? onSuccess
  }) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}${ApiUrl.uploadDocKontrak}/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    // imageChange.addAll(docs);
    request.fields.addAll({'_method':'put'});

    for(int i=0; i< imageChange!.length; i++){
      imageAwal!.removeAt(imageChange[i].index!);
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    for(int i=0; i< imageBaru!.length; i++){
      request.fields.addAll({'photo_document[${i}]':imageBaru[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageBaru[i].path));
    }

    for(int i=0; i<imageAwal!.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imageAwal[i]});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      onSuccess!();
    } else {
      Get.back();
      // log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      log(await response.stream.bytesToString());
    }
  }

  updateDokumenKontrak({
    BuildContext? context,
    String? id,
    List<String>? imageAwal,
    List<ModelListImageUpload>? imageChange,
    List<File>? imageBaru,
    Function? onSuccess
  }) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}${ApiUrl.uploadDocKontrak}/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    // imageChange.addAll(docs);
    request.fields.addAll({'_method':'put'});

    for(int i=0; i< imageChange!.length; i++){
      imageAwal!.removeAt(imageChange[i].index!);
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    for(int i=0; i< imageBaru!.length; i++){
      request.fields.addAll({'photo_document[${i}]':imageBaru[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageBaru[i].path));
    }

    for(int i=0; i<imageAwal!.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imageAwal[i]});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      print(await response.stream.bytesToString());
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Edit Kontrak Kredit Berhasil dikirim",
          onTap: () {
            Get.back();
            onSuccess!();
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    } else {
      Get.back();
      // log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      log(await response.stream.bytesToString());
    }
  }

  postDokumenJaminan({
    BuildContext? context,
    String? id,
    List<String>? imageAwal,
    List<ModelListImageUpload>? imageChange,
    List<File>? imageBaru,
    Function? onSuccess
  }) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}${ApiUrl.uploadDocJaminan}/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    // imageChange.addAll(docs);
    request.fields.addAll({'_method':'put'});

    for(int i=0; i< imageChange!.length; i++){
      imageAwal!.removeAt(imageChange[i].index!);
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    for(int i=0; i< imageBaru!.length; i++){
      request.fields.addAll({'photo_document[${i}]':imageBaru[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageBaru[i].path));
    }

    for(int i=0; i<imageAwal!.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imageAwal[i]});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      onSuccess!();
    } else {
      Get.back();
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(response.statusCode.toString());
      log(response.reasonPhrase.toString());
      log(await response.stream.bytesToString());
    }
  }

  updateDokumenJaminan({
    BuildContext? context,
    String? id,
    List<String>? imageAwal,
    List<ModelListImageUpload>? imageChange,
    List<File>? imageBaru,
    Function? onSucess
  }) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}${ApiUrl.uploadDocJaminan}/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    // imageChange.addAll(docs);
    request.fields.addAll({'_method':'put'});

    for(int i=0; i< imageChange!.length; i++){
      imageAwal!.removeAt(imageChange[i].index!);
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    for(int i=0; i< imageBaru!.length; i++){
      request.fields.addAll({'photo_document[${i}]':imageBaru[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageBaru[i].path));
    }

    for(int i=0; i<imageAwal!.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imageAwal[i]});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Data Kredit Berhasil dikirim",
          onTap: () {
            Get.back();
            onSucess!();
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    } else {
      Get.back();
      // log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    log(response.statusCode.toString());
    log(response.reasonPhrase.toString());
    log(await response.stream.bytesToString());
    }
  }

  checkNoKontrak(BuildContext context, String noKontak, String leadID) async {
    // Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/cekUnique/nomor-kredit';
    print('URL ${url}');
    var body = {
      'id': leadID,
      'value': noKontak,
    };
    print('BODY ${jsonEncode(body)}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    // Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      msgErrorNoKontrak.value = '';
      setEnableKontrak();
      // onSuccess(modelDetail);
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      msgErrorNoKontrak.value = dataJson['message'];
      setEnableKontrak();
      // rawBottomNotif(
      //   message: dataJson['message'],
      //   colorFont: Colors.white,
      //   backGround: Colors.red,
      // );
    }
  }
}