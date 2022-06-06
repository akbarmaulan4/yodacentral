
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_text_style.dart';
import 'package:yodacentral/models/kalkulator/otr_entry_model.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/utils/utils.dart';

class KalkulatorController extends GetxController{
  RxBool kondisiLoad = false.obs;
  RxBool merkLoad = false.obs;
  RxBool modelLoad = false.obs;
  RxBool varianLoad = false.obs;
  RxBool tahunLoad = false.obs;
  RxBool jarakLoad = false.obs;
  RxBool bahanBakarLoad = false.obs;
  RxBool transmisiLoad = false.obs;
  RxBool warnaLoad = false.obs;
  RxBool provLoad = false.obs;
  // RxBool kotaLoad = false.obs;
  // RxBool kecLoad = false.obs;
  // RxBool tujuanLoad = false.obs;
  RxBool kategoriLoad = false.obs;
  RxBool statusAsuransiLoad = false.obs;
  RxBool loanTypeLoad = false.obs;
  RxBool tenorLoad = false.obs;
  RxBool kategoriMobilLoad = false.obs;
  RxBool tipeAsuransiLoad = false.obs;
  RxBool tujuanPenggunaanLoad = false.obs;
  RxBool sprateRateLoad = false.obs;
  RxBool sprateAdminLoad = false.obs;
  RxBool provisiLoad = false.obs;
  RxBool showOTR = false.obs;
  RxBool enableNext = false.obs;

  RxString strRefundFlatValue = '0'.obs;
  RxString strRefundFlatPercent = '0'.obs;
  RxString strRefundAdmValue = '0'.obs;
  RxString strRefundAdmPercent = '0'.obs;
  RxString strTotalRefund = '0'.obs;

  Rx<ModelWilayah> modelKondisi = ModelWilayah().obs;
  Rx<ModelWilayah> modelMerk = ModelWilayah().obs;
  Rx<ModelWilayah> modelModel = ModelWilayah().obs;
  Rx<ModelWilayah> modelVarian = ModelWilayah().obs;
  Rx<ModelWilayah> modelTahun = ModelWilayah().obs;
  Rx<ModelWilayah> modelJarak = ModelWilayah().obs;
  Rx<ModelWilayah> modelBahanBakar = ModelWilayah().obs;
  Rx<ModelWilayah> modelTransmisi = ModelWilayah().obs;
  Rx<ModelWilayah> modelWarna = ModelWilayah().obs;
  Rx<ModelWilayah> modelProv = ModelWilayah().obs;
  Rx<ModelWilayah> modelKategori = ModelWilayah().obs;
  Rx<ModelWilayah> modelStatusAsuransi = ModelWilayah().obs;
  Rx<ModelWilayah> modelLoanType = ModelWilayah().obs;
  Rx<ModelWilayah> modelTenor = ModelWilayah().obs;
  Rx<ModelWilayah> modelKategoriMobil = ModelWilayah().obs;
  Rx<ModelWilayah> modelTipeAsuransi = ModelWilayah().obs;
  Rx<ModelWilayah> modelTujuanPenggunaan = ModelWilayah().obs;
  Rx<ModelWilayah> modelSprateRate = ModelWilayah().obs;
  Rx<ModelWilayah> modelSprateAdmin = ModelWilayah().obs;
  Rx<ModelWilayah> modelProvisi = ModelWilayah().obs;
  // Rx<ModelWilayah> modelKota = ModelWilayah().obs;
  // Rx<ModelWilayah> modelKec = ModelWilayah().obs;
  // Rx<ModelWilayah> modelTujuan = ModelWilayah().obs;

  Rx<Datum> selectedKondisi = Datum().obs;
  Rx<Datum> selectedMerk = Datum().obs;
  Rx<Datum> selectedModel = Datum().obs;
  Rx<Datum> selectedVarian = Datum().obs;
  Rx<Datum> selectedTahun = Datum().obs;
  Rx<Datum> selectedJarak = Datum().obs;
  Rx<Datum> selectedBahanBakar = Datum().obs;
  Rx<Datum> selectedTransmisi = Datum().obs;
  Rx<Datum> selectedWarna = Datum().obs;
  Rx<Datum> selectedProv = Datum().obs;
  // Rx<Datum> selectedKota = Datum().obs;
  // Rx<Datum> selectedKec = Datum().obs;
  // Rx<Datum> selectedTujuan = Datum().obs;
  Rx<Datum> selectedKategori = Datum().obs;
  Rx<Datum> selectedStatusAsuransi = Datum().obs;
  Rx<Datum> selectedLoanType = Datum().obs;
  Rx<Datum> selectedTenor = Datum().obs;
  Rx<Datum> selectedKategoriMobil = Datum().obs;
  Rx<Datum> selectedTipeAsuransi = Datum().obs;
  Rx<Datum> selectedTujuanPenggunaan = Datum().obs;
  Rx<Datum> selectedSprateRate = Datum().obs;
  Rx<Datum> selectedSprateAdmin = Datum().obs;
  Rx<Datum> selectedProvisi = Datum().obs;

  TextEditingController edtKondisi = TextEditingController();
  TextEditingController edtMerk = TextEditingController();
  TextEditingController edtModel = TextEditingController();
  TextEditingController edtVarian = TextEditingController();
  TextEditingController edtTahun = TextEditingController();
  TextEditingController edtDP = TextEditingController();
  TextEditingController edtOTREntry = TextEditingController();
  TextEditingController edtOTRDefault = TextEditingController();
  TextEditingController edtJarak = TextEditingController();
  TextEditingController edtBahanBakar = TextEditingController();
  TextEditingController edtTransmisi = TextEditingController();
  TextEditingController edtWarna = TextEditingController();
  TextEditingController edtProv = TextEditingController();
  // TextEditingController edtKota = TextEditingController();
  // TextEditingController edtKec = TextEditingController();
  // TextEditingController edtTujuan = TextEditingController();
  // TextEditingController edtHarga = TextEditingController();
  TextEditingController edtKategori = TextEditingController();
  TextEditingController edtStatusAsuransi = TextEditingController();
  TextEditingController edtLoanType = TextEditingController();
  TextEditingController edtTenor = TextEditingController();
  TextEditingController edtKategoriMobil = TextEditingController();
  TextEditingController edtTipeAsuransi = TextEditingController();
  TextEditingController edtTujuanPenggunaan = TextEditingController();
  TextEditingController edtSprateRate = TextEditingController();
  TextEditingController edtSprateAdmin = TextEditingController();
  TextEditingController edtProvisi = TextEditingController();

  FocusNode focusLokasi = FocusNode();
  FocusNode focusKondisi = FocusNode();
  FocusNode focusMerek = FocusNode();
  FocusNode focusModel = FocusNode();
  FocusNode focusVarian = FocusNode();
  FocusNode focusKategory = FocusNode();
  FocusNode focusTahun = FocusNode();
  FocusNode focusDP = FocusNode();
  FocusNode focusStatusAsuransi = FocusNode();
  FocusNode focusLoanType = FocusNode();
  FocusNode focusTenor = FocusNode();
  FocusNode focusKategoryMobil = FocusNode();
  FocusNode focusTipeAsuransi = FocusNode();
  FocusNode focusTujuanPenggunaan = FocusNode();
  FocusNode focusSprateRate = FocusNode();
  FocusNode focusSprateAdmin = FocusNode();
  FocusNode focusProvisi = FocusNode();
  FocusNode focusOTREntry = FocusNode();
  FocusNode focusOTRDefault = FocusNode();

  RxBool lokasiFocus = false.obs;
  RxBool KondisiMobilFocus = false.obs;
  RxBool merekFocus = false.obs;
  RxBool modelFocus = false.obs;
  RxBool varianFocus = false.obs;
  RxBool kategoryFocus = false.obs;
  RxBool tahunFocus = false.obs;
  RxBool dpFocus = false.obs;
  RxBool statusAsuransiFocus = false.obs;
  RxBool loanTypeFocus = false.obs;
  RxBool tenorFocus = false.obs;
  RxBool kategoryMobilFocus = false.obs;
  RxBool tujuanAsuransiFocus = false.obs;
  RxBool tipeAsuransiFocus = false.obs;
  RxBool tujuanPenggunaanFocus = false.obs;
  RxBool sprateRateFocus = false.obs;
  RxBool sprateAdminFocus = false.obs;
  RxBool provisiFocus = false.obs;
  RxBool otrEntryFocus = false.obs;
  RxBool otrDefaultFocus = false.obs;

  List<Datum> listTahun = [
    for (var i = DateTime.now().year; i >= 1945; i--)
      Datum(id: i, name: i.toString()),
  ];

  getNewProv() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    provLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.wilayah.toString()}';
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
    getNewKondisi();
  }

  getNewKondisi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kondisiLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.kondisiMobil.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString(),});
    if (res.statusCode == 200) {
      kondisiLoad.value = false;
      modelKondisi.value = modelProvinsiFromMap(res.body);
      print(jsonEncode(res.body));
    } else {
      kondisiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNewMerek();
  }

  getNewMerek() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    merkLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.merekMobil.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      merkLoad.value = false;
      modelMerk.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      merkLoad.value = false;
      print('RESPONSE ${json.decode(res.body)}');
    }
    getKategori();
  }

  getNewModel({required int idMerek}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    modelLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.model_mobil.toString()}${idMerek.toString()}';
    var res = await http.get(Uri.parse(strUrl), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      modelLoad.value = false;
      modelModel.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      modelLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getNewVarian({required int idModel}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    varianLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.varianMobil.toString()}${idModel.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      varianLoad.value = false;
      modelVarian.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      varianLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  getKategori() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kategoriLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.kategoriMobil.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      kategoriLoad.value = false;
      modelKategori.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kategoriLoad.value = false;
      print(jsonEncode(res.body));
    }
    getStatusAsuransi();
  }

  getStatusAsuransi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    statusAsuransiLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kesertaanAsuransi.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      statusAsuransiLoad.value = false;
      modelStatusAsuransi.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      statusAsuransiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getLoanType();
  }

  getLoanType() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    loanTypeLoad.value = true;
    String strUrl = '${ApiUrl.domainCal.toString()}${ApiUrl.loanType.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      loanTypeLoad.value = false;
      modelLoanType.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      loanTypeLoad.value = false;
      print(jsonEncode(res.body));
    }
    getTenor();
  }

  getTenor() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    tenorLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.tenorCal.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      tenorLoad.value = false;
      modelTenor.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      tenorLoad.value = false;
      print(jsonEncode(res.body));
    }
    jenisMobil();
  }

  jenisMobil() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kategoriMobilLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.jeniseMobil.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      kategoriMobilLoad.value = false;
      modelKategoriMobil.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kategoriMobilLoad.value = false;
      print(jsonEncode(res.body));
    }
    getTipeAsuransi();
  }

  getTipeAsuransi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    tipeAsuransiLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.tipeAsuransi.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      tipeAsuransiLoad.value = false;
      modelTipeAsuransi.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      tipeAsuransiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getTujuanPenggunaan();
  }

  getTujuanPenggunaan() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    tujuanPenggunaanLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.tujuanPenggunaan.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {
      'Authorization': 'Bearer ' + value.token.toString(),
    });
    if (res.statusCode == 200) {
      tujuanPenggunaanLoad.value = false;
      modelTujuanPenggunaan.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      tujuanPenggunaanLoad.value = false;
      print(jsonEncode(res.body));
    }
  }

  validationOTRDefault(){
    if(selectedProv.value.id != null &&
        selectedKondisi.value.id != null &&
        selectedMerk.value.id != null &&
        selectedModel.value.id != null &&
        selectedVarian.value.id != null &&
        selectedKategori.value.id != null &&
        selectedTahun.value.id != null){
      getValueOTRDefault();
    }
  }

  getValueOTRDefault() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    // tujuanPenggunaanLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.valueOTRDefault.toString()}';
    print('URL $url');
    var body = {
      "brand_id": selectedMerk.value.id.toString(),
      "model_id": selectedModel.value.id.toString(),
      "variant_id": selectedVarian.value.id.toString(),
      "car_condition_id": selectedKondisi.value.id.toString(),
      "car_category_id": selectedKategori.value.id.toString(),
      "region_id": selectedProv.value.id.toString(),
      "year": selectedTahun.value.name,
    };
    print('URL ${jsonEncode(body)}');
    var res = await http.post(Uri.parse(url.trim()),
        headers: {
          'Authorization': 'Bearer ' + value.token.toString(),
        },
        body: body
    );
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      ModelOTREntry model = ModelOTREntry.fromJson(dataJson['data']);
      if(model != null){
        showOTR.value = true;
        edtOTRDefault.text = numberFor.format(double.parse(model.otr_value));
      }
    }else{
      showOTR.value = false;
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  calculateOTRDefault({
    BuildContext? context,
    String? otrDefault,
    Function? onSuccess
    }) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    // tujuanPenggunaanLoad.value = true;
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.calculateOTRDefault.toString()}';
    Utils.loading(context!, 'Mohon tunggu...');
    var body;
    if(otrDefault != ''){
      body = {
        "region_id": selectedProv.value.id.toString(),
        "year": selectedTahun.value.name,
        "car_condition_id": selectedKondisi.value.id.toString(),
        "car_category_id": selectedKategori.value.id.toString(),
        "insurance_status_id": selectedStatusAsuransi.value.id.toString(),
        "loan_type_id": selectedLoanType.value.id.toString(),
        "insurance_type_id": selectedTipeAsuransi.value.id.toString(),
        "car_type_id": selectedKategoriMobil.value.id.toString(),
        "tenor": selectedTenor.value.id.toString(),
        "dp_value": edtDP.text.toString(),
        "utility_id": selectedTujuanPenggunaan.value.id.toString(),
        "sprate_rate": edtSprateRate.text.toString(),
        "provisi": edtProvisi.text.toString(),
        "brand_id": selectedMerk.value.id.toString(),
        "model_id": selectedModel.value.id.toString(),
        "variant_id": selectedVarian.value.id.toString(),
        "otr_default": otrDefault!.replaceAll(',', '').removeAllWhitespace,
        // "otr_entry": edtOTREntry.text.toString(),
      };
    }else{
      body = {
        "region_id": selectedProv.value.id.toString(),
        "year": selectedTahun.value.name,
        "car_condition_id": selectedKondisi.value.id.toString(),
        "car_category_id": selectedKategori.value.id.toString(),
        "insurance_status_id": selectedStatusAsuransi.value.id.toString(),
        "loan_type_id": selectedLoanType.value.id.toString(),
        "insurance_type_id": selectedTipeAsuransi.value.id.toString(),
        "car_type_id": selectedKategoriMobil.value.id.toString(),
        "tenor": selectedTenor.value.id.toString(),
        "dp_value": edtDP.text.toString(),
        "utility_id": selectedTujuanPenggunaan.value.id.toString(),
        "sprate_rate": edtSprateRate.text.toString(),
        "provisi": edtProvisi.text.toString(),
        "brand_id": selectedMerk.value.id.toString(),
        "model_id": selectedModel.value.id.toString(),
        "variant_id": selectedVarian.value.id.toString(),
        // "otr_default": otrDefault,
        "otr_entry": edtOTREntry.text.toString(),
      };
    }
    var res = await http.post(Uri.parse(url.trim()),
      headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      },
      body: body
    );
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      ModelOTREntry model = ModelOTREntry.fromJson(dataJson['data']);
      if(model != null){
        onSuccess!(model);
      }
      // Get.bottomSheet(
      //   GlobalScreenNotif(
      //     title: "Berhasil",
      //     content: "Data Nasabah Berhasil dikirim",
      //     onTap: () {
      //       Get.back();
      //     },
      //     textButton: "Selesai",
      //   ),
      //   isScrollControlled: true,
      // );
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

  calculateOTREntry({BuildContext? context, Function? onSuccess}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.calculateOTREntry.toString()}';
    print('URL ${url}');
    var body = {
      "region_id": selectedProv.value.id.toString(),
      "year": selectedTahun.value.name,
      "car_condition_id": selectedKondisi.value.id.toString(),
      "car_category_id": selectedKategori.value.id.toString(),
      "insurance_status_id": selectedStatusAsuransi.value.id.toString(),
      "loan_type_id": selectedLoanType.value.id.toString(),
      "insurance_type_id": selectedTipeAsuransi.value.id.toString(),
      "car_type_id": selectedKategori.value.id.toString(),
      "tenor": selectedTenor.value.id.toString(),
      "dp_value": edtDP.text.toString(),
      "otr_value": edtOTREntry.text.toString(),
      "utility_id": selectedTujuanPenggunaan.value.id.toString(),
      "sprate_rate": edtSprateRate.text.toString(),
      "provisi": edtProvisi.text.toString(),
    };
    print('Body ${jsonEncode(body)}');
    Utils.loading(context!, 'Mohon tunggu...');
    var res = await http.post(Uri.parse(url.trim()),
        headers: {
          'Authorization': 'Bearer ' + value.token.toString(),
        },
        body: body
    );
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      ModelOTREntry model = ModelOTREntry.fromJson(dataJson['data']);
      if(model != null){
        onSuccess!(model);
      }
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

  setProvinsi(Datum data){;
    edtProv.text = data.name.toString();
    selectedProv.value = data;
  }
  setKondisiMobil(Datum data){
    edtKondisi.text = data.name.toString();
    selectedKondisi.value = data;
    // setEnableNext();
  }
  setMerk(Datum data){
    edtMerk.text = data.name.toString();
    edtVarian.text = '';
    edtModel.text = '';
    selectedMerk.value = data;
    modelVarian.value = ModelWilayah();
    modelModel.value = ModelWilayah();
    getNewModel(idMerek: data.id!);
    // setEnableNext();
  }

  setModel(Datum data){
    edtModel.text = data.name.toString();
    edtVarian.text = '';
    selectedModel.value = data;
    modelVarian.value = ModelWilayah();
    getNewVarian(idModel: data.id!);
    // setEnableNext();
  }
  setVarian(Datum data){
    edtVarian.text = data.name.toString();
    selectedVarian.value = data;
    // setEnableNext();
  }
  setKategori(Datum data){
    edtKategori.text = data.name.toString();
    selectedKategori.value = data;
    // setEnableNext();
  }
  setTahun(Datum data){
    edtTahun.text = data.name.toString();
    selectedTahun.value = data;
    // setEnableNext();
  }
  setTenor(Datum data){
    edtTenor.text = data.name.toString();
    selectedTenor.value = data;
  }
  setKategoriMobil(Datum data){
    edtKategoriMobil.text = data.name.toString();
    selectedKategoriMobil.value = data;
  }
  setStatusAsuransi(Datum data){
    edtStatusAsuransi.text = data.name.toString();
    selectedStatusAsuransi.value = data;
  }
  setLoanType(Datum data){
    edtLoanType.text = data.name.toString();
    selectedLoanType.value = data;
  }
  setTipeAsuransi(Datum data){
    edtTipeAsuransi.text = data.name.toString();
    selectedTipeAsuransi.value = data;
  }
  setTujuanPenggunaan(Datum data){
    edtTujuanPenggunaan.text = data.name.toString();
    selectedTujuanPenggunaan.value = data;
  }

  initResultOTREntry(ModelOTREntry data){
    strRefundFlatPercent.value = data.refund_flat_percent;
    strRefundFlatValue.value = numberFor.format(double.parse(data.refund_flat_value));

    strRefundAdmPercent.value = data.refund_admin_percent;
    strRefundAdmValue.value = numberFor.format(double.parse(data.refund_admin_value));

    strTotalRefund.value = numberFor.format(double.parse(data.total_refund));
  }

  addRefundFlatPercent(BuildContext context, ModelOTREntry model, String val){
    if(val != ''){
      var data = int.parse(val);
      data++;
      strRefundFlatPercent.value = data.toString();
      calculateRefund(
          context: context,
          id: model.id,
          anuityPercent: model.anuity_percent,
          refundFlatPercent: data.toString(),
          durationYear: model.duration_year,
          phValue: model.ph_value,
          adm: model.administration,
          refundAdmPercent: strRefundAdmPercent.value
      );
    }
  }

  decRefundFlatPercent(BuildContext context, ModelOTREntry model, String val){
    if(val != ''){
      var data = int.parse(val);
      if(data > 0){
        data--;
        strRefundFlatPercent.value = data.toString();
        calculateRefund(
            context: context,
            id: model.id,
            anuityPercent: model.anuity_percent,
            refundFlatPercent: data.toString(),
            durationYear: model.duration_year,
            phValue: model.ph_value,
            adm: model.administration,
            refundAdmPercent: strRefundAdmPercent.value
        );
      }
    }
  }

  addRefundAdmPercent(BuildContext context, ModelOTREntry model, String val){
    if(val != ''){
      var data = int.parse(val);
      data++;
      strRefundAdmPercent.value = data.toString();
      calculateRefund(
          context: context,
          id: model.id,
          anuityPercent: model.anuity_percent,
          refundFlatPercent: strRefundFlatPercent.value,
          durationYear: model.duration_year,
          phValue: model.ph_value,
          adm: model.administration,
          refundAdmPercent: data.toString()
      );
    }
  }

  decRefundAdmPercent(BuildContext context, ModelOTREntry model, String val){
    if(val != ''){
      var data = int.parse(val);
      if(data > 0){
        data--;
        strRefundAdmPercent.value = data.toString();
        calculateRefund(
            context: context,
            id: model.id,
            anuityPercent: model.anuity_percent,
            refundFlatPercent: strRefundFlatPercent.value,
            durationYear: model.duration_year,
            phValue: model.ph_value,
            adm: model.administration,
            refundAdmPercent: data.toString()
        );
      }
    }
  }

  calculateRefund({
    BuildContext? context,
    String? id,
    String? anuityPercent,
    String? refundFlatPercent,
    String? durationYear,
    String? phValue,
    String? adm,
    String? refundAdmPercent,
  }) async{
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domainCal.toString()}${ApiUrl.calculateRefund.toString()}';
    print('URL ${url}');
    var body = {
      "id": id,
      // "anuity_percent": anuityPercent,
      "refund_flat_percent": refundFlatPercent,
      // "duration_year": durationYear,
      // "ph_value": phValue,
      // "administration": adm,
      "refund_admin_percent": refundAdmPercent
    };
    print('Body ${jsonEncode(body)}');
    Utils.loading(context!, 'Mohon tunggu...');
    var res = await http.post(Uri.parse(url.trim()),
        headers: {
          'Authorization': 'Bearer ' + value.token.toString(),
        },
        body: body
    );
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      ModelOTREntry model = ModelOTREntry.fromJson(dataJson['data']);
      if(model != null){
        strRefundFlatPercent.value = dataJson['data']['refund_flat_percent'].toString();
        strRefundFlatValue.value = numberFor.format(double.parse(dataJson['data']['refund_flat_value'].toString()));
        strRefundAdmPercent.value = dataJson['data']['refund_admin_percent'].toString();
        strRefundAdmValue.value = numberFor.format(double.parse(dataJson['data']['refund_admin_value'].toString()));
        strTotalRefund.value = numberFor.format(double.parse(dataJson['data']['total_refund'].toString()));
      }
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
}