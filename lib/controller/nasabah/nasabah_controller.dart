
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/maskeddd.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/models/model_detail_nasabah.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';
import 'package:yodacentral/utils/utils.dart';

class NasabahController extends GetxController{

  RxInt indexPage = 0.obs;

  RxList<String> jenisKelamin = <String>[].obs;
  RxList<String> pendidikan = <String>[].obs;
  RxList<String> statusPerkawinan = <String>[].obs;

  Rx<ModelWilayah> modelProv = ModelWilayah().obs;
  Rx<ModelWilayah> modelKota = ModelWilayah().obs;
  Rx<ModelWilayah> modelKec = ModelWilayah().obs;

  Rx<Datum> selectedProv = Datum().obs;
  Rx<Datum> selectedKota = Datum().obs;
  Rx<Datum> selectedKec = Datum().obs;

  RxBool provLoad = false.obs;
  RxBool kotaLoad = false.obs;
  RxBool kecLoad = false.obs;
  RxBool isMerried = false.obs;

  RxBool enableButton = false.obs;
  RxBool enableButtonInstitusi = false.obs;
  RxBool enableButtonFoto = false.obs;
  RxBool identityComplete = false.obs;
  RxBool institusiComplete = false.obs;
  RxBool fotoNasabah = false.obs;
  RxBool allDOkNasabahComplete = false.obs;

  //info data tambahan
  RxBool tglTerbitKTPActive = false.obs;
  RxBool tlpRumahActive = false.obs;
  RxBool namaPenjaminActive = false.obs;
  RxBool ktpPenjaminActive = false.obs;
  RxBool hubunganPenjaminActive = false.obs;

  Rx<String> strGender = ''.obs;
  Rx<String> strEducation = ''.obs;
  Rx<String> strMarital = ''.obs;
  Rx<String> strPathDoc = ''.obs;

  Rx<ModelDetailNasabah> dataNasabah = ModelDetailNasabah().obs;

  TextEditingController edtNamaLengkap = TextEditingController();
  TextEditingController edtGender = TextEditingController();
  TextEditingController edtNoKTP = TextEditingController();
  TextEditingController edtTglLahir = TextEditingController();
  TextEditingController edtTglTerbitKTP = TextEditingController();
  TextEditingController edtTmptLahir = TextEditingController();
  TextEditingController edtEducation = TextEditingController();
  TextEditingController edtNamaIbu = TextEditingController();
  TextEditingController edtNoHP = MaskedTextController(mask: '000 0000 00000');
  TextEditingController edtNoNPWP = TextEditingController();
  TextEditingController edtMarital = TextEditingController();
  TextEditingController edtCatatan = TextEditingController();
  TextEditingController edtNamaPasangan = TextEditingController();
  TextEditingController edtKTPPasangan = TextEditingController();
  TextEditingController edtTglLahirPasangan = TextEditingController();
  TextEditingController edtNoHPPasangan = MaskedTextController(mask: '000 0000 00000');
  TextEditingController edtAlamat = TextEditingController();
  TextEditingController edtProvinsi = TextEditingController();
  TextEditingController edtKota = TextEditingController();
  TextEditingController edtKecamatan = TextEditingController();
  TextEditingController edtKelurahan = TextEditingController();
  TextEditingController edtKodePOS = TextEditingController();
  TextEditingController edtNoTlpRUmah = MaskedTextController(mask: '000 0000 00000');
  TextEditingController edtRT = TextEditingController();
  TextEditingController edtRW = TextEditingController();
  TextEditingController edtDomisili = TextEditingController();
  TextEditingController edtNamaPenjamin = TextEditingController();
  TextEditingController edtKTPPenjamin = TextEditingController();
  TextEditingController edtHubunganPenjamin = TextEditingController();

  //focusnode
  FocusNode focusName = FocusNode();
  FocusNode focusGender = FocusNode();
  FocusNode focusNoKTP = FocusNode();
  FocusNode focusTglLahir = FocusNode();
  FocusNode focusTglTerbitKTP = FocusNode();
  FocusNode focusTmptLahir = FocusNode();
  FocusNode focusEducation = FocusNode();
  FocusNode focusNamaIbu= FocusNode();
  FocusNode focustNoHP = FocusNode();
  FocusNode focusNoNPWP = FocusNode();
  FocusNode focusMarital = FocusNode();
  FocusNode focusCatatan = FocusNode();
  FocusNode focusNamaPasangan = FocusNode();
  FocusNode focusKTPPasangan = FocusNode();
  FocusNode focusTglLahirPasangan = FocusNode();
  FocusNode focusNoHPPasangan = FocusNode();
  FocusNode focusAlamat = FocusNode();
  FocusNode focusProvinsi = FocusNode();
  FocusNode focusKota = FocusNode();
  FocusNode focusKecamatan = FocusNode();
  FocusNode focusKelurahan = FocusNode();
  FocusNode focusKodePOS = FocusNode();
  FocusNode focusNoTlpRUmah = FocusNode();
  FocusNode focusRT = FocusNode();
  FocusNode focusRW = FocusNode();
  FocusNode focusDomisili = FocusNode();
  FocusNode focusNamaPenjamin = FocusNode();
  FocusNode focusKTPPenjamin = FocusNode();
  FocusNode focusHubunganPenjamin = FocusNode();

  // Pekerjaan
  FocusNode focusPekerjaan = FocusNode();
  FocusNode focusNamaInst = FocusNode();
  FocusNode focusJabatan = FocusNode();
  FocusNode focusLama = FocusNode();
  FocusNode focusNoTlpInst = FocusNode();
  FocusNode focusAlamatInst = FocusNode();
  FocusNode focusNoteInst = FocusNode();

  RxBool focusedName = false.obs;
  RxBool focusedGender = false.obs;
  RxBool focusedNoKTP = false.obs;
  RxBool focusedTglLahir = false.obs;
  RxBool focusedTglTerbitKTP = false.obs;
  RxBool focusedTmptLahir = false.obs;
  RxBool focusedEducation = false.obs;
  RxBool focusedNamaIbu= false.obs;
  RxBool focusedNoHP = false.obs;
  RxBool focusedNoNPWP = false.obs;
  RxBool focusedMarital = false.obs;
  RxBool focusedCatatan = false.obs;
  RxBool focusedNamaPasangan =false.obs;
  RxBool focusedKTPPasangan = false.obs;
  RxBool focusedTglLahirPasangan = false.obs;
  RxBool focusedNoHPPasangan = false.obs;
  RxBool focusedAlamat = false.obs;
  RxBool focusedProvinsi = false.obs;
  RxBool focusedKota = false.obs;
  RxBool focusedKecamatan = false.obs;
  RxBool focusedKelurahan = false.obs;
  RxBool focusedKodePOS = false.obs;
  RxBool focusedNoTlpRUmah = false.obs;
  RxBool focusedRT = false.obs;
  RxBool focusedRW = false.obs;
  RxBool focusDedomisili = false.obs;
  RxBool focusedNamaPenjamin = false.obs;
  RxBool focusedKTPPenjamin = false.obs;
  RxBool focusedHubunganPenjamin = false.obs;

  //pekerjaan
  RxBool focusedPekerjaan = false.obs;
  RxBool focusedNamaInst = false.obs;
  RxBool focusedJabatan = false.obs;
  RxBool focusedLama = false.obs;
  RxBool focusedNoTlpInst = false.obs;
  RxBool focusedAlamatInst = false.obs;
  RxBool focusedNoteInst = false.obs;

  initFocusPekerjaan(){
    focusPekerjaan.addListener(() {
      changeFocusIdentitas('kerja', focusPekerjaan.hasFocus);
    });
    focusNamaInst.addListener(() {
      changeFocusIdentitas('namaInst', focusNamaInst.hasFocus);
    });
    focusJabatan.addListener(() {
      changeFocusIdentitas('jabatan', focusJabatan.hasFocus);
    });
    focusLama.addListener(() {
      changeFocusIdentitas('lama', focusLama.hasFocus);
    });
    focusNoTlpInst.addListener(() {
      changeFocusIdentitas('noTlpInst', focusNoTlpInst.hasFocus);
    });
    focusAlamatInst.addListener(() {
      changeFocusIdentitas('alamatInst', focusAlamatInst.hasFocus);
    });
    focusNoteInst.addListener(() {
      changeFocusIdentitas('noteInst', focusNoteInst.hasFocus);
    });
  }

  initFocusIdentitas(){
    focusName.addListener(() {
      changeFocusIdentitas('nama', focusName.hasFocus);
    });
    focusGender.addListener(() {
      changeFocusIdentitas('gender', focusGender.hasFocus);
    });
    focusNoKTP.addListener(() {
      changeFocusIdentitas('noKTP', focusNoKTP.hasFocus);
    });
    focusTglLahir.addListener(() {
      changeFocusIdentitas('tlgLahir', focusTglLahir.hasFocus);
    });
    focusTglTerbitKTP.addListener(() {
      changeFocusIdentitas('tglTerbit', focusTglTerbitKTP.hasFocus);
    });
    focusTmptLahir.addListener(() {
      changeFocusIdentitas('tmptLahir', focusTmptLahir.hasFocus);
    });
    focusEducation.addListener(() {
      changeFocusIdentitas('edu', focusEducation.hasFocus);
    });
    focusNamaIbu.addListener(() {
      changeFocusIdentitas('namaIbu', focusNamaIbu.hasFocus);
    });
    focustNoHP.addListener(() {
      changeFocusIdentitas('noHP', focustNoHP.hasFocus);
    });
    focusNoNPWP.addListener(() {
      changeFocusIdentitas('noNPWP', focusNoNPWP.hasFocus);
    });
    focusMarital.addListener(() {
      changeFocusIdentitas('marital', focusMarital.hasFocus);
    });
    focusCatatan.addListener(() {
      changeFocusIdentitas('catatan', focusCatatan.hasFocus);
    });
    focusNamaPasangan.addListener(() {
      changeFocusIdentitas('namaPasang', focusNamaPasangan.hasFocus);
    });
    focusKTPPasangan.addListener(() {
      changeFocusIdentitas('noKTPPasang', focusKTPPasangan.hasFocus);
    });
    focusTglLahirPasangan.addListener(() {
      changeFocusIdentitas('tglLahirPasang', focusTglLahirPasangan.hasFocus);
    });
    focusNoHPPasangan.addListener(() {
      changeFocusIdentitas('noHPPasang', focusNoHPPasangan.hasFocus);
    });
    focusAlamat.addListener(() {
      changeFocusIdentitas('alamat', focusAlamat.hasFocus);
    });
    focusProvinsi.addListener(() {
      changeFocusIdentitas('provinsi', focusProvinsi.hasFocus);
    });
    focusKota.addListener(() {
      changeFocusIdentitas('kota', focusKota.hasFocus);
    });
    focusKecamatan.addListener(() {
      changeFocusIdentitas('camat', focusKecamatan.hasFocus);
    });
    focusKelurahan.addListener(() {
      changeFocusIdentitas('lurah', focusKelurahan.hasFocus);
    });
    focusKodePOS.addListener(() {
      changeFocusIdentitas('pos', focusKodePOS.hasFocus);
    });
    focusNoTlpRUmah.addListener(() {
      changeFocusIdentitas('noTlpRumah', focusNoTlpRUmah.hasFocus);
    });
    focusRT.addListener(() {
      changeFocusIdentitas('rt', focusRT.hasFocus);
    });
    focusRW.addListener(() {
      changeFocusIdentitas('rw', focusRW.hasFocus);
    });
    focusDomisili.addListener(() {
      changeFocusIdentitas('catatanDomisili', focusDomisili.hasFocus);
    });
    focusNamaPenjamin.addListener(() {
      changeFocusIdentitas('namaJamin', focusNamaPenjamin.hasFocus);
    });
    focusKTPPenjamin.addListener(() {
      changeFocusIdentitas('noKTPJamin', focusKTPPenjamin.hasFocus);
    });
    focusHubunganPenjamin.addListener(() {
      changeFocusIdentitas('hubJamin', focusHubunganPenjamin.hasFocus);
    });

  }

  changeFocusIdentitas(String type, bool val){
    switch(type){
      case 'nama':
        focusedName.value = val;
        return;
      case 'gender':
        focusedGender.value = val;
        return;
      case 'noKTP':
        focusedNoKTP.value = val;
        return;
      case 'tlgLahir':
        focusedTglLahir.value = val;
        return;
      case 'tglTerbit':
        focusedTglTerbitKTP.value = val;
        return;
      case 'tmptLahir':
        focusedTmptLahir.value = val;
        return;
      case 'edu':
        focusedEducation.value = val;
        return;
      case 'namaIbu':
        focusedNamaIbu.value = val;
        return;
      case 'noHP':
        focusedNoHP.value = val;
        return;
      case 'noNPWP':
        focusedNoNPWP.value = val;
        return;
      case 'marital':
        focusedMarital.value = val;
        return;
      case 'catatan':
        focusedCatatan.value = val;
        return;
      case 'namaPasang':
        focusedNamaPasangan.value = val;
        return;
      case 'noKTPPasang':
        focusedKTPPasangan.value = val;
        return;
      case 'tglLahirPasang':
        focusedTglLahirPasangan.value = val;
        return;
      case 'alamat':
        focusedAlamat.value = val;
        return;
      case 'provinsi':
        focusedProvinsi.value = val;
        return;
      case 'kota':
        focusedKota.value = val;
        return;
      case 'camat':
        focusedKecamatan.value = val;
        return;
      case 'lurah':
        focusedKelurahan.value = val;
        return;
      case 'pos':
        focusedKodePOS.value = val;
        return;
      case 'noTlpRumah':
        focusedNoTlpRUmah.value = val;
        return;
      case 'rt':
        focusedRT.value = val;
        return;
      case 'rw':
        focusedRW.value = val;
        return;
      case 'catatanDomisili':
        focusDedomisili.value = val;
        return;
      case 'namaJamin':
        focusedNamaPenjamin.value = val;
        return;
      case 'noKTPJamin':
        focusedKTPPenjamin.value = val;
        return;
      case 'hubJamin':
        focusedHubunganPenjamin.value = val;
        return;
        //pekerjaan
      case 'kerja':
        focusedPekerjaan.value = val;
        return;
      case 'namaInst':
        focusedNamaInst.value = val;
        return;
      case 'jabatan':
        focusedJabatan.value = val;
        return;
      case 'lama':
        focusedLama.value = val;
        return;
      case 'noTlpInst':
        focusedNoTlpInst.value = val;
        return;
      case 'alamatInst':
        focusedAlamatInst.value = val;
        return;
      case 'noteInst':
        focusedNoteInst.value = val;
        return;
    }
  }


  TextEditingController edtKerjaan = TextEditingController();
  TextEditingController edtNamaInstitusi = TextEditingController();
  TextEditingController edtJabatan = TextEditingController();
  TextEditingController edtLamaKerja = TextEditingController();
  TextEditingController edtTlpInstitusi = MaskedTextController(mask: '000 0000 00000');
  TextEditingController edtAlamatInstitusi = TextEditingController();
  TextEditingController edtCatatanKerja = TextEditingController();

  var npwpFormat = new MaskTextInputFormatter(
      // mask: '+# (###) ###-##-##',
      mask: '##.###.###.#-###.###',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  bool _ktpActive = false;
  bool get ktpActive => _ktpActive;
  bool _tlpRUmah = false;
  bool get tlpRUmah => _tlpRUmah;
  bool _namaPenjamin = false;
  bool get namaPenjamin => _namaPenjamin;
  bool _ktpPenjamin = false;
  bool get ktpPenjamin => _ktpPenjamin;
  bool _hubPenjamin = false;
  bool get hubPenjamin => _hubPenjamin;

  List<String> _dataInfoHide = [];
  List<String> get dataInfoHide => _dataInfoHide;

  changeAddInfo(String label, bool val){
    switch(label){
      case 'Tanggal Terbit KTP':
        tglTerbitKTPActive.value = !val;
        _ktpActive = !val;
        if(!tglTerbitKTPActive.value){
          edtTglTerbitKTP.text = '';
          _dataInfoHide.add('tglKtp');
        }
        break;
      case 'Nomor Telepon Rumah':
        tlpRumahActive.value = !val;
        _tlpRUmah = !val;
        if(!tlpRumahActive.value){
          edtNoTlpRUmah.text = '';
          _dataInfoHide.add('tlpRumah');
        }
        break;
      case 'Nama Penjamin':
        namaPenjaminActive.value = !val;
        _namaPenjamin = !val;
        if(!namaPenjaminActive.value){
          edtNamaPenjamin.text = '';
          _dataInfoHide.add('namaJamin');
        }
        break;
      case 'Nomor KTP Penjamin':
        ktpPenjaminActive.value = !val;
        _ktpPenjamin = !val;
        if(!ktpPenjaminActive.value){
          edtKTPPenjamin.text = '';
          _dataInfoHide.add('ktpJamin');
        }
        break;
      case 'Hubungan dengan pemohon':
        hubunganPenjaminActive.value = !val;
        _hubPenjamin = !val;
        if(!hubunganPenjaminActive.value){
          edtHubunganPenjamin.text = '';
          _dataInfoHide.add('hubJamin');
        }
        break;
    }
  }

  changePage(int val){
    indexPage.value = val;
  }

  setEnableButtonFoto(String path){
    if(path != ''){
      strPathDoc.value = path;
      enableButtonFoto.value = true;
    }else{
      enableButtonFoto.value = false;
    }
    if(enableButtonFoto.value){
      enableButton.value = true;
      enableButtonInstitusi.value = true;
    }
  }

  setEnableButtonKerjaan(){
    if(edtKerjaan.text != '' ||
        edtNamaInstitusi.text != '' ||
        edtJabatan.text != '' ||
        edtLamaKerja.text != '' ||
        edtTlpInstitusi.text != '' ||
        edtAlamatInstitusi.text != '' ||
        edtCatatanKerja.text != '') {
      enableButtonInstitusi.value = true;
      _allFieldKerjaanEmpty = false;
    }else{
      enableButtonInstitusi.value = false;
      _allFieldKerjaanEmpty = true;
    }
    if (edtTlpInstitusi.text != '' && (edtTlpInstitusi.text.length < 10 || edtTlpInstitusi.text.length > 15)) {
      enableButtonInstitusi.value = false;
    }

    if(enableButtonInstitusi.value){
      enableButton.value = true;
      enableButtonFoto.value = true;
    }
  }


  setEnableButton(){
    if(edtMarital.text.toString() == 'Menikah'){
      if(edtNamaLengkap.text != '' ||
          edtGender.text != '' ||
          edtNoKTP.text != '' ||
          edtTglLahir.text != '' ||
          edtTmptLahir.text != '' ||
          edtEducation.text != '' ||
          edtNamaIbu.text != '' ||
          edtNoHP.text != '' ||
          edtNoNPWP.text != '' ||
          edtCatatan.text != '' ||
          edtNamaPasangan.text != '' ||
          edtKTPPasangan.text != '' ||
          edtTglLahirPasangan.text != '' ||
          edtNoHPPasangan.text != '' ||
          edtAlamat.text != '' ||
          edtProvinsi.text != '' ||
          edtKota.text != '' ||
          edtKecamatan.text != '' ||
          edtKelurahan.text != '' ||
          edtKodePOS.text != '' ||
          edtRT.text != '' ||
          edtRW.text != '' ||
          edtDomisili.text != ''
      ){
        enableButton.value = true;
        _allFieldIdentityEmpty = false;
      }else{
        enableButton.value = false;
        _allFieldIdentityEmpty = true;
      }
    }else{
      if(edtNamaLengkap.text != '' ||
          edtGender.text != '' ||
          edtNoKTP.text != '' ||
          edtTglLahir.text != '' ||
          edtTmptLahir.text != '' ||
          edtEducation.text != '' ||
          edtNamaIbu.text != '' ||
          edtNoHP.text != '' ||
          edtNoNPWP.text != '' ||
          edtCatatan.text != '' ||
          edtAlamat.text != '' ||
          edtProvinsi.text != '' ||
          edtKota.text != '' ||
          edtKecamatan.text != '' ||
          edtKelurahan.text != '' ||
          edtKodePOS.text != '' ||
          edtRT.text != '' ||
          edtRW.text != '' ||
          edtDomisili.text != ''
      ){
        enableButton.value = true;
        _allFieldIdentityEmpty = false;
      }else{
        enableButton.value = false;
        _allFieldIdentityEmpty = true;
      }
    }

    if(edtNoKTP.text != '' && edtNoKTP.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    if(edtKTPPasangan.text != '' && edtKTPPasangan.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    if(edtKTPPenjamin.text != '' && edtKTPPenjamin.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    if(edtNamaLengkap.text != '' && edtNamaLengkap.text.removeAllWhitespace.length > 254){
      enableButton.value = false;
    }
    if(edtNamaPenjamin.text != '' && edtNamaPenjamin.text.removeAllWhitespace.length > 254){
      enableButton.value = false;
    }
    if(edtNamaPasangan.text != '' && edtNamaPasangan.text.removeAllWhitespace.length > 254){
      enableButton.value = false;
    }
    if(edtNamaIbu.text != '' && edtNamaIbu.text.removeAllWhitespace.length > 254){
      enableButton.value = false;
    }
    if(edtNoHP.text != '' && (edtNoHP.text.removeAllWhitespace.length < 10 || edtNoHP.text.removeAllWhitespace.length > 15)){
      enableButton.value = false;
    }
    if(edtNoHPPasangan.text != '' && (edtNoHPPasangan.text.removeAllWhitespace.length < 10 || edtNoHPPasangan.text.removeAllWhitespace.length > 15)){
      enableButton.value = false;
    }
    if(edtNoTlpRUmah.text != '' && (edtNoTlpRUmah.text.removeAllWhitespace.length < 8 || edtNoTlpRUmah.text.removeAllWhitespace.length > 15)){
      enableButton.value = false;
    }
    if(edtNoNPWP.text != '' && edtNoNPWP.text.length < 20){
      enableButton.value = false;
    }

    if(enableButton.value){
      enableButtonInstitusi.value = true;
      enableButtonFoto.value = true;
    }
    // if(formIdentityValid.value){
    //   enableButton.value = true;
    // }else{
    //   enableButton.value = false;
    // }
  }


  setEnableButtonIdentitas(){
    enableButton.value = true;
    if(edtNoKTP.text != '' && edtNoKTP.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    if(edtKTPPasangan.text != '' && edtKTPPasangan.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    if(edtKTPPenjamin.text != '' && edtKTPPenjamin.text.removeAllWhitespace.length != 16){
      enableButton.value = false;
    }
    // if(edtMarital.text.toString() == 'Menikah'){
    //   if(edtNamaLengkap.text != '' &&
    //       edtGender.text != '' &&
    //       edtNoKTP.text != '' &&
    //       edtTglLahir.text != '' &&
    //       edtTmptLahir.text != '' &&
    //       edtEducation.text != '' &&
    //       edtNamaIbu.text != '' &&
    //       edtNoHP.text != '' &&
    //       edtNoNPWP.text != '' &&
    //       edtNamaPasangan.text != '' &&
    //       edtKTPPasangan.text != '' &&
    //       edtTglLahirPasangan.text != '' &&
    //       edtNoHPPasangan.text != ''
    //   ){
    //     enableButton.value = true;
    //   }else{
    //     enableButton.value = false;
    //   }
    // }else{
    //   if(edtNamaLengkap.text != '' &&
    //       edtGender.text != '' &&
    //       edtNoKTP.text != '' &&
    //       edtTglLahir.text != '' &&
    //       edtTmptLahir.text != '' &&
    //       edtEducation.text != '' &&
    //       edtNamaIbu.text != '' &&
    //       edtNoHP.text != '' &&
    //       edtNoNPWP.text != ''
    //   ){
    //     enableButton.value = true;
    //   }else{
    //     enableButton.value = false;
    //   }
    // }
  }

  setEnableButtonDomisili(){
    enableButton.value = true;
    if(edtNoTlpRUmah.text != '' && (edtNoTlpRUmah.text.removeAllWhitespace.length < 8 || edtNoTlpRUmah.text.removeAllWhitespace.length > 15)){
      enableButton.value = false;
    }
    // if(edtAlamat.text != '' &&
    //     edtProvinsi.text != '' &&
    //     edtKota.text != '' &&
    //     edtKecamatan.text != '' &&
    //     edtKelurahan.text != '' &&
    //     edtKodePOS.text != '' &&
    //     edtRT.text != '' &&
    //     edtRW.text != ''){
    //   enableButton.value = true;
    // }else{
    //   enableButton.value = false;
    // }
  }

  saveInstitusiNasabah({Function? onSuccess}){
    String institusi = edtKerjaan.text.toString()+'|'+
        edtNamaInstitusi.text.toString()+'|'+
        edtJabatan.text.toString()+'|'+
        edtLamaKerja.text.toString()+'|'+
        edtTlpInstitusi.text.toString()+'|'+
        edtAlamatInstitusi.text.toString()+'|'+
        edtCatatanKerja.text.toString();

    Utils.saveNasabahInstitusi(institusi);
    onSuccess!();
  }

  saveIdentitasNasabah({Function? onSuccess}){
    String identity = edtNamaLengkap.text.toString()+'|'+
        edtGender.text.toString()+'|'+
        edtNoKTP.text.toString()+'|'+
        edtTglLahir.text.toString()+'|'+
        edtTmptLahir.text.toString()+'|'+
        edtEducation.text.toString()+'|'+
        edtNamaIbu.text.toString()+'|'+
        edtNoHP.text.toString()+'|'+
        edtNoNPWP.text.toString()+'|'+
        edtMarital.text.toString()+'|'+
        edtCatatan.text.toString()+'|'+
        edtNamaPasangan.text.toString()+'|'+
        edtKTPPasangan.text.toString()+'|'+
        edtTglLahirPasangan.text.toString()+'|'+
        edtNoHPPasangan.text.toString()+'|'+
        edtAlamat.text.toString()+'|'+
        edtProvinsi.text.toString()+'|'+
        edtKota.text.toString()+'|'+
        edtKecamatan.text.toString()+'|'+
        edtKelurahan.text.toString()+'|'+
        edtKodePOS.text.toString()+'|'+
        edtRT.text.toString()+'|'+
        edtRW.text.toString()+'|'+
        edtDomisili.text.toString()+'|'+
        kecamatanID
    ;

    Utils.saveNasabahIdentitas(identity);
    onSuccess!();
  }

  saveFotoNasabah({Function? onSuccess, String? path}){
    Utils.saveFotoNasabah(path!);
    onSuccess!();
  }

  setField(String type, String val){
    switch(type){
      // case 'name':
      //   edtNamaLengkap.text = val;
      //   break;
      case 'gender':
        edtGender.text = val;
        break;
      case 'ktp':
        edtNoKTP.text = val;
        break;
      case 'birth_date':
        edtTglLahir.text = val;
        break;
      case 'birth_place':
        edtTmptLahir.text = val;
        break;
      case 'education':
        edtEducation.text = val;
        break;
      case 'moms':
        edtNamaIbu.text = val;
        break;
      case 'hp':
        edtNoHP.text = val;
        break;
      case 'npwp':
        edtNoNPWP.text = val;
        break;
      case 'marital':
        edtMarital.text = val;
        if(val.toLowerCase() == 'menikah'){
          isMerried.value = true;
        }else{
          isMerried.value = false;
          edtNamaPasangan.text = '';
          edtKTPPasangan.text = '';
          edtNoHPPasangan.text = '';
          edtTglLahirPasangan.text = '';
        }
        break;
      case 'notes':
        edtCatatan.text = val;
        break;
      case 'name_spouse':
        edtNamaPasangan.text = val;
        break;
      case 'ktp_spouse':
        edtKTPPasangan.text = val;
        break;
      case 'birth_date_spouse':
        edtTglLahirPasangan.text = val;
        break;
      case 'hp_spouse':
        edtNoHPPasangan.text = val;
        break;
      case 'address':
        edtAlamat.text = val;
        break;
      case 'prov':
        edtProvinsi.text = val;
        break;
      case 'kota':
        edtKota.text = val;
        break;
      case 'kec':
        edtKecamatan.text = val;
        break;
      case 'kel':
        edtKelurahan.text = val;
        break;
      case 'pos':
        edtKodePOS.text = val;
        break;
      case 'rt':
        edtRT.text = val;
        break;
      case 'rw':
        edtRW.text = val;
        break;
      case 'notes_domisili':
        edtDomisili.text = val;
        break;
    }
  }

  initFormNasabah() async{
    var data = await Utils.getNasabahIdentitas();
    if(data != ''){
      var strData = data.split('|');
      if(strData.length > 0){
        identityComplete.value = true;
      }else{
        identityComplete.value = false;
      }
    }else {
      identityComplete.value = false;
    }

    var dataInstitusi = await Utils.getNasabahInstitusi();
    if(dataInstitusi != ''){
      var strData = dataInstitusi.split('|');
      if(strData.length > 0){
        institusiComplete.value = true;
      }else{
        institusiComplete.value = false;
      }
    }else {
      institusiComplete.value = false;
    }

    var foto = await Utils.getFotoNasabah();
    if(foto != ''){
      fotoNasabah.value = true;
    }else {
      fotoNasabah.value = false;
    }

    if(identityComplete.value && institusiComplete.value && fotoNasabah.value){
      allDOkNasabahComplete.value = true;
    }else{
      allDOkNasabahComplete.value = false;
    }
  }

  init(){
    List<String> gender = ['Laki-laki', 'Perempuan'];
    jenisKelamin.value = gender;

    List<String> school = ['Sekolah Dasar', 'SLTP Sederajat', 'SLTA Sederajat', 'D3', 'D4', 'S1', 'S2', 'S3'];
    pendidikan.value = school;

    List<String> kawin = ['Lajang', 'Menikah', 'Cerai'];
    statusPerkawinan.value = kawin;

    setEnableButton();
    getNewProv();
  }

  setProvinsiEdit(Datum data){
    // edtKecamatan.text = '';
    _provinsiID =  data.id.toString();
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
    // edtKecamatan.text = '';
    _kotaID =  data.id.toString();
    edtKota.text = data.name.toString();
    selectedKota.value = data;
    selectedKec.value = Datum();
    modelKec.value = ModelWilayah();
    getNewKecEdit(id: data.id!, kecName: edtKecamatan.text.toString());
    // setEnableNext();
  }

  String _provinsiID = '';
  String get provinsiID => _provinsiID;
  setProvinsi(Datum data){
    edtKecamatan.text = '';
    edtKota.text = '';
    _provinsiID = data.id.toString();
    edtProvinsi.text = data.name.toString();
    selectedProv.value = data;
    selectedKota.value = Datum();
    selectedKec.value = Datum();
    modelKota.value = ModelWilayah();
    modelKec.value = ModelWilayah();
    getNewKota(id: data.id!);
    // setEnableNext();
  }

  changeProvinsi(){
    _provinsiID = '';
  }
  changeKota(){
    _kotaID = '';
  }
  changeKecamatan(){
    _kecamatanID = '';
  }

  String _kotaID = '';
  String get kotaID => _kotaID;
  setKota(Datum data){
    edtKecamatan.text = '';
    _kotaID = data.id.toString();
    edtKota.text = data.name.toString();
    selectedKota.value = data;
    selectedKec.value = Datum();
    modelKec.value = ModelWilayah();
    getNewKec(id: data.id!);
    // setEnableNext();
  }

  String _kecamatanID = '';
  String get kecamatanID => _kecamatanID;

  setKecamatan(Datum data){
    edtKecamatan.text = data.name.toString();
    _kecamatanID = data.id.toString();
    selectedKec.value = data;
    // setEnableNext();
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
        lastDate: dateTime //new DateTime(2100)
    ))!;
    if (picked != null){
      final dateFormat = DateFormat("yyyy-MM-dd");
      controller.text = dateFormat.format(picked);
    }
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

  getNewKecEdit({required int id, String? kecName}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    kecLoad.value = true;
    var url = '${ApiUrl.domain.toString()}${ApiUrl.kec.toString()}${id.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      kecLoad.value = false;
      modelKec.value = modelProvinsiFromMap(res.body);
      var dataKec = modelKec.value.data!.singleWhere((element) => element.name == kecName);
      setKecamatan(dataKec);
      var data = json.decode(res.body);
      print('RESPONSE ${data}');
    } else {
      kecLoad.value = false;
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

  changeDataNasabah(ModelDetailNasabah data){
    dataNasabah.value = data;
  }

  getDataNasabah({String? unit_id}) async{
    // Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${unit_id.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + data.token.toString()});
    // Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var data = ModelDetailNasabah.fromMap(dataJson);
      dataNasabah.value = data;
      print('RESPONSE ${json.encode(jsonDecode)}');
    }
  }
  getIdMarital(String val){
    switch(val){
      case 'Lajang':
        return 1;
      case 'Menikah':
        return 2;
      case 'Cerai':
        return 3;
      default:return '';
    }
  }

  postNasabah(BuildContext context, String id) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    var dataIdentitas = await Utils.getNasabahIdentitas();
    var dataInstitusi = await Utils.getNasabahInstitusi();
    var foto = await Utils.getFotoNasabah();

    var identitas = [];
    var institusi = [];
    if(dataIdentitas != ''){
      identitas = dataIdentitas.split('|');
    }
    if(dataInstitusi != ''){
      institusi = dataInstitusi.split('|');
    }

    // var nik = identitas[2].toString().trim().removeAllWhitespace;
    request.fields.addAll({'_method':'put'});
    request.fields.addAll({
      'name': identitas[0],
      'gender': identitas[1],
      'nik': identitas[2].toString().trim().removeAllWhitespace,
      'date_of_birth': identitas[3],
      'place_of_birth': identitas[4],
      'last_education': identitas[5],
      'mom_name': identitas[6],
      'telp': identitas[7].toString().trim(),
      'npwp_number': identitas[8],
      'status_marital_id': getIdMarital(identitas[9]).toString(),
      'note_identity': identitas[10],
      'partner_name': identitas[11],
      'partner_nik': identitas[12].toString().trim().removeAllWhitespace,
      'partner_date_of_birth': identitas[13],
      'partner_telp': identitas[14],
      'address': identitas[15],
      // 'provinsi_id': identitas[16],
      // 'kota_id': identitas[17],
      'kecamatan_id': identitas[24],//identitas[18],
      'kelurahan': identitas[19],
      'pos_code': identitas[20],
      'rt': identitas[21],
      'rw': identitas[22],
      'note_domisili': identitas[23],

      'profession_status': institusi[0],
      'office_name': institusi[1],
      'position': institusi[2],
      'length_of_work': institusi[3],
      'office_telp': institusi[4],
      'office_address': institusi[5],
      'note_profession': institusi[6],
      'photo_document[0]': foto,

    });

    print(jsonEncode(request.fields));

    request.files.add(await http.MultipartFile.fromPath(
        'photo_document[0]', foto));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      print(await response.stream.bytesToString());
      for (var i = 0; i < 5; i++) {
        Get.back();
      }

      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Data Nasabah Berhasil dikirim",
          onTap: () {
            Get.back();
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    } else {
      // log(await response.stream.bytesToString());
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      // log(response.statusCode.toString());
      // log(response.reasonPhrase.toString());
      // log(await response.stream.bytesToString());
      //
      // update();
    }
  }

  String formatPattern(String digits) {
    StringBuffer buffer = StringBuffer();
    int offset = 0;
    int count = min(4, digits.length);
    final length = digits.length;
    for (; count <= length; count += min(4, max(1, length - count))) {
      buffer.write(digits.substring(offset, count));
      if (count < length) {
        buffer.write(' ');
      }
      offset = count;
    }
    return buffer.toString();
  }

  initEditIdentitas(ModelDetailNasabah data){
    //data diri
    edtNamaLengkap.text = Utils.clearTextfield(data.data!.identitas!.namaLengkapSesuaiKtp!);
    edtGender.text = Utils.clearTextfield(data.data!.identitas!.jenisKelamin!);// 16 or 15 digit
    edtNoKTP.text = data.data!.identitas!.noKtp!.length > 2 ? data.data!.identitas!.noKtp! : Utils.clearTextfield(data.data!.identitas!.noKtp!);
    edtTglLahir.text = data.data!.identitas!.tanggalLahirDdMmYyyy != null ? DateFormat('yyyy-MM-dd').format(data.data!.identitas!.tanggalLahirDdMmYyyy!):'';
    edtTmptLahir.text = Utils.clearTextfield(data.data!.identitas!.tempatLahir!);
    edtEducation.text = Utils.clearTextfield(data.data!.identitas!.gelarNasabah!);
    edtNamaIbu.text = Utils.clearTextfield(data.data!.identitas!.namaGadisIbuKandung!);
    edtNoHP.text = Utils.clearTextfield(data.data!.identitas!.nomorTelepon!);
    edtNoNPWP.text = Utils.clearTextfield(data.data!.identitas!.noNpwp!);
    edtMarital.text = Utils.clearTextfield(data.data!.identitas!.statusPernikahan!);
    edtCatatan.text = Utils.clearTextfield(data.data!.identitas!.catatan!);
    if( Utils.clearTextfield(data.data!.identitas!.tglTerbitKTP!) != ''){
      tglTerbitKTPActive.value = true;
    }
    edtTglTerbitKTP.text = Utils.clearTextfield(data.data!.identitas!.tglTerbitKTP!);
    if(data.data!.identitas!.tglTerbitKTP != '0'){
      _ktpActive = true;
    };

    //pasangan
    if(data.data!.pasangan != null){
      edtNamaPasangan.text =  Utils.clearTextfield(data.data!.pasangan!['Nama pasangan']);
      edtKTPPasangan.text =  data.data!.pasangan!['Nomor KTP'].length > 2 ? data.data!.pasangan!['Nomor KTP'] : Utils.clearTextfield(data.data!.pasangan!['Nomor KTP']);
      edtTglLahirPasangan.text = Utils.clearTextfield(data.data!.pasangan!['Tanggal lahir pasangan']);
      edtNoHPPasangan.text = Utils.clearTextfield(data.data!.pasangan!['Nomor Hp']);
    }

    //penjamin
    if(data.data!.penjamin != null){
      if(data.data!.penjamin!['Nama Penjamin'] != '0'){
        namaPenjaminActive.value = true;
        _namaPenjamin = true;
        edtNamaPenjamin.text = Utils.clearTextfield(data.data!.penjamin!['Nama Penjamin']);
      }
      if(data.data!.penjamin!['Nomor KTP Penjamin'] != '0'){
        ktpPenjaminActive.value = true;
        _ktpPenjamin = true;
        edtKTPPenjamin.text = data.data!.penjamin!['Nomor KTP Penjamin'].length > 2 ?
        formatPattern(data.data!.penjamin!['Nomor KTP Penjamin']) : Utils.clearTextfield(data.data!.penjamin!['Nomor KTP Penjamin']);
      }
      if(data.data!.penjamin!['Hubungan Dengan Pemohon'] != '0'){
        hubunganPenjaminActive.value = true;
        _hubPenjamin = true;
        edtHubunganPenjamin.text = Utils.clearTextfield(data.data!.penjamin!['Hubungan Dengan Pemohon']);
      }
    }

    enableButton.value = true;

    //marital
    if(data.data!.identitas!.statusPernikahan!.toLowerCase() == 'menikah'){
      isMerried.value = true;
      // edtNamaPasangan.text = data.data!.pasangan!.;
      // edtNoHP.text = data.data!.identitas!.nomorTelepon!;
      // edtNoNPWP.text = data.data!.identitas!.noNpwp!;
      // edtMarital.text = data.data!.identitas!.statusPernikahan!;
    }
  }

  initDomisili(ModelDetailNasabah data){
    edtAlamat.text = Utils.clearTextfield(data.data!.domisili!.alamatKtp!);
    edtProvinsi.text = Utils.clearTextfield(data.data!.domisili!.provinsi!);
    edtKota.text = Utils.clearTextfield(data.data!.domisili!.kotaKabupaten!);
    edtKecamatan.text = Utils.clearTextfield(data.data!.domisili!.kecamatan!);
    edtKelurahan.text = Utils.clearTextfield(data.data!.domisili!.kelurahan!);
    edtKodePOS.text = Utils.clearTextfield(data.data!.domisili!.kodePos!);
    edtRT.text = Utils.clearTextfield(data.data!.domisili!.rt!);
    edtRW.text = Utils.clearTextfield(data.data!.domisili!.rw!);
    edtDomisili.text = Utils.clearTextfield(data.data!.domisili!.catatan!);
    if(Utils.clearTextfield(data.data!.domisili!.noTlpRumah!) != ''){
      tlpRumahActive.value = true;
      _tlpRUmah = true;
      edtNoTlpRUmah.text = Utils.clearTextfield(data.data!.domisili!.noTlpRumah!);
    }
    enableButton.value = true;
    getNewProvEdit(data.data!.domisili!.provinsi!);
  }

  initPekerjaan(ModelDetailNasabah data){
    edtKerjaan.text = Utils.clearTextfield(data.data!.pekerjaan!.pekerjaan!);
    edtNamaInstitusi.text = Utils.clearTextfield(data.data!.pekerjaan!.nama_institusi!);
    edtJabatan.text = Utils.clearTextfield(data.data!.pekerjaan!.jabatan!);
    edtLamaKerja.text = Utils.clearTextfield(data.data!.pekerjaan!.lama_bekerja!);
    edtTlpInstitusi.text = Utils.clearTextfield(data.data!.pekerjaan!.nomor_tlp_inst!);
    edtAlamatInstitusi.text = Utils.clearTextfield(data.data!.pekerjaan!.alamat_inst!);
    edtCatatanKerja.text = Utils.clearTextfield(data.data!.pekerjaan!.catatan_kerja!);
  }

  // updateIdentitas(BuildContext context, String id, bool isEdit, Function onSuccess) async {
  //   Utils.loading(context, 'Mohon tunggu...');
  //   var data = await SaveRoot.callSaveRoot();
  //   String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${id.toString()}';
  //   print('URL ${url}');
  //   var body = {
  //     '_method' : 'put',
  //     'name': edtNamaLengkap.text.toString(),
  //     'gender': edtGender.text.toString(),
  //     'nik': edtNoKTP.text.toString(),
  //     'date_of_birth': edtTglLahir.text.toString(),
  //     'place_of_birth': edtTmptLahir.text.toString(),
  //     'last_education': edtEducation.text.toString(),
  //     'mom_name': edtNamaIbu.text.toString(),
  //     'telp': edtNoHP.text.toString(),
  //     'npwp_number': edtNoNPWP.text.toString(),
  //     'status_marital_id': edtMarital.text != '' ? getIdMarital(edtMarital.text.toString()).toString():'',
  //     'valid_date_ktp': edtTglTerbitKTP.text.toString(),
  //     'note': edtCatatan.text.toString(),
  //   };
  //   print('BODY ${jsonEncode(body)}');
  //   print('TOKEN ${data.token.toString()}');
  //   var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
  //   Get.back();
  //   if (res.statusCode == 200) {
  //     var jsonDecode = json.decode(res.body);
  //     var dataJson = jsonDecode as Map<String, dynamic>;
  //     ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
  //     print('RESPONSE ${json.encode(jsonDecode)}');
  //     if(isEdit){
  //       updateDataPasangan(context, id, (){
  //         updatePenjamin(context, id, isEdit, (data){
  //           onSuccess(data);
  //         });
  //       });
  //     }else{
  //       updateDomisili(context, id, isEdit, (data){
  //         if(getIdMarital(edtMarital.text.toString()) == 2){
  //           updateDataPasangan(context, id, (){
  //             if(edtNamaPenjamin.text != '' || edtKTPPenjamin.text != '' || edtHubunganPenjamin.text != ''){
  //               updatePenjamin(context, id, isEdit, (data)=>onSuccess(data));
  //             }else{
  //               Get.bottomSheet(
  //                 GlobalScreenNotif(
  //                   title: "Berhasil",
  //                   content: "Data Nasabah Berhasil dikirim",
  //                   onTap: () {
  //                     Get.back();
  //                     Get.back();
  //                     // Get.back();
  //                     onSuccess(modelDetailNasabah);
  //                   },
  //                   textButton: "Selesai",
  //                 ),
  //                 isScrollControlled: true,
  //               );
  //             }
  //           });
  //         }else{
  //           if(edtNamaPenjamin.text != '' || edtKTPPenjamin.text != '' || edtHubunganPenjamin.text != ''){
  //             updatePenjamin(context, id, isEdit, (data)=>onSuccess(data));
  //           }else{
  //             Get.bottomSheet(
  //               GlobalScreenNotif(
  //                 title: "Berhasil",
  //                 content: "Data Nasabah Berhasil dikirim",
  //                 onTap: () {
  //                   Get.back();
  //                   Get.back();
  //                   // Get.back();
  //                   onSuccess(modelDetailNasabah);
  //                 },
  //                 textButton: "Selesai",
  //               ),
  //               isScrollControlled: true,
  //             );
  //           }
  //         }
  //       });
  //     }
  //
  //   }else{
  //     var jsonDecode = json.decode(res.body);
  //     var dataJson = jsonDecode as Map<String, dynamic>;
  //     rawBottomNotif(
  //       message: dataJson['message'],
  //       colorFont: Colors.white,
  //       backGround: Colors.red,
  //     );
  //   }
  // }

  newUpdateIdentitas(BuildContext context, String id, bool isEdit, Function onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'name': edtNamaLengkap.text.toString(),
      'gender': edtGender.text.toString(),
      'nik': edtNoKTP.text.toString(),
      'date_of_birth': edtTglLahir.text.toString(),
      'place_of_birth': edtTmptLahir.text.toString(),
      'last_education': edtEducation.text.toString(),
      'mom_name': edtNamaIbu.text.toString(),
      'telp': edtNoHP.text.toString(),
      'npwp_number': edtNoNPWP.text.toString(),
      'status_marital_id': edtMarital.text != '' ? getIdMarital(edtMarital.text.toString()).toString():'',
      'valid_date_ktp': edtTglTerbitKTP.text.toString(),
      'note': edtCatatan.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      updateDataPasangan(context, id, (){
        updatePenjamin(context, id, isEdit, (data){
          updateDomisili(context, id, isEdit, (data)=>onSuccess(data));
        });
      });

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

  updateDomisili(BuildContext context, String id, bool isEdit, Function onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/domisili/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'provinsi_id': provinsiID,
      'kabupaten_id': kotaID,
      'kecamatan_id': kecamatanID,
      'address': edtAlamat.text.toString(), //getIdMarital(identitas[9]).toString()
      'kelurahan': edtKelurahan.text.toString(),
      'rt': edtRT.text.toString(),
      'rw': edtRW.text.toString(),
      'pos_code': edtKodePOS.text.toString(),
      'note_domisili': edtDomisili.text.toString(),
      'home_telp': edtNoTlpRUmah.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      // onSuccess(modelDetailNasabah);
      // if(isEdit){
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Berhasil",
            content: "Data Nasabah Berhasil dikirim",
            onTap: () {
              Get.back();
              Get.back();
              onSuccess(modelDetailNasabah);
            },
            textButton: "Selesai",
          ),
          isScrollControlled: true,
        );
      // }else{
      //   onSuccess(modelDetailNasabah);
      // }

    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  updatePenjamin(BuildContext context, String id, bool isEdit, Function onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/penjamin/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'guarantor_name': edtNamaPenjamin.text.toString(),
      'guarantor_nik': edtKTPPenjamin.text.removeAllWhitespace.toString(), //getIdMarital(identitas[9]).toString()
      'relasi_applicant': edtHubunganPenjamin.text.toString()
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess(modelDetailNasabah);
      // Get.bottomSheet(
      //   GlobalScreenNotif(
      //     title: "Berhasil",
      //     content: "Data Nasabah Berhasil dikirim",
      //     onTap: () {
      //       Get.back();
      //       onSuccess(modelDetailNasabah);
      //     },
      //     textButton: "Selesai",
      //   ),
      //   isScrollControlled: true,
      // );
    }else{
      var sdas = jsonEncode(res.body);
      print('Error ${jsonEncode(res.body)}');
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  updateDataPasangan(BuildContext context, String id, Function onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/pasangan/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'name': edtNamaPasangan.text.toString(),
      'nik': edtKTPPasangan.text.toString(), //getIdMarital(identitas[9]).toString()
      'date_of_birth': edtTglLahirPasangan.text.toString(),
      'telp': edtNoHPPasangan.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      // Get.back();
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess();
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var dasas = jsonEncode(dataJson);
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  updatePekerjaan(BuildContext context, String id, Function onSuccess) async {
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/pekerjaan/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'profession_status': edtKerjaan.text.toString(),
      'office_name': edtNamaInstitusi.text.toString(),
      'position': edtJabatan.text.toString(),
      'length_of_work': edtLamaKerja.text.toString(),
      'office_telp': edtTlpInstitusi.text.toString(),
      'office_address': edtAlamatInstitusi.text.toString(),
      'note_profession': edtCatatanKerja.text.toString()
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Data Domisili Berhasil diupdate",
          onTap: () {
            Get.back();
            Get.back();
            onSuccess(modelDetailNasabah);
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var dasas = jsonEncode(dataJson);
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  updateDokumentNasabah(BuildContext context, String id, String path, List<File> docs, List<ModelListImageUpload> imageChange, List<String> imgDefault, Function onSuccess) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}/api/lead/document-nasabah/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    // imageChange.addAll(docs);
    request.fields.addAll({'_method':'put'});
    // if(path == ''){
    //   if(imageAwal != ''){
    //     request.fields.addAll({'preserved_photo[0]':imageAwal});
    //     // request.files.add(await http.MultipartFile.fromPath('preserved_photo[0]', imageAwal));
    //   }else{
    //     request.fields.addAll({'preserved_photo[0]': ''});
    //   }
    // }

    if(path != ''){
      request.fields.addAll({'photo_nasabah':path});
      request.files.add(await http.MultipartFile.fromPath('photo_nasabah', path));
      // request.files.add(await http.MultipartFile.fromPath('photo_document[0]', path));
    }else{
      request.fields.addAll({'photo_nasabah':''});
    }

    for(int i=0; i<imgDefault.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imgDefault[i]});
    }

    // List<File> changeImages = [];
    for(int i=0; i< imageChange.length; i++){
      if(imgDefault.length > 0){
        request.fields.remove('preserved_photo[${imageChange[i].index!}]');
      }
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    // docs.addAll(changeImages);
    for(int i=0; i< docs.length; i++){
      request.fields.addAll({'photo_document[${i}]':docs[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', docs[i].path));
    }

    if(imgDefault.length < 1){
      request.fields.addAll({'preserved_photo': ''});
    }

    if(imageChange.length < 1){
      request.fields.addAll({'photo_document': ''});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      // var jsonDecode = json.decode(res.body);
      // var dataJson = jsonDecode as Map<String, dynamic>;
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      // print('RESPONSE ${json.encode(jsonDecode)}');
      if (Get.isBottomSheetOpen == true) Get.back();
      print(await response.stream.bytesToString());
      // for (var i = 0; i < 5; i++) {
      //   Get.back();
      // }
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Data Nasabah Berhasil dikirim",
          onTap: () {
            Get.back();
            onSuccess();
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
      // log(response.statusCode.toString());
      // log(response.reasonPhrase.toString());
      // log(await response.stream.bytesToString());
      //
      // update();
    }
  }

  timeout(Function? onError){
    Get.back();
    onError!('Timeout');
  }

  //================= perubahan untuk kirimsemua form ===============

  bool _identityHasMove = false;
  bool get identityHasMove => _identityHasMove;

  bool _kerjaanHasMove = false;
  bool get kerjaanHasMove => _kerjaanHasMove;

  bool _allFieldIdentityEmpty = false;
  bool get allFieldIdentityEmpty => _allFieldIdentityEmpty;

  bool _allFieldKerjaanEmpty = false;
  bool get allFieldKerjaanEmpty => _allFieldKerjaanEmpty;

  changeIdentityMove(bool val){
    _identityHasMove = val;
  }
  changeKerjaanMove(bool val){
    _kerjaanHasMove = val;
  }

  postIdentitas({BuildContext? context,
      String? id,
      Function? onSuccess}) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'name': edtNamaLengkap.text.toString(),
      'gender': edtGender.text.toString(),
      'nik': edtNoKTP.text.toString(),
      'date_of_birth': edtTglLahir.text.toString(),
      'place_of_birth': edtTmptLahir.text.toString(),
      'last_education': edtEducation.text.toString(),
      'mom_name': edtNamaIbu.text.toString(),
      'telp': edtNoHP.text.toString(),
      'npwp_number': edtNoNPWP.text.toString(),
      'status_marital_id': edtMarital.text != '' ? getIdMarital(edtMarital.text.toString()).toString():'',
      'valid_date_ktp': edtTglTerbitKTP.text.toString(),
      'note': edtCatatan.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      postDomisili(context: context, id: id, onSuccess: (){
        if(getIdMarital(edtMarital.text.toString()) == 2){
          postPasangan(context: context, id: id, onSuccess: (){
            if(edtNamaPenjamin.text != '' || edtKTPPenjamin.text != '' || edtHubunganPenjamin.text != ''){
              postPenjamin(context: context, id: id, onSuccess: ()=>onSuccess!());
            }else{
              onSuccess!();
            }
          });
        }else{
          if(edtNamaPenjamin.text != '' || edtKTPPenjamin.text != '' || edtHubunganPenjamin.text != ''){
            postPenjamin(context: context, id: id, onSuccess: ()=>onSuccess!());
          }else{
            onSuccess!();
          }
        }}
      );
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

  postDomisili(
      {BuildContext? context,
      String? id,
      Function? onSuccess}) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/domisili/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'provinsi_id': provinsiID,
      'kabupaten_id': kotaID,
      'kecamatan_id': kecamatanID,
      'address': edtAlamat.text.toString(), //getIdMarital(identitas[9]).toString()
      'kelurahan': edtKelurahan.text.toString(),
      'rt': edtRT.text.toString(),
      'rw': edtRW.text.toString(),
      'pos_code': edtKodePOS.text.toString(),
      'note_domisili': edtDomisili.text.toString(),
      'home_telp': edtNoTlpRUmah.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      onSuccess!();

    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  postPasangan({BuildContext? context, String? id, Function? onSuccess}) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/pasangan/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'name': edtNamaPasangan.text.toString(),
      'nik': edtKTPPasangan.text.toString(), //getIdMarital(identitas[9]).toString()
      'date_of_birth': edtTglLahirPasangan.text.toString(),
      'telp': edtNoHPPasangan.text.toString(),
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      onSuccess!();
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var dasas = jsonEncode(dataJson);
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  postPenjamin({BuildContext? context, String? id, Function? onSuccess}) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/penjamin/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'guarantor_name': edtNamaPenjamin.text.toString(),
      'guarantor_nik': edtKTPPenjamin.text.removeAllWhitespace.toString(), //getIdMarital(identitas[9]).toString()
      'relasi_applicant': edtHubunganPenjamin.text.toString()
    };
    print('BODY ${jsonEncode(body)}');
    print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess!();
    }else{
      var sdas = jsonEncode(res.body);
      print('Error ${jsonEncode(res.body)}');
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  postPekerjaan({BuildContext? context, String? id, Function? onSuccess}) async {
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String url = '${ApiUrl.domain.toString()}/api/lead/nasabah/pekerjaan/${id.toString()}';
    print('URL ${url}');
    var body = {
      '_method' : 'put',
      'profession_status': edtKerjaan.text.toString(),
      'office_name': edtNamaInstitusi.text.toString(),
      'position': edtJabatan.text.toString(),
      'length_of_work': edtLamaKerja.text.toString(),
      'office_telp': edtTlpInstitusi.text.toString(),
      'office_address': edtAlamatInstitusi.text.toString(),
      'note_profession': edtCatatanKerja.text.toString()
    };
    print('BODY ${jsonEncode(body)}');
    // print('TOKEN ${data.token.toString()}');
    var res = await http.post(Uri.parse(url), headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: body);
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      print('RESPONSE ${json.encode(jsonDecode)}');
      // Get.back();
      // Get.back();
      // Get.back();
      onSuccess!();
    }else{
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var dasas = jsonEncode(dataJson);
      print('Error ${jsonEncode(dataJson)}');
      rawBottomNotif(
        message: dataJson['message'],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
    }
  }

  postDokumentNasabah(
      {BuildContext? context,
      String? id,
      String? path,
      List<File>? docs,
      List<ModelListImageUpload>? imageChange,
      List<String>? imgDefault,
      Function? onSuccess}) async{
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain.toString()}/api/lead/document-nasabah/${id.toString()}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');
    request.fields.addAll({'_method':'put'});
    if(path != ''){
      request.fields.addAll({'photo_nasabah':path!});
      request.files.add(await http.MultipartFile.fromPath('photo_nasabah', path));
      // request.files.add(await http.MultipartFile.fromPath('photo_document[0]', path));
    }else{
      request.fields.addAll({'photo_nasabah':''});
    }

    for(int i=0; i<imgDefault!.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imgDefault[i]});
    }

    // List<File> changeImages = [];
    for(int i=0; i< imageChange!.length; i++){
      if(imgDefault.length > 0){
        request.fields.remove('preserved_photo[${imageChange[i].index!}]');
      }
      request.fields.addAll({'photo_document[${i}]':imageChange[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', imageChange[i].image!.path));
    }

    // docs.addAll(changeImages);
    for(int i=0; i< docs!.length; i++){
      request.fields.addAll({'photo_document[${i}]':docs[i].path});
      request.files.add(await http.MultipartFile.fromPath(
          'photo_document[${i}]', docs[i].path));
    }

    if(imgDefault.length < 1){
      request.fields.addAll({'preserved_photo': ''});
    }

    if(imageChange.length < 1){
      request.fields.addAll({'photo_document': ''});
    }

    request.headers.addAll(headers);
    print('BODY : ${jsonEncode(request.fields)}');
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      // var jsonDecode = json.decode(res.body);
      // var dataJson = jsonDecode as Map<String, dynamic>;
      // ModelDetailNasabah modelDetailNasabah = modelDetailNasabahFromMap(res.body);
      // print('RESPONSE ${json.encode(jsonDecode)}');
      if (Get.isBottomSheetOpen == true) Get.back();
      print(await response.stream.bytesToString());
      // Get.back();
      // Get.back();
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
    }
  }

  Rx<File> finalImage = File('').obs;
  RxList<File> listDoc = <File>[].obs;

  changeFinalImage(File val){
    finalImage.value = val;
  }

  changeListDoc(List<File> val){
    // listDoc.value.clear();
    listDoc.value = val;
  }
}