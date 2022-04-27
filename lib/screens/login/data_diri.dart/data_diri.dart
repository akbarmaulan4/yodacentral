import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/maskeddd.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_biodata/controller_biodata.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({Key? key}) : super(key: key);

  @override
  _DataDiriState createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  FocusNode fName = new FocusNode();
  FocusNode fPhone = new FocusNode();
  TextEditingController name = TextEditingController();
  TextEditingController phone = MaskedTextController(mask: '000 0000 00000');
  final _formKey = GlobalKey<FormState>();
  ControllerBiodata controllerBiodata = Get.put(ControllerBiodata());
  String? finalNumberTelp;
  @override
  void initState() {
    super.initState();
    // fPhone.addListener(() {
    //   if (fPhone.hasFocus) {
    //     log("fphone sedang fokus");
    //   } else {
    //     // }

    //     log("fphone tidak fokus");
    //   }
    // });
  }

  bool na = false;
  bool pho = false;

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    bool? autoFoc = false,
    String? message,
  }) {
    return TextFormField(
      autofocus: autoFoc!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        // string.substring(1, string.length()-1);
      },
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
        }
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        errorText: message ?? null,
        prefix: label == "Nomor Telepon" ? Text("+62 ", style: TextStyle(color: yd_Color_Primary_Grey)) : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        labelText: label,
        labelStyle: TextStyle(color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fName.unfocus();
          fPhone.unfocus();
        });
      },
      child: Container(
        color: yd_Color_Primary_Grey,
        child: Padding(
          padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Scaffold(
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(yd_defauld_padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(),
                                  barrierColor: Colors.black.withOpacity(0.7));
                            },
                            child: Center(
                              child: Text(
                                "Batalkan",
                                style: TextStyle(
                                  color: yd_Color_Primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: yd_defauld_padding * 2,
                      ),
                      Text(
                        "Data Diri",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: yd_defauld_padding * 2,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            textFieldLogin(
                              autoFoc: true,
                              controller: name,
                              focusNode: fName,
                              label: "Nama Lengkap Sesuai KTP",
                              type: TextInputType.text,
                              onChanged: (v) {
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: yd_defauld_padding + 5,
                            ),
                            GetBuilder<ControllerBiodata>(builder: (op) {
                              // log(op == null ?  );
                              return Focus(
                                onFocusChange: (v) {
                                  setState(() {
                                    !v
                                        ? phone.text = phone.text
                                            .replaceFirst(RegExp(r'^0+'), "")
                                        : log("sedang aktif");

                                    // 'XPT OXXS FXBA C';
                                    // x.substring(0, 4) + " " + x.substring(4, 8) + " " + x.substring(8, x.length)
                                  });
                                },
                                child: textFieldLogin(
                                  controller: phone,
                                  focusNode: fPhone,
                                  label: "Nomor Telepon",
                                  type: TextInputType.phone,
                                  message: op.messageTlp ?? null,
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                ),
                              );
                            }),
                            SizedBox(
                              height: yd_defauld_padding * 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: na && pho
                  ? GestureDetector(
                      onTap: () {
                        // String notlp = phone.text.substring(0, 3).toString() +
                        //     " " +
                        //     phone.text.substring(3, 7).toString() +
                        //     " " +
                        //     phone.text.substring(7, 11).toString();

                        controllerBiodata.cekNomerTlp(
                          nomerTlp: phone.text,
                          nama: name.text,
                        );

                        // controllerBiodata.setNamaTlp(
                        //   namaLengkapRegis: name.text,
                        //   nomerTlpRegis: phone.text,
                        // );
                        // Get.to(
                        //   () => UploadFotoProfil(),
                        //   transition: Transition.noTransition,
                        // );
                      },
                      child: buttonDefaulLogin(
                        backGround: yd_Color_Primary,
                        textColor: Colors.white,
                        text: "Selanjutnya",
                      ),
                    )
                  : buttonDefaulLogin(
                      backGround: yd_Color_Primary_Grey.withOpacity(0.2),
                      textColor: yd_Color_Primary_Grey,
                      text: "Selanjutnya"),
            ),
          ),
        ),
      ),
    );
  }
}
