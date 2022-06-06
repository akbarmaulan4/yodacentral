import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_wilayah/controller_wilayah.dart';
import 'package:yodacentral/models/model_edit/model_detail_edit_unit.dart';
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

class EditInformasiUnit extends StatefulWidget {
  const EditInformasiUnit(
      {Key? key,
      required this.id_unit,
      required this.lead_id,
      required this.namePipeline,
      required this.getData})
      : super(key: key);

  final int id_unit;
  final int lead_id;
  final String namePipeline;
  final ValueChanged<bool> getData;

  @override
  _EditInformasiUnitState createState() => _EditInformasiUnitState();
}

class _EditInformasiUnitState extends State<EditInformasiUnit> {
  /////update detail
  updateInfoUnit() async {
    log(catatan.text, name: "ini note");
    SaveRoot.callSaveRoot().then((value) async {
      modalLoad();
      var url = '${ApiUrl.domain.toString()}/api/lead/unit/edit/${widget.id_unit.toString()}';
      print('URL : ${url}');
      var body = {
        'police_number': nopol.text,
        'condition_id': selectedKondisi!.id.toString(),
        'variant_id': selectedVarian!.id.toString(),
        'mileage_id': selectedJarakTempuh!.id.toString(),
        'fuel_id': selectedBahanBakar!.id.toString(),
        'transmission_id': selectedTransmisi!.id.toString(),
        'color_id': selectedWarna!.id.toString(),
        'intended_use_id': '4',
        'note': catatan.text.isEmpty || catatan.text.length <= 0
            ? "-"
            : catatan.text,
        'price': harga.text.replaceAll(",", ""),
        'year': selectedTahun!.name.toString(),
        'kecamatan_id': seledtedKec!.id.toString(),
        '_method': 'put'
      };
      var res = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      }, body: body);

      print('BODY : ${jsonEncode(body)}');

      if (res.statusCode == 200) {
        log(res.body);
        if (Get.isBottomSheetOpen == true) Get.back();
        setState(() {
          widget.getData(true);
        });
        Get.bottomSheet(
          GlobalScreenNotif(
            title: "Berhasil",
            content: "Data Informasi Unit berhasil diupdate",
            onTap: () {
              Get.back();
              Get.back();
            },
            textButton: "Selesai",
          ),
          isScrollControlled: true,
        );
      } else {
        if (Get.isBottomSheetOpen == true) Get.back();
        log(res.body);
        rawBottomNotif(
          message: res.body,
          colorFont: Colors.white,
          backGround: Colors.red,
        );
      }
    });
  }

  bool load = true;
  ModelDetailEditUnit? modelDetailEditUnit;
  getDetailInfoUnit() async {
    setState(() {
      load = true;
    });
    SaveRoot.callSaveRoot().then(
      (value) async {
        var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/unit/edit/" + widget.id_unit.toString(),);
        log(url.toString());
        var res = await http.get(url!, headers: {'Authorization': 'Bearer ' + value.token.toString()},);

        if (res.statusCode == 200) {
          log(res.body, name: "ini else1");
          if (json.decode(res.body)["message"] ==
              "Tidak ada kecocokan antara data dengan id lead") {
            Navigator.pop(context);
            rawBottomNotif(
              message: json.decode(res.body)["message"],
              colorFont: Colors.white,
              backGround: Colors.red,
            );
          } else {
            setState(() {
              modelDetailEditUnit = modelDetailEditUnitFromMap(res.body);
              var a = modelDetailEditUnit!.data!;
              nopol.text = a.numberPolice!;
              selectedKondisi = Datum(id: a.kondisi!.id, name: a.kondisi!.value);
              ckondisi.text = a.kondisi!.value!;
              selectedmerek = Datum(id: a.merek!.id, name: a.merek!.value);
              controllerWilayah.getModel(idMerek: a.merek!.id!);
              cmerek.text = a.merek!.value!;
              selectedModel = Datum(id: a.model!.id, name: a.model!.value);
              controllerWilayah.getVarain(idModel: a.model!.id!);
              cmodel.text = a.model!.value!;
              selectedVarian = Datum(id: a.varian!.id, name: a.varian!.value);
              cvarian.text = a.varian!.value!;
              selectedTahun = Datum(id: a.tahun!, name: a.tahun.toString());
              cTahun.text = a.tahun.toString();
              selectedJarakTempuh = Datum(id: a.jarakTempuh!.id, name: a.jarakTempuh!.value);
              cjarak.text = a.jarakTempuh!.value!;
              selectedBahanBakar = Datum(id: a.bahanBakar!.id, name: a.bahanBakar!.value);
              cbahanbakar.text = a.bahanBakar!.value!;
              selectedTransmisi = Datum(id: a.transmisi!.id, name: a.transmisi!.value);
              cTransmisi.text = a.transmisi!.value!;
              selectedWarna = Datum(id: a.warna!.id, name: a.warna!.value);
              cWarna.text = a.warna!.value!;
              catatan.text = a.catatan!;
              harga.text = NumberFormat.currency(decimalDigits: 0, symbol: "", name: "",).format(a.harga);
              seledtedProv = Datum(id: a.provinsi!.id, name: a.provinsi!.value);
              controllerWilayah.getKota(id: a.provinsi!.id!);
              cprov.text = a.provinsi!.value!;
              seledtedKotaKab = Datum(id: a.kabupaten!.id, name: a.kabupaten!.value);
              controllerWilayah.getKec(id: a.kabupaten!.id!);
              ckab.text = a.kabupaten!.value!;
              seledtedKec = Datum(id: a.kecamatan!.id, name: a.kecamatan!.value);
              ckec.text = a.kecamatan!.value!;
              load = false;
              setComplete();
            });
          }
        } else {
          Navigator.pop(context);
          setState(() {
            load = true;
          });
        }
      },
    );
  }



  bool isComplete = false;
  setComplete(){
    if(isFirstLaunch){
      setState(() {
        isComplete = false;
      });
      return;
    }
    if(nopol.text.length <= 0 || message != null ||
        selectedKondisi == null ||
        selectedmerek == null ||
        selectedModel == null ||
        selectedVarian == null ||
        selectedTahun == null ||
        selectedJarakTempuh == null ||
        selectedBahanBakar == null ||
        selectedTransmisi == null ||
        selectedWarna == null ||
        harga.text.length <= 0 ||
        seledtedProv == null ||
        seledtedKotaKab == null ||
        seledtedKec == null ||
        seledtedProv!.name != cprov.text ||
        seledtedKotaKab!.name != ckab.text ||
        seledtedKec!.name != ckec.text ||
        selectedKondisi!.name != ckondisi.text ||
        selectedmerek!.name != cmerek.text ||
        selectedModel!.name != cmodel.text ||
        selectedVarian!.name != cvarian.text ||
        selectedJarakTempuh!.name != cjarak.text ||
        selectedBahanBakar!.name != cbahanbakar.text ||
        selectedTransmisi!.name != cTransmisi.text ||
        selectedWarna!.name != cWarna.text ||
        selectedTahun!.name != cTahun.text ||
        !benar ||
        !bisaTambah
    ){
      setState(() {
        // benar = false;
        // message = "Nomor polisi tidak valid";
        isComplete = false;
      });
    }else{
      setState(() {
        benar = true;
        message = null;
        isComplete = true;
      });

    }
  }

  ControllerWilayah controllerWilayah = Get.put(ControllerWilayah());

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
    bool? enable = true
  }) {
    return TextFormField(
      inputFormatters: label == "Catatan"
          ? null
          : label == "Nomor Polisi"
              ? [
                  // if (label == "Nomor Polisi")
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
                  // WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))
                  // FilteringTextInputFormatter.allow(
                  //     RegExp(r"[A-Z]{1,2}/s[0-9]{1,4}/s[A-Z]{1,3}$")),
                  // else if (label == "Harga")
                ]
              : [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.,]")),
                  ThousandsSeparatorInputFormatter()
                ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {},
      controller: controller,
      enabled: enable,
      onChanged: (v) {
        onChanged(v);
        if(isFirstLaunch){
          setState(() {
            isFirstLaunch = false;
          });
        }
      },
      focusNode: focusNode,
      keyboardType: type,
      maxLines: label == "Catatan" ? 4 : 1,
      decoration: InputDecoration(
        prefix: label == "Harga" ? Text("Rp ") : null,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 15, vertical: label == "Catatan" ? 8 : 0),
        errorText: messageApi == null ? null : messageApi,
        labelText: label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,
        ),
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
    if(param == ''){
      setState(() {
        benar = false;
        message = null;
      });
    }
    for(int i=0; i<param.length; i++){
      if(param[i].isAlphabetOnly){
        if(strNopol.contains(' ')){
          var strSplit = strNopol.split(' ');
          if(strSplit.length > 0){
            setState(() {
              benar = true;
              message = null;
            });
          }else{
            setState(() {
              benar = false;
              message = null;
            });
          }
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
            setState(() {
              benar = false;
              message = null;
            });
          }
        }
      }else if(param[i].isNum){
        var strSplit =  strNopol.split(' ');
        if(strSplit.length > 0){
          setState(() {
            benar = true;
            message = null;
          });
        }else{
          setState(() {
            benar = false;
            message = null;
          });
        }
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

    // ceking(s: strNopol);
    if(strNopol[0] == ' '){
      setState(() {
        benar = false;
        message = "Nomor polisi tidak valid";
        setComplete();
      });
      return;
    }
    if(strNopol.split(' ').length > 1){
      setState(() {
        benar = true;
        message = null;
        ceking(s: strNopol);
      });
    }else{
      setState(() {
        benar = false;
        message = "Nomor polisi tidak valid";
      });
    }
    setComplete();
  }

  FocusNode ttttt = new FocusNode();

  Widget ttt({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController controller,
    bool enable = true
  }) {
    bool foc = false;
    return Focus(
      onFocusChange: (v) {
        setState(() {
          v ? foc = true : foc = false;
          log(v.toString());
        });
      },
      child: TypeAheadField<Datum?>(
        autoFlipDirection: false,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          constraints: BoxConstraints(
            maxHeight: 55 * 4,
          ),
        ),
        hideSuggestionsOnKeyboardHide: true,
        textFieldConfiguration: TextFieldConfiguration(
          onChanged: (v) {
            if(isFirstLaunch){
              setState(() {
                isFirstLaunch = false;
              });
            }else{
              setState(() {});
            }
          },
          controller: controller,
          enabled: enable,
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
            labelStyle: TextStyle(
              color: foc ? yd_Color_Primary : yd_Color_Primary_Grey,
            ),
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
          child: Center(child: Text('tidak ditemukan', style: TextStyle(fontSize: 12),),),
        ),
        onSuggestionSelected: (Datum? data) {

          if (items!.length <= 0 || items.isEmpty) {
          } else {
            if (label == "Provinsi") {
              controllerWilayah.clearKotKec();

              setState(() {
                seledtedKotaKab = null;
                seledtedKec = null;
              });
              controllerWilayah.getKota(id: (data)!.id!);
            } else if (label == "Kota/Kabupaten") {
              controllerWilayah.clearKec();
              setState(() {
                seledtedKec = null;
                ckab.clear();
              });
              controllerWilayah.getKec(id: (data)!.id!);
            } else if (label == "Merek") {
              controllerWilayah.clearVariantModel();
              setState(() {
                cvarian.clear();
                cmodel.clear();
              });
              controllerWilayah.getModel(idMerek: (data)!.id!);
            } else if (label == "Model") {
              controllerWilayah.clearVarian();
              setState(() {
                cvarian.clear();
              });
              controllerWilayah.getVarain(idModel: (data)!.id!);
            }
          }

          if (label == "Kondisi Mobil") {
            setState(() {
              controller.text = data!.name!;
              selectedKondisi = data;
            });
          } else if (label == "Merek") {
            setState(() {
              controller.text = data!.name!;
              cmodel.clear();
              cvarian.clear();
              selectedmerek = data;
            });
          } else if (label == "Model") {
            setState(() {
              controller.text = data!.name!;
              selectedModel = data;
              cvarian.clear();
            });
          } else if (label == "Varian") {
            setState(() {
              controller.text = data!.name!;
              selectedVarian = data;
            });
          } else if (label == "Tahun") {
            setState(() {
              controller.text = data!.name!;
              selectedTahun = data;
            });
          } else if (label == "Jarak Tempuh") {
            setState(() {
              controller.text = data!.name!;
              selectedJarakTempuh = data;
            });
          } else if (label == "Bahan Bakar") {
            setState(() {
              controller.text = data!.name!;
              selectedBahanBakar = data;
            });
          } else if (label == "Transmisi") {
            setState(() {
              controller.text = data!.name!;
              selectedTransmisi = data;
            });
          } else if (label == "Provinsi") {
            setState(() {
              controller.text = data!.name!;
              seledtedProv = data;
              ckab.clear();
              ckec.clear();
            });
          } else if (label == "Warna") {
            setState(() {
              controller.text = data!.name!;
              selectedWarna = data;
            });
          } else if (label == "Kota/Kabupaten") {
            setState(() {
              ckec.clear();
              controller.text = data!.name!;
              seledtedKotaKab = data;
            });
          } else if (label == "Kecamatan") {
            setState(() {
              controller.text = data!.name!;
              seledtedKec = data;
            });
          }
          setComplete();
        },
      ),
    );
  }

  FocusNode fNopol = new FocusNode();
  TextEditingController nopol = TextEditingController();

  final cek = RegExp(r'[A-Z]{1,2}\s[0-9]{1,4}$');
  // final cek = RegExp(r'[A-Z]{1,2}\s[0-9]{1,4}\s[A-Z]{1,3}$');
  String? message;
  bool benar = false;

  ceking({String? s}) {
    cekidleNomerKendaraan();
    // if ( cek.hasMatch(s!) == true) {
    //   log(cek.hasMatch(s).toString(), name: "ini benar");
    //   setState(() {
    //     benar = true;
    //     message = null;
    //     cekidleNomerKendaraan();
    //   });
    // } else {
    //   log(cek.hasMatch(s).toString(), name: "ini salah");
    //   setState(() {
    //     benar = false;
    //     message = "Nomor polisi tidak valid";
    //   });
    // }
  }

  bool bisaTambah = false;
  cekidleNomerKendaraan() async {
    // modalLoad();
    setState(() {
      message = null;
      bisaTambah = true;
    });

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + ApiUrl.cekNomerKendaraan.toString());

    var res = await http.post(url!, body: {'police_number': nopol.text}, headers: {'Authorization': 'Bearer ' + value.token.toString()});

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
    setComplete();
  }

  // TextEditingController ccc = TextEditingController();

  // MaskedTextController();

  // final GlobalKey<FormFieldState> _kot = GlobalKey<FormFieldState>();
  // final GlobalKey<FormFieldState> _kec = GlobalKey<FormFieldState>();

  ModelWilayah? prov;
  Datum? seledtedProv;
  TextEditingController cprov = TextEditingController();
  Datum? seledtedKotaKab;
  TextEditingController ckab = TextEditingController();
  Datum? seledtedKec;
  TextEditingController ckec = TextEditingController();
  Datum? selectedKondisi;
  TextEditingController ckondisi = TextEditingController();
  Datum? selectedmerek;
  TextEditingController cmerek = TextEditingController();
  Datum? selectedModel;
  TextEditingController cmodel = TextEditingController();
  Datum? selectedVarian;
  TextEditingController cvarian = TextEditingController();
  Datum? selectedJarakTempuh;
  TextEditingController cjarak = TextEditingController();
  Datum? selectedBahanBakar;
  TextEditingController cbahanbakar = TextEditingController();
  Datum? selectedTransmisi;
  TextEditingController cTransmisi = TextEditingController();
  Datum? selectedWarna;
  TextEditingController cWarna = TextEditingController();
  Datum? selectedTahun;
  TextEditingController cTahun = TextEditingController();

  TextEditingController catatan = TextEditingController();
  FocusNode fCatatan = new FocusNode();
  TextEditingController harga = TextEditingController();
  FocusNode fHarga = new FocusNode();

  List<Datum> listTahun = [
    for (var i = DateTime.now().year; i >= 1945; i--)
      Datum(
        id: i,
        name: i.toString(),
      ),
  ];

  bool isFirstLaunch = true;
  @override
  void initState() {
    super.initState();
    checkAccess();
    controllerWilayah.getProv();
    controllerWilayah.getKondisi();
    controllerWilayah.getMerek();
    controllerWilayah.getJarakTempuh();
    controllerWilayah.getBahanBakar();
    controllerWilayah.getTransmisi();
    controllerWilayah.getWarna();
    controllerWilayah.getTujuanPenggunaan();
    getDetailInfoUnit();
    benar = true;
    bisaTambah = true;
    if(mounted){
      isComplete = false;
    }
  }

  bool viewOnly = false;
  checkAccess() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    if(value.userData!.role == 'Marketing Head' || value.userData!.role == 'Eksternal'){
      setState(() {
        viewOnly = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  var debouncher = new Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      setState(() {
        fNopol.unfocus();
        fCatatan.unfocus();
        fHarga.unfocus();
        ttttt.unfocus();
      });
    }, child: GetBuilder<ControllerWilayah>(builder: (v) {
      return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.namePipeline, style: TextStyle(color: Colors.black, fontSize: 16,)),
                  Text("#" + widget.lead_id.toString(), style: TextStyle(fontSize: 12, color: Colors.black,)),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: load
                ? widgetLoadPrimary()
                : Column(children: [
                    SizedBox(height: 30,),
                    Center(
                      child: Text("Edit Informasi Unit", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Spesifikasi unit", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                        ),
                        SizedBox(height: 15,),
                        textFieldLogin(
                          onChanged: (v) {
                            validasiInput(v);
                          },
                          focusNode: fNopol,
                          label: "Nomor Polisi",
                          controller: nopol,
                          type: TextInputType.text,
                          messageApi: message,
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding),
                        ttt(
                          controller: ckondisi,
                          items: v.loadKondisi ? [] : v.kondisi!.data!,
                          value: selectedKondisi,
                          label: v.loadKondisi ? "Memuat..." : "Kondisi Mobil",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding),
                        ttt(
                            label: v.loadMerek ? "Memuat..." : "Merek",
                            value: selectedmerek,
                            controller: cmerek,
                            items: v.loadMerek? []: v.merek == null? []: v.merek!.data!,
                            enable: viewOnly ? false:true
                        ),

                        SizedBox(height: yd_defauld_padding),
                        ttt(
                          controller: cmodel,
                          items: v.loadModel? []: v.model == null? []: v.model!.data!,
                          value: selectedModel,
                          label: v.loadModel ? "Memuat..." : "Model",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding),
                        ttt(
                          controller: cvarian,
                          items: v.loadVarian? []: v.varian == null? []: v.varian!.data!,
                          value: selectedVarian,
                          label: v.loadVarian ? "Memuat..." : "Varian",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding,),
                        ttt(
                          controller: cTahun,
                          items: listTahun,
                          value: selectedTahun,
                          label: "Tahun",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding,),
                        ttt(
                          controller: cjarak,
                          items: v.loadJarakTempuh ? [] : v.jarakTempuh!.data!,
                          value: selectedJarakTempuh,
                          label: v.loadJarakTempuh ? "Memuat..." : "Jarak Tempuh",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding,),
                        ttt(
                          controller: cbahanbakar,
                          items: v.loadBahanBakar ? [] : v.bahanBakar!.data!,
                          value: selectedBahanBakar,
                          label: v.loadBahanBakar ? "Memuat..." : "Bahan Bakar",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding),
                        ttt(
                          controller: cTransmisi,
                          items: v.loadTransmisi ? [] : v.transmisi!.data!,
                          value: selectedTransmisi,
                          label: v.loadTransmisi ? "Memuat..." : "Transmisi",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding),
                        ttt(
                          controller: cWarna,
                          items: v.loadWarna ? [] : v.warna!.data!,
                          value: selectedWarna,
                          label: v.loadWarna ? "Memuat..." : "Warna",
                          enable: viewOnly ? false:true
                        ),
                        SizedBox(height: yd_defauld_padding,),
                        textFieldLogin(
                          label: "Catatan",
                          focusNode: fCatatan,
                          controller: catatan,
                          type: TextInputType.multiline,
                          onChanged: (v)=>setComplete(),
                        ),
                        SizedBox(height: yd_defauld_padding),
                        textFieldLogin(
                          label: "Harga",
                          focusNode: fHarga,
                          controller: harga,
                          type: TextInputType.number,
                          onChanged: (v)=>setComplete(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Lokasi unit", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                      ),
                      SizedBox(height: 15,),
                      ttt(
                        controller: cprov,
                        items: v.loadProv? []: v.prov == null? []: v.prov!.data!,
                        value: seledtedProv,
                        label: v.loadProv ? "Memuat..." : "Provinsi",
                        enable: viewOnly ? false:true
                      ),
                      SizedBox(height: yd_defauld_padding,),
                      ttt(
                        controller: ckab,
                        items: v.loadKota? []: v.kota == null? []: v.kota!.data!,
                        value: seledtedKotaKab,
                        label: v.loadKota ? "Memuat..." : "Kota/Kabupaten",
                        enable: viewOnly ? false:true
                      ),
                      SizedBox(height: yd_defauld_padding,),
                      ttt(
                        controller: ckec,
                        items: v.loadKec? []: v.kec == null? []: v.kec!.data!,
                        value: seledtedKec,
                        label: v.loadKec ? "Memuat..." : "Kecamatan",
                        enable: viewOnly ? false:true
                      ),
                      SizedBox(height: yd_defauld_padding,),
                    ]),
                    SizedBox(height: yd_defauld_padding * 2),
                    GestureDetector(
                        onTap: ()=>isComplete ? updateInfoUnit():null,
                        child: buttonDefaulLogin(
                            backGround: isComplete ? yd_Color_Primary:yd_Color_Primary_Grey.withOpacity(0.3),
                            textColor: Colors.white,
                            text: "Simpan"),
                    ),
                    SizedBox(height: yd_defauld_padding)
                  ]),
          ),
        ),
      );
    }));
  }
}