import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';

import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_wilayah/controller_wilayah.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/cek_nomor-polisi.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/utils/debouncher.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

class MobilYangDiIklan extends StatefulWidget {
  const MobilYangDiIklan({
    Key? key,
    required this.toChangePage,
    required this.isFinancing,
  }) : super(key: key);
  final ValueChanged<int>? toChangePage;
  final bool isFinancing;

  @override
  _MobilYangDiIklanState createState() => _MobilYangDiIklanState();
}

class _MobilYangDiIklanState extends State<MobilYangDiIklan>
    with AutomaticKeepAliveClientMixin {
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());

  ControllerWilayah controllerWilayah = Get.put(ControllerWilayah());
  var debouncher = new Debouncer(milliseconds: 500);

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
  }) {
    return TextFormField(
      inputFormatters: label == "Catatan" ? null :
      label == "Nomor Polisi" ? [UpperCaseTextFormatter(), FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))] :
        [FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),ThousandsSeparatorInputFormatter()],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {},
      controller: controller,
      onChanged: (v) {
          onChanged(v);
        // setState(() {});
        // setState(() {
        //   if (v == "" || v == "0") {
        //     nopol.text = "";
        //   }
        //   // log(v);
        // });
        // if (label == "Nomor Polisi") {
        //   ceking(s: v);
        //   log(nopol.text);
        // }

        // log(controller.text);
      },
      focusNode: focusNode,
      keyboardType: type,
      maxLines: label == "Catatan" ? 4 : 1,
      decoration: InputDecoration(
        prefix: label == "Harga" ? Text("Rp ") : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: label == "Catatan" ? 8 : 0),
        errorText: messageApi == null ? null : messageApi,
        labelText: label,
        labelStyle: TextStyle(color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  validasiInput(String param){
    var strNopol = '';
    for(int i=0; i<param.length; i++){
      if(param[i].isAlphabetOnly){
        if(strNopol.contains(' ')){
          var strSplit = strNopol.split(' ');
          if(strSplit.length > 2){
            var strFirst = strNopol.split(' ')[0];
            var strSec = strNopol.split(' ')[1];
            var strthrd = strNopol.split(' ')[2];
            if(strthrd.length < 3){
              strNopol = strFirst + ' ' + strSec+ ' ' + strthrd+param[i];
            }
          }else{
            var strFirst = strNopol.split(' ')[0];
            var strSec = strNopol.split(' ')[1];
            if(param[i].isNum){
              strNopol = strFirst+ " "+strSec+param[i];
            }else{
              strNopol = strFirst+ " "+strSec+ ' ' +param[i];
            }
          }
        }else{
          if(strNopol.length < 2){
            strNopol = strNopol+param[i];
          }
        }
      }else if(param[i].isNum){
        if(strNopol.contains(' ')){
          var strFirst = strNopol.split(' ')[0];
          var strSec = strNopol.split(' ')[1];
          if(strSec.length < 4){
            strNopol = strFirst + ' ' + strSec+param[i];
          }
        }else{
          strNopol = strNopol+ " "+param[i];
        }

      }
    }
    nopol.text = strNopol;
    nopol.selection = TextSelection.fromPosition(TextPosition(offset: strNopol.length));

    if(strNopol.split(' ').length > 2){
      // FocusScope.of(context).requestFocus(new FocusNode());
      ceking(s: strNopol);
    }
  }

  FocusNode ttttt = new FocusNode();

  Widget ttt({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController controller,
  }) {
    // bool foc = false;
    return Focus(
      onFocusChange: (v) {
        // setState(() {
        //   v ? foc = true : foc = false;
        //   log(v.toString());
        // });
      },
      child: TypeAheadField<Datum?>(
        suggestionsBoxDecoration: SuggestionsBoxDecoration(constraints: BoxConstraints(maxHeight: 55 * 4)),
        hideSuggestionsOnKeyboardHide: true,
        hideOnError: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
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
            labelText: label,
            labelStyle: TextStyle(color: yd_Color_Primary_Grey,),
            // labelStyle: TextStyle(color: foc ? yd_Color_Primary : yd_Color_Primary_Grey,),
          ),
        ),
        suggestionsCallback: (search) {
          return items!.where((element) => element.name!.toLowerCase().contains(search.toLowerCase())).toList();
        },
        itemBuilder: (context, Datum? datum) {
          return ListTile(
            title: Text(datum!.name!),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          height: 50,
          child: Center(child: Text('tidak ditemukan', style: TextStyle(fontSize: 12))),
        ),
        onSuggestionSelected: (Datum? data) {
          if (label == "Kondisi Mobil") {
            controllerWilayah.setKondisiMobil(data!);
          } else if (label == "Merek") {
            controllerWilayah.setMerk(data!);
          } else if (label == "Model") {
            controllerWilayah.setModel(data!);
          } else if (label == "Varian") {
            controllerWilayah.setVarian(data!);
          } else if (label == "Tahun") {
            setState(() {
              controller.text = data!.name!;
              selectedTahun = data;
            });
          } else if (label == "Jarak Tempuh") {
            controllerWilayah.setJarak(data!);
          } else if (label == "Bahan Bakar") {
            controllerWilayah.setBahanBakar(data!);
          } else if (label == "Transmisi") {
            controllerWilayah.setTransmisi(data!);
          } else if (label == "Warna") {
            controllerWilayah.setWarna(data!);
          } else if (label == "Provinsi") {
            controllerWilayah.setProvinsi(data!);
          } else if (label == "Kota/Kabupaten") {
            controllerWilayah.setKota(data!);
          } else if (label == "Kecamatan") {
            controllerWilayah.setKecamatan(data!);
          }
        },
      ),
    );
  }

  FocusNode fNopol = new FocusNode();
  TextEditingController nopol = TextEditingController();
  final cek = RegExp(r'[A-Z]{1,2}\s[0-9]{1,4}\s[A-Z]{1,3}$');
  // final cek = RegExp(r'[A-Z]{1,2}$');
  // "A 01 G"
  // "A 01 GB"
  // "AE 5677 TR"
  String? message;
  bool benar = false;
  ceking({String? s}) {
    if (cek.hasMatch(s!) == true) {
      log(cek.hasMatch(s).toString(), name: "ini benar");
      setState(() {
        benar = true;
        message = null;
        cekidleNomerKendaraan();
      });
    } else {
      log(cek.hasMatch(s).toString(), name: "ini salah");
      setState(() {
        benar = false;
        message = "Nomor polisi tidak valid";
      });
    }
  }

  bool bisaTambah = false;
  cekidleNomerKendaraan() async {
    // modalLoad();
    setState(() {
      message = null;
      bisaTambah = true;
    });

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.cekNomerKendaraan.toString()}';
    var res = await http.post(Uri.parse(url.trim()), body: {'police_number': nopol.text}, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      log(res.body);
      setState(() {
        message = null;
        bisaTambah = true;
      });
    } else {
      log(res.body);
      setState(() {
        message = json.decode(res.body)["message"];
        bisaTambah = false;
      });
    }
  }

  ModelWilayah? prov;
  Datum? seledtedProv;
  Datum? selectedTahun;
  TextEditingController cTahun = TextEditingController();

  TextEditingController catatan = TextEditingController();
  FocusNode fCatatan = new FocusNode();
  FocusNode fHarga = new FocusNode();

  List<Datum> listTahun = [
    for (var i = DateTime.now().year; i >= 1945; i--)
      Datum(id: i, name: i.toString()),
  ];

  @override
  void initState() {
    super.initState();
    controllerWilayah.getNewKondisi();
    // controllerWilayah.getNewMerek();
    // controllerWilayah.getNewBahanBakar();
    // controllerWilayah.getNewJarakTempuh();
    // controllerWilayah.getNewTransmisi();
    // controllerWilayah.getNewWarna();
    // controllerWilayah.getNewProv();

    // controllerWilayah.getKondisi();
    // controllerWilayah.getMerek();
    // controllerWilayah.getBahanBakar();
    // controllerWilayah.getJarakTempuh();
    // controllerWilayah.getTransmisi();
    // controllerWilayah.getWarna();
    // controllerWilayah.getProv();

    nopol.text = addLeadFinancing.nomorPolisi1.toString();
    benar = true;
    bisaTambah = true;
    // log(nopol.text);
  }

  ScrollController controllerSC = new ScrollController(
    initialScrollOffset: 0.0,
    // keepScrollOffset: true,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(onTap: () {
      // setState(() {
      //   fNopol.unfocus();
      //   fCatatan.unfocus();
      //   fHarga.unfocus();
      //   ttttt.unfocus();
      // });
    }, child: GetBuilder<ControllerWilayah>(builder: (v) {
      return Scaffold(
        // extendBody: true,
        backgroundColor: Colors.white,
        body: Obx(()=>SingleChildScrollView(
          controller: controllerSC,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              SizedBox(height: 30),
              Center(
                child: widget.isFinancing
                    ? Text("Mobil Apa yang Anda Ingin Iklankan?", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center)
                    : Text("Mobil Apa yang ingin Anda agunkan?", style: TextStyle(fontSize: 22),textAlign: TextAlign.center),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Spesifikasi unit", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                  ),
                  SizedBox(height: 15),
                  textFieldLogin(
                    onChanged: (v) {
                      // debouncher.run(() {
                      //   validasiInput(v);
                      // });
                      validasiInput(v);
                    },
                    focusNode: fNopol,
                    label: "Nomor Polisi",
                    controller: nopol,
                    type: TextInputType.text,
                    messageApi: message,
                  ),
                  SizedBox(height: yd_defauld_padding,),
                  ttt(
                    label: v.kondisiLoad.value ? "Memuat..." : "Kondisi Mobil",
                    value: v.selectedKondisi.value,
                    controller: v.edtKondisi,
                    items: v.kondisiLoad.value ? [] : v.modelKondisi.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding,),
                  ttt(
                    label: v.merkLoad.value ? "Memuat..." : "Merek",
                    value: v.selectedMerk.value,
                    controller: v.edtMerk,
                    items: v.merkLoad.value ? [] : v.modelMerk.value.data,
                  ),

                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.modelLoad.value ? "Memuat..." : "Model",
                    value: controllerWilayah.selectedModel.value,
                    controller: v.edtModel,
                    items: v.modelLoad.value? []: v.modelModel.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.varianLoad.value ? "Memuat..." : "Varian",
                    value: v.selectedVarian.value,
                    controller: v.edtVarian,
                    items: v.varianLoad.value? []: v.modelVarian.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: "Tahun",
                    value: selectedTahun,
                    controller: cTahun,
                    items: listTahun,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.jarakLoad.value ? "Memuat..." : "Jarak Tempuh",
                    value: v.selectedJarak.value,
                    controller: v.edtJarak,
                    items: v.jarakLoad.value ? [] : v.modelJarak.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.bahanBakarLoad.value ? "Memuat..." : "Bahan Bakar",
                    value: v.selectedBahanBakar.value,
                    controller: v.edtBahanBakar,
                    items: v.bahanBakarLoad.value ? [] : v.modelBahanBakar.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.transmisiLoad.value ? "Memuat..." : "Transmisi",
                    value: v.selectedTransmisi.value,
                    controller: v.edtTransmisi,
                    items: v.transmisiLoad.value ? [] : v.modelTransmisi.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  ttt(
                    label: v.warnaLoad.value ? "Memuat..." : "Warna",
                    value: v.selectedWarna.value,
                    controller: v.edtWarna,
                    items: v.warnaLoad.value ? [] : v.modelWarna.value.data,
                  ),
                  SizedBox(height: yd_defauld_padding),
                  textFieldLogin(
                    label: "Catatan",
                    focusNode: fCatatan,
                    controller: catatan,
                    type: TextInputType.multiline,
                    onChanged: (v)=>controllerWilayah.setEnableNext(),
                  ),
                  SizedBox(
                    height: yd_defauld_padding,
                  ),
                  textFieldLogin(
                    label: "Harga",
                    focusNode: fHarga,
                    controller: controllerWilayah.edtHarga,
                    type: TextInputType.number,
                    onChanged: (v)=>controllerWilayah.setEnableNext(),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Column(children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Lokasi unit", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                ),
                SizedBox(height: 15,),
                ttt(
                  label: v.provLoad.value ? "Memuat..." : "Provinsi",
                  value: seledtedProv,
                  controller: v.edtProv,
                  items: v.provLoad.value ? []: v.modelProv.value.data,
                ),
                SizedBox(height: yd_defauld_padding,),
                ttt(
                  label: v.kotaLoad.value ? "Memuat..." : "Kota/Kabupaten",
                  value: v.selectedKota.value,
                  controller: v.edtKota,
                  items: v.kotaLoad.value? []: v.modelKota.value.data,
                ),
                SizedBox(height: yd_defauld_padding,),
                ttt(
                  label: v.kecLoad.value ? "Memuat..." : "Kecamatan",
                  value: v.selectedKec.value,
                  controller: v.edtKec,
                  items: v.kecLoad.value? []: v.modelKec.value.data,
                ),
                SizedBox(height: yd_defauld_padding,),
              ]),
              SizedBox(height: yd_defauld_padding * 2),
              !controllerWilayah.enableNext.value || selectedTahun == null || controllerWilayah.edtHarga.text.length <= 0 ? GestureDetector(
                onTap: () {
                },
                child: buttonDefaulLogin(
                    backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                    textColor: Colors.white,
                    text: "Selanjutnya"),
              ) : GestureDetector(
                onTap: () {
                  addLeadFinancing.inputAll(
                      nomorPolisi: nopol.text,
                      kondisiMobil: controllerWilayah.selectedKondisi.value,
                      merek: controllerWilayah.selectedMerk.value,
                      model: controllerWilayah.selectedModel.value,
                      varian:  controllerWilayah.selectedVarian.value ,
                      tahun: selectedTahun!,
                      jarakTempuh:  controllerWilayah.selectedJarak.value ,
                      bahanBakar: controllerWilayah.selectedBahanBakar.value,
                      transmisi: controllerWilayah.selectedTransmisi.value,
                      warna: controllerWilayah.selectedWarna.value,
                      catatan:
                      catatan.text.length == 0 ? "-" : catatan.text,
                      harga: controllerWilayah.edtHarga.text,
                      provinsi: controllerWilayah.selectedProv.value,
                      kotaKabupaten: controllerWilayah.selectedKota.value,
                      kecamatan: controllerWilayah.selectedKec.value);
                  setState(() {
                    widget.toChangePage!(1);
                  });
                },
                child: buttonDefaulLogin(
                    backGround: yd_Color_Primary,
                    textColor: Colors.white,
                    text: "Selanjutnya"),
              ),
              SizedBox(height: yd_defauld_padding)
            ]),
          ),
        )),
      );
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
