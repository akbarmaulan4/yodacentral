import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/maskeddd.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';
import 'package:yodacentral/utils/debouncher.dart';

import '../add_new_lead_financing.dart';

class CekNomorPolisi extends StatefulWidget {
  const CekNomorPolisi({
    Key? key,
    required this.isFinancing,
    // required this.toChangePage,
  }) : super(key: key);

  final bool isFinancing;

  // final ValueChanged<int>? toChangePage;

  @override
  _CekNomorPolisiState createState() => _CekNomorPolisiState();
}

class _CekNomorPolisiState extends State<CekNomorPolisi>
    with AutomaticKeepAliveClientMixin {
  bool loadCek = false;
  String? message;
  ControllerAddLeadFinancing addLeadFinancing = Get.put(ControllerAddLeadFinancing());

  var debouncher = new Debouncer(milliseconds: 500);

  cekNomerKendaraan() async {
    modalLoad();
    setState(() {
      loadCek = true;
      message = null;
    });

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ ApiUrl.cekNomerKendaraan.toString()}';

    var res = await http.post(Uri.parse(url.trim()), body: {'police_number': addLeadFinancing.edtNopol.text}, headers: {'Authorization': 'Bearer ' + value.token.toString()});

    if (res.statusCode == 200) {
      log(res.body);
      setState(() {
        loadCek = true;
        message = null;
      });

      if (Get.isBottomSheetOpen == true) Get.back();
      addLeadFinancing.inputNopol(nopol: addLeadFinancing.edtNopol.text);
      Get.dialog(
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: DialogNopol(
            isFinancing: widget.isFinancing,
            nopol: addLeadFinancing.edtNopol.text,
            toChangePage: (v) {
              // setState(() {
              //   // widget.toChangePage!(v);
              // });
            },
          ),
        ),
        barrierColor: Color(0xFF0D0A19).withOpacity(0.75),
      );
    } else {
      log(res.body);
      setState(() {
        loadCek = true;
        message = json.decode(res.body)["message"];
      });
      if (Get.isBottomSheetOpen == true) Get.back();
    }
  }

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
  }) {
    return TextFormField(
      inputFormatters: [
        UpperCaseTextFormatter(),
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
      ],
      textCapitalization: TextCapitalization.characters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {},
      controller: controller,
      onChanged: (v) {
        onChanged(v);
        // debouncher.run(() {
        //   // if(val[0] == '0'){
        //   //   widget.bloc.edtNoTlp.text = val.substring(1);
        //   //   var str = widget.bloc.edtNoTlp.text;
        //   //   // widget.bloc.edtNoTlp.text = val;
        //   //   widget.bloc.edtNoTlp.selection = TextSelection.fromPosition(TextPosition(offset: str.length));
        //   // }
        //   addLeadFinancing.validasiInput(v);
        // });

        // setState(() {
        //   nomerPol = v;
        //   ceking(s: v);
        //   // log(v);
        // });
        // log(controller.text, name: "ini controller");
        // log(nomerPol!, name: "ini var");
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        errorText: messageApi == null ? null : messageApi,
        labelText: label,
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
    );
  }

  FocusNode fNopol = new FocusNode();
  TextEditingController nopol = MaskedTextController(mask: 'AA 0000 AAA');
  String? nomerPol = "";
  var maskedController = MaskedTextController(mask: 'A 0 a');

  // ^[A-Z]{2}\s[0-9]{1,2}\s[A-Z]{1,2}\s[0-9]{1,4}$
  final cek = RegExp(r'[A-Z]{1,2}\s[0-9]{1,4}\s[A-Z]{1,3}$');
  // final cek = RegExp(r'[A-Z]{1,2}$');
  // "A 01 G"
  // "A 01 GB"
  // "AE 5677 TR"

  bool benar = false;

  ceking({String? s}) {
    if (cek.hasMatch(s!) == true) {
      log(cek.hasMatch(s).toString(), name: "ini benar");
      setState(() {
        benar = true;
        message = null;
        // cekidleNomerKendaraan();
      });
    } else {
      log(cek.hasMatch(s).toString(), name: "ini salah");
      setState(() {
        benar = false;
        message = "Nomor polisi tidak valid";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          fNopol.unfocus();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: widget.isFinancing
              ? Text("Tambah Lead Financing", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,))
              : Text("Tambah Lead Refinancing", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,)),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => CustomDialog(),
                  barrierColor: Color(0xFF0D0A19).withOpacity(0.75),
                );
              },
              child: Text("Batalkan", style: TextStyle(fontWeight: FontWeight.bold, color: yd_Color_Primary,)),
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: yd_Color_Primary.withOpacity(0.3),
                height: 5,
                width: Get.width,
                child: Stack(
                  children: [
                    AnimatedContainer(duration: Duration(milliseconds: 300,), color: yd_Color_Primary, height: 5, width: 0,)
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(5),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 45,),
            Center(
              child: Text("Cek Nomor Polisi Kendaraan", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(yd_defauld_padding),
              child: textFieldLogin(
                onChanged: (v) {
                  validasiInput(v);
                },
                focusNode: fNopol,
                label: "Nomor polisi",
                controller: addLeadFinancing.edtNopol,
                type: TextInputType.text,
                messageApi: message,
              ),
            ),
          ],
        ),
        bottomNavigationBar: !benar
            ? GestureDetector(
                onTap: () {},
                child: buttonDefaulLogin(
                    backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                    textColor: Colors.white,
                    text: "Selanjutnya"),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    fNopol.unfocus();
                  });
                  cekNomerKendaraan();
                },
                child: buttonDefaulLogin(
                    backGround: yd_Color_Primary,
                    textColor: Colors.white,
                    text: "Selanjutnya"),
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
        if(strNopol.contains(' ')){
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
        }else{
          if(strNopol.contains(new RegExp(r'[A-Z]'))){
            strNopol = strNopol+ " "+param[i];
            setState(() {
              benar = true;
              message = null;
            });
          }else{
            strNopol = '';
            setState(() {
              benar = false;
              message = null;
            });
          }
        }
      }
    }
    addLeadFinancing.edtNopol.value = TextEditingValue(
        text: strNopol,
        selection: TextSelection.collapsed(offset: strNopol.length));
    // addLeadFinancing.edtNopol.text = strNopol;
    // addLeadFinancing.edtNopol.selection = TextSelection.fromPosition(TextPosition(offset: strNopol.length));
    if(strNopol.split(' ').length > 2){
      // FocusScope.of(context).requestFocus(new FocusNode());
      ceking(s: strNopol);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addLeadFinancing.edtNopol.text = '';

  }
}


class DialogNopol extends StatefulWidget {
  const DialogNopol(
      {Key? key,
      required this.nopol,
      required this.toChangePage,
      required this.isFinancing})
      : super(key: key);
  final String nopol;
  final ValueChanged<int>? toChangePage;
  final bool isFinancing;

  @override
  _DialogNopolState createState() => _DialogNopolState();
}

class _DialogNopolState extends State<DialogNopol> {
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(yd_defauld_padding * 2),
        ),
      ),
      backgroundColor: Color(0xFFEDF5F4),
      insetPadding: EdgeInsets.symmetric(
        horizontal: yd_defauld_padding * 2,
        vertical: Get.height / 3,
      ),
      child: Padding(
        padding: EdgeInsets.all(yd_defauld_padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daftarkan Unit",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  widget.nopol + " ?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: yd_defauld_padding,
                ),
                Text(
                  "Pastikan anda telah memasukan nomor polisi dengan benar",
                  style: TextStyle(
                    color: Color(0xFF3F4947),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Batal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: yd_Color_Primary),
                  ),
                ),
                SizedBox(
                  width: yd_defauld_padding * 2,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.offAll(() => Wraping());
                    log("lanjut");
                    Get.back();
                    Get.to(() => AddNewLeadFinancing(isFinancing: widget.isFinancing));
                    addLeadFinancing.inputNopol(nopol: widget.nopol);
                  },
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: yd_Color_Primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//  final cek = RegExp(r'[A-Z]{1,2}\s[0-9]{1,4}\s[A-Z]{1,3}$');

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // log(newValue.text, name: "ini nomer polisi newvalue");
    // log(oldValue.text, name: "ini nomer polisi old");

    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
