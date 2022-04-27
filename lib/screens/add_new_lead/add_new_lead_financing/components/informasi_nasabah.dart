import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/maskeddd.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_wilayah/controller_wilayah.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;

class InformasiNasabah extends StatefulWidget {
  const InformasiNasabah({Key? key, required this.toChangePage})
      : super(key: key);
  final ValueChanged<int>? toChangePage;

  @override
  _InformasiNasabahState createState() => _InformasiNasabahState();
}

class _InformasiNasabahState extends State<InformasiNasabah>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  ControllerAddLeadFinancing addLeadFinancing = Get.put(ControllerAddLeadFinancing());
  bool na = false;
  bool pho = false;
  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    bool? show = true,
    String? messageApi,
    Widget? sufix,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        if (label == "Nomor KTP") CreditCardFormatter(),
      ],
      validator: (v) {
        if (label == "Nama Lengkap Sesuai KTP") {
          if (v!.isEmpty || v.length > 254) {
            return "Masukkan nama yang benar";
          } else {
            return null;
          }
        } else if (label == "Nomor Telepon") {
          if (v!.length < 10 || v.length > 15) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor KTP") {
          if (v!.length < 19 || v.length > 19) {
            return "Nomor KTP tidak valid";
          }
        }
      },
      controller: controller,
      onChanged: (v) {
        setState(() {
          if (label == "Nama Lengkap Sesuai KTP") {
            if (v.isEmpty || v.length > 254) {
              na = false;
            } else {
              na = true;
            }
          } else if (label == "Nomor Telepon") {
            if (v.length < 10 || v.length > 15) {
              pho = false;
            } else {
              pho = true;
            }
          }
        });

        log(controller.text);
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        errorText: messageApi == null ? null : messageApi,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        labelText: label,
        prefix: label == "Nomor Telepon"
            ? Text(
                "+62 ",
                style: TextStyle(color: yd_Color_Primary_Grey),
              )
            : null,
        suffixIcon: label == "Kata Sandi" ? sufix : null,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      obscureText: label == "Kata Sandi" ? show! : false,
    );
  }

  ControllerWilayah controllerWilayah = Get.put(ControllerWilayah());
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController nomorKtp = TextEditingController();
  TextEditingController phone = MaskedTextController(mask: '000 0000 00000');

  FocusNode fNamaLengkap = new FocusNode();
  FocusNode fnomorKtp = new FocusNode();
  FocusNode fPhone = new FocusNode();

  // ModelWilayah? prov;
  // Datum? seledtedProv;
  // Datum? seledtedKotaKab;
  // Datum? seledtedKec;

  // final GlobalKey<FormFieldState> _kot = GlobalKey<FormFieldState>();
  // final GlobalKey<FormFieldState> _kec = GlobalKey<FormFieldState>();
  // final GlobalKey<FormFieldState> _prov = GlobalKey<FormFieldState>();

  Datum? seledtedProv;
  TextEditingController cprov = TextEditingController();
  Datum? seledtedKotaKab;
  TextEditingController ckab = TextEditingController();
  Datum? seledtedKec;
  TextEditingController ckec = TextEditingController();

  Widget ttt({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController controller,
  }) {
    return TypeAheadField<Datum?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
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
            // hintText: label,
            labelText: label,
            labelStyle: TextStyle(
              color: yd_Color_Primary_Grey,
            )),
      ),
      suggestionsCallback: (search) {
        return items!
            .where((element) =>
                element.name!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, Datum? datum) {
        return ListTile(
          title: Text(datum!.name!),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text(
            'tidak ditemukan',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      onSuggestionSelected: (Datum? data) {

        if (items!.length <= 0 || items.isEmpty) {
          // log("disable");
        } else {
          if (label == "Provinsi") {
            clearKotKec();

            setState(() {
              seledtedKotaKab = null;
              seledtedKec = null;
            });
            getKota(id: (data)!.id!);
          } else if (label == "Kota/Kabupaten") {
            clearKec();
            setState(() {
              seledtedKec = null;
              ckab.clear();
            });
            getKec(id: (data)!.id!);
          }
        }
        if (label == "Provinsi") {
          setState(() {
            controller.text = data!.name!;
            seledtedProv = data;
            ckab.clear();
            ckec.clear();
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
      },
    );
  }

  ModelWilayah? prov;
  ModelWilayah? kota;
  ModelWilayah? kec;

  bool loadProv = false;
  bool loadKota = false;
  bool loadKec = false;

  clearKotKec() {
    setState(() {
      kec = null;
      kota = null;
    });
  }

  clearKec() {
    setState(() {
      kec = null;
    });
  }

  getProv() async {
    setState(() {
      loadProv = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = Uri.tryParse(
        ApiUrl.domain.toString() + ApiUrl.prov.toString(),
      );
      var res = await http.get(url!, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadProv = false;
          prov = modelProvinsiFromMap(res.body);

          log(res.body);
        });
      } else {
        setState(() {
          loadProv = false;
          log(res.body);
        });
      }
    });
  }

  getKota({required int id}) async {
    setState(() {
      loadKota = true;
    });

    SaveRoot.callSaveRoot().then((value) async {
      var url = Uri.tryParse(
        ApiUrl.domain.toString() + ApiUrl.kotaKab.toString() + id.toString(),
      );
      var res = await http.get(url!, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadKota = false;
          kota = modelProvinsiFromMap(res.body);
          log(res.body);
        });
      } else {
        setState(() {
          loadKota = false;
          log(res.body);
        });
      }
    });
  }

  getKec({required int id}) async {
    setState(() {
      loadKec = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = Uri.tryParse(
        ApiUrl.domain.toString() + ApiUrl.kec.toString() + id.toString(),
      );
      var res = await http.get(url!, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadKec = false;
          kec = modelProvinsiFromMap(res.body);
          log(res.body);
        });
      } else {
        setState(() {
          loadKec = false;
          log(res.body);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProv();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          fNamaLengkap.unfocus();
          fnomorKtp.unfocus();
          fPhone.unfocus();
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Informasi Nasabah",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Data diri", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
              ),
              SizedBox(height: 10),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(children: [
                    textFieldLogin(
                      onChanged: (v) {},
                      focusNode: fNamaLengkap,
                      label: "Nama Lengkap Sesuai KTP",
                      controller: namaLengkap,
                    ),
                    SizedBox(height: 15),
                    textFieldLogin(
                        onChanged: (v) {},
                        focusNode: fnomorKtp,
                        label: "Nomor KTP",
                        controller: nomorKtp,
                        type: TextInputType.number),
                    SizedBox(height: 15),
                    Focus(
                      onFocusChange: (v) {
                        setState(() {
                          !v
                              ? phone.text =
                                  phone.text.replaceFirst(RegExp(r'^0+'), "")
                              : log("sedang aktif");
                        });
                      },
                      child: textFieldLogin(
                        controller: phone,
                        focusNode: fPhone,
                        label: "Nomor Telepon",
                        type: TextInputType.phone,
                        onChanged: (v) {
                          setState(() {});
                        },
                      ),
                    ),
                  ])),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Domisili",
                    style: TextStyle(
                      color: yd_Color_Primary_Grey,
                      fontSize: 12,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(children: [
                  ttt(
                    controller: cprov,
                    items: loadProv
                        ? []
                        : prov == null
                            ? []
                            : prov!.data!,
                    value: seledtedProv,
                    label: loadProv ? "Memuat..." : "Provinsi",
                  ),
                  SizedBox(
                    height: yd_defauld_padding,
                  ),
                  ttt(
                    controller: ckab,
                    items: loadKota
                        ? []
                        : kota == null
                            ? []
                            : kota!.data!,
                    value: seledtedKotaKab,
                    label: loadKota ? "Memuat..." : "Kota/Kabupaten",
                  ),
                  SizedBox(
                    height: yd_defauld_padding,
                  ),
                  ttt(
                    controller: ckec,
                    items: loadKec
                        ? []
                        : kec == null
                            ? []
                            : kec!.data!,
                    value: seledtedKec,
                    label: loadKec ? "Memuat..." : "Kecamatan",
                  ),
                  SizedBox(
                    height: yd_defauld_padding,
                  ),
                ]),
              ),
              _formKey.currentState == null ||
                      seledtedProv == null ||
                      seledtedKec == null ||
                      seledtedKotaKab == null ||
                  namaLengkap.text == '' ||
                  nomorKtp.text == '' ||
                  (nomorKtp.text.length < 19 || nomorKtp.text.length > 19) ||
                  phone.text == ''||
                  (phone.text.length < 10 || phone.text.length > 15)
                  ? buttonDefaulLogin(
                      backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                      textColor: Colors.white,
                      text: "Simpan")
                  : GestureDetector(
                      onTap: () {
                        addLeadFinancing.inputDataNasabah(
                          provinsi: seledtedProv!,
                          kotaKabupaten: seledtedKotaKab!,
                          kecamatan: seledtedKec!,
                          nama: namaLengkap.text,
                          nomorKtp: nomorKtp.text,
                          nomorTlp: phone.text,
                        );
                        setState(() {
                          widget.toChangePage!(4);
                        });
                      },
                      child: buttonDefaulLogin(
                          backGround: yd_Color_Primary,
                          textColor: Colors.white,
                          text: "Simpan"),
                    ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
