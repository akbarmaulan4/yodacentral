import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/save_root/save_root.dart';

class ControllerWilayah extends GetxController {
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
  RxBool kotaLoad = false.obs;
  RxBool kecLoad = false.obs;
  RxBool tujuanLoad = false.obs;
  RxBool enableNext = false.obs;

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
  Rx<ModelWilayah> modelKota = ModelWilayah().obs;
  Rx<ModelWilayah> modelKec = ModelWilayah().obs;
  Rx<ModelWilayah> modelTujuan = ModelWilayah().obs;

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
  Rx<Datum> selectedKota = Datum().obs;
  Rx<Datum> selectedKec = Datum().obs;
  Rx<Datum> selectedTujuan = Datum().obs;

  TextEditingController edtKondisi = TextEditingController();
  TextEditingController edtMerk = TextEditingController();
  TextEditingController edtModel = TextEditingController();
  TextEditingController edtVarian = TextEditingController();
  TextEditingController edtTahun = TextEditingController();
  TextEditingController edtJarak = TextEditingController();
  TextEditingController edtBahanBakar = TextEditingController();
  TextEditingController edtTransmisi = TextEditingController();
  TextEditingController edtWarna = TextEditingController();
  TextEditingController edtProv = TextEditingController();
  TextEditingController edtKota = TextEditingController();
  TextEditingController edtKec = TextEditingController();
  TextEditingController edtTujuan = TextEditingController();
  TextEditingController edtHarga = TextEditingController();

  allClear(){
    selectedKondisi.value =  Datum();
    selectedMerk.value =  Datum();
    selectedModel.value =  Datum();
    selectedVarian.value =  Datum();
    selectedTahun.value =  Datum();
    selectedJarak.value =  Datum();
    selectedBahanBakar.value =  Datum();
    selectedTransmisi.value =  Datum();
    selectedWarna.value =  Datum();
    selectedProv.value =  Datum();
    selectedKota.value =  Datum();
    selectedKec.value =  Datum();
    selectedTujuan.value =  Datum();

    edtKondisi.text = '';
    edtMerk.text = '';
    edtModel.text = '';
    edtVarian.text = '';
    edtTahun.text = '';
    edtJarak.text = '';
    edtBahanBakar.text = '';
    edtTransmisi.text = '';
    edtWarna.text = '';
    edtProv.text = '';
    edtKota.text = '';
    edtKec.text = '';
    edtTujuan.text = '';
    edtHarga.text = '';
  }

  setKondisiMobil(Datum data){
    edtKondisi.text = data.name.toString();
    selectedKondisi.value = data;
    setEnableNext();
  }

  setMerk(Datum data){
    edtMerk.text = data.name.toString();
    edtVarian.text = '';
    edtModel.text = '';
    selectedMerk.value = data;
    modelVarian.value = ModelWilayah();
    modelModel.value = ModelWilayah();
    getNewModel(idMerek: data.id!);
    setEnableNext();
  }

  setModel(Datum data){
    edtModel.text = data.name.toString();
    edtVarian.text = '';
    selectedModel.value = data;
    modelVarian.value = ModelWilayah();
    getNewVarian(idModel: data.id!);
    setEnableNext();
  }

  setVarian(Datum data){
    edtVarian.text = data.name.toString();
    selectedVarian.value = data;
    setEnableNext();
  }

  setJarak(Datum data){
    edtJarak.text = data.name.toString();
    selectedJarak.value = data;
    setEnableNext();
  }

  setBahanBakar(Datum data){
    edtBahanBakar.text = data.name.toString();
    selectedBahanBakar.value = data;
    setEnableNext();
  }

  setTransmisi(Datum data){
    edtTransmisi.text = data.name.toString();
    selectedTransmisi.value = data;
    setEnableNext();
  }

  setWarna(Datum data){
    edtWarna.text = data.name.toString();
    selectedWarna.value = data;
    setEnableNext();
  }

  setProvinsi(Datum data){
    edtKec.text = '';
    edtKota.text = '';
    edtProv.text = data.name.toString();
    selectedProv.value = data;
    selectedKota.value = Datum();
    selectedKec.value = Datum();
    modelKota.value = ModelWilayah();
    modelKec.value = ModelWilayah();
    getNewKota(id: data.id!);
    setEnableNext();
  }

  setKota(Datum data){
    edtKec.text = '';
    edtKota.text = data.name.toString();
    selectedKota.value = data;
    selectedKec.value = Datum();
    modelKec.value = ModelWilayah();
    getNewKec(id: data.id!);
    setEnableNext();
  }

  setKecamatan(Datum data){
    edtKec.text = data.name.toString();
    selectedKec.value = data;
    setEnableNext();
  }

  setEnableNext(){
    if(edtKondisi.text != '' &&
    edtMerk.text != '' &&
    edtModel.text != '' &&
    edtVarian.text != '' &&
    edtVarian.text != '' &&
    edtJarak.text != '' &&
    edtBahanBakar.text != '' &&
    edtTransmisi.text != '' &&
    edtWarna.text != '' &&
    edtProv.text != '' &&
    edtKota.text != '' &&
    edtKec.text != '' &&
    edtHarga.text != ''){
      enableNext.value = true;
    }else{
      enableNext.value = false;
    }
  }

  getNewKondisi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kondisiLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.getKondisi.toString()}';
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
    String strUrl = '${ApiUrl.domain.toString()}/api/lead/list/merek';
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
    getNewBahanBakar();
  }

  getNewModel({required int idMerek}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    modelLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.modelMobil.toString()}${idMerek.toString()}';
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
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.getVariant.toString()}${idModel.toString()}';
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

  getNewBahanBakar() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    bahanBakarLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.bahanBakar.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      bahanBakarLoad.value = false;
      modelBahanBakar.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      bahanBakarLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNewJarakTempuh();
  }

  getNewJarakTempuh() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    jarakLoad.value = true;
    var url = Uri.parse(ApiUrl.domain.toString() + ApiUrl.jarakTempuh.toString());
    var res = await http.get(url, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      jarakLoad.value = false;
      modelJarak.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      jarakLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNewTransmisi();
  }

  getNewTransmisi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    transmisiLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.transmisi.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      transmisiLoad.value = false;
      modelTransmisi.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      transmisiLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNewWarna();
  }

  getNewWarna() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    warnaLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.warna.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      warnaLoad.value = false;
      modelWarna.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      warnaLoad.value = false;
      print(jsonEncode(res.body));
    }
    getNewProv();
  }

  getNewTujuanPenggunaan() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    tujuanLoad.value = true;
    String strUrl = '${ApiUrl.domain.toString()}/api/lead/list/tujuan_penggunaan';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      tujuanLoad.value = false;
      modelTujuan.value = modelProvinsiFromMap(res.body);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      tujuanLoad.value = false;
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

  bool loadProv = false;
  bool loadKota = false;
  bool loadKec = false;
  bool loadKondisi = false;
  bool loadMerek = false;
  bool loadModel = false;
  bool loadVarian = false;
  bool loadJarakTempuh = false;
  bool loadBahanBakar = false;
  bool loadTransmisi = false;
  bool loadWarna = false;
  bool loadTujuanPenggunaan = false;

  ModelWilayah? prov;
  ModelWilayah? kota;
  ModelWilayah? kec;
  ModelWilayah? kondisi;
  ModelWilayah? merek;
  ModelWilayah? model;
  ModelWilayah? varian;
  ModelWilayah? jarakTempuh;
  ModelWilayah? bahanBakar;
  ModelWilayah? transmisi;
  ModelWilayah? warna;
  ModelWilayah? tujuanPenggunaan;


  getTujuanPenggunaan() async {
    loadTujuanPenggunaan = true;
    SaveRoot.callSaveRoot().then((value) async {
      String strUrl = '${ApiUrl.domain.toString()}/api/lead/list/tujuan_penggunaan';
      var res = await http.get(Uri.parse(strUrl.trim()),  headers: {'Authorization': 'Bearer ' + value.token.toString()});
      if (res.statusCode == 200) {
        loadTujuanPenggunaan = false;
        tujuanPenggunaan = modelProvinsiFromMap(res.body);

        log(res.body);
        update();
      } else {
        loadTujuanPenggunaan = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

  clearVariantModel() {
    model = null;
    varian = null;
    // update();
  }

  clearVarian() {
    varian = null;
    // update();
  }

  clearKotKec() {
    kec = null;
    kota = null;
    update();
  }

  clearKec() {
    kec = null;
  }

  getProv() async {
    SaveRoot.callSaveRoot().then((value) async {
      loadProv = true;
      var url = '${ApiUrl.domain.toString()}${ApiUrl.prov.toString()}';
      var res = await http.get(Uri.parse(url.trim()), headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        loadProv = false;
        prov = modelProvinsiFromMap(res.body);

        log(res.body);
        update();
      } else {
        loadProv = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

  getKota({required int id}) async {
    SaveRoot.callSaveRoot().then((value) async {
      loadKota = true;

      var url = '${ApiUrl.domain.toString()}${ ApiUrl.kotaKab.toString()}${id.toString()}';
      var res = await http.get(Uri.parse(url.trim()), headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        loadKota = false;
        kota = modelProvinsiFromMap(res.body);
        log(res.body);
        update();
      } else {
        loadKota = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

  getKec({required int id}) async {
    SaveRoot.callSaveRoot().then((value) async {
      loadKec = true;

      var url = '${ApiUrl.domain.toString()}${ApiUrl.kec.toString()}${id.toString()}';
      var res = await http.get(Uri.parse(url.trim()), headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        loadKec = false;
        kec = modelProvinsiFromMap(res.body);
        log(res.body);
        update();
      } else {
        loadKec = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

  getKondisi() async {
    loadKondisi = true;
    SaveRoot.callSaveRoot().then((value) async {
      String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.getKondisi.toString()}';
      var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString(),});

      if (res.statusCode == 200) {
        loadKondisi = false;
        kondisi = modelProvinsiFromMap(res.body);
        log(res.body);
        update();
      } else {
        loadKondisi = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

  getMerek() async {
    loadMerek = true;
    SaveRoot.callSaveRoot().then((value) async {
      String strUrl = '${ApiUrl.domain.toString()}/api/lead/list/merek';
      var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
      if (res.statusCode == 200) {
        loadMerek = false;
        merek = modelProvinsiFromMap(res.body);
        log(res.body);
        update();
      } else {
        loadMerek = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }

/////main id
  getModel({required int idMerek}) async {
    loadModel = true;

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.modelMobil.toString()}${idMerek.toString()}';
    var res = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer ' + value.token.toString()});

    if (res.statusCode == 200) {
      loadModel = false;
      model = modelProvinsiFromMap(res.body);
      log(res.body);
      update();
    } else {
      loadModel = false;
      log(res.body);
      update();
    }

    update();
  }

  getVarain({required int idModel}) async {
    loadVarian = true;

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.getVariant.toString()}${idModel.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});

    if (res.statusCode == 200) {
      loadVarian = false;
      varian = modelProvinsiFromMap(res.body);
      log(res.body);
      update();
    } else {
      loadVarian = false;
      log(res.body);
      update();
    }

    update();
  }

/////end main id
  getJarakTempuh() async {
    loadJarakTempuh = true;
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = Uri.parse(ApiUrl.domain.toString() + ApiUrl.jarakTempuh.toString());
    var res = await http.get(url, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      loadJarakTempuh = false;
      jarakTempuh = modelProvinsiFromMap(res.body);
      log(res.body);
      update();
    } else {
      loadJarakTempuh = false;
      log(res.body);
      update();
    }

    update();
  }

  getBahanBakar() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    loadBahanBakar = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.bahanBakar.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      loadBahanBakar = false;
      bahanBakar = modelProvinsiFromMap(res.body);
      log(res.body);
      update();
    } else {
      loadBahanBakar = false;
      log(res.body);
      update();
    }

    update();
  }

  getTransmisi() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    loadTransmisi = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.transmisi.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      loadTransmisi = false;
      transmisi = modelProvinsiFromMap(res.body);
      log(res.body);
      update();
    } else {
      loadTransmisi = false;
      log(res.body);
      update();
    }

    update();
  }

  getWarna() async {
    SaveRoot.callSaveRoot().then((value) async {
      loadWarna = true;
      String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.warna.toString()}';
      var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
      if (res.statusCode == 200) {
        loadWarna = false;
        warna = modelProvinsiFromMap(res.body);
        log(res.body);
        update();
      } else {
        loadWarna = false;
        log(res.body);
        update();
      }
      update();
    });

    update();
  }
}
