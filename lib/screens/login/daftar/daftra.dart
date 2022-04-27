import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/login/components/validation_isEmail.dart';
import 'package:yodacentral/screens/login/daftar/components/menu_components.dart';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);
  static String routeName = "/daftar";

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  FocusNode fEmail = new FocusNode();
  FocusNode fPassword = new FocusNode();
  FocusNode fPassword2 = new FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  bool char8_20 = false;
  bool number1 = false;
  bool capital1 = false;
  bool small1 = false;
  bool isEmal = false;
  bool isSame = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fPassword.addListener(() {
      // print("Has focus: ${fPassword.hasFocus}");
    });
  }

  cekIsChar8_20({String? v}) {
    setState(() {
      if (v!.length < 8 || v.length > 20) {
        char8_20 = false;
        // log("tidak valid ${v.length}");
      } else {
        char8_20 = true;
      }
    });
  }

  cekIsNumber({String? v}) {
    setState(() {
      if (v!.isOneDigits()) {
        number1 = true;
      } else {
        number1 = false;
      }
    });
  }

  cekIsCapital({String? v}) {
    setState(() {
      if (v!.isOneCapital()) {
        capital1 = true;
      } else {
        capital1 = false;
      }
    });
  }

  cekIsSmall({String? v}) {
    // log(v.toString(), name: "ini small");
    setState(() {
      if (v!.isOneSmall()) {
        small1 = true;
      } else if (v.isEmpty || v.length <= 0) {
        small1 = false;
      } else {
        small1 = false;
      }
    });
  }

  // cekIsSama({String? v}){

  // }
  bool hidden = true;
  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    bool? autoFoc = false,
    String? message,
    bool? show = true,
    Widget? sufix,
  }) {
    return TextFormField(
      autofocus: autoFoc!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        // log("message");
        if (label == "Email") {
          if (v!.isValidEmail()) {
            return null;
          } else {
            return "Masukan email dengan benar";
          }
        } else if (label == "Konfirmasi Kata Sandi") {
          if (v == password.text) {
            return null;
          } else {
            return "Kata sandi tidak sama";
          }
          // if (focusNode.hasFocus) {
          //   if (v!.length < 1) {
          //     return null;
          //   } else {
          //     if (v == password.text) {
          //       return null;
          //     } else {
          //       return "Kata sandi tidak sama";
          //     }
          //   }
          // }
        }
      },
      controller: controller,
      onChanged: (v) {
        if (label == "Kata Sandi") {
          setState(() {
            if (v.isEmpty) {
              small1 = false;
              number1 = false;
              log("kosong", name: "ini daftar");
            } else {
              cekIsChar8_20(v: v);
              cekIsNumber(v: v);
              cekIsCapital(v: v);
              cekIsSmall(v: v);
            }
          });
        } else if (label == "Konfirmasi Kata Sandi") {
          setState(() {
            if (v == password.text) {
              isSame = true;
            } else {
              isSame = false;
            }
          });
        } else if (label == "Email") {
          setState(() {
            if (v.isValidEmail()) {
              isEmal = true;
            } else {
              isEmal = false;
            }
          });
        }
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        labelText: label,
        // hintText: label,
        suffixIcon: label == "Kata Sandi" || label == "Konfirmasi Kata Sandi"
            ? sufix
            : null,
        errorText: message ?? null,
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
      obscureText: label == "Kata Sandi" || label == "Konfirmasi Kata Sandi"
          ? show!
          : false,
    );
  }

  bool vis = false;
  bool vis2 = false;

  ControllerAuth auth = Get.put(ControllerAuth());
  Regis regis = Get.put(Regis());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fEmail.unfocus();
        fPassword.unfocus();
        fPassword2.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: SizedBox.expand(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(yd_defauld_padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Buat Akun Baru",
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
                            GetBuilder<Regis>(builder: (va) {
                              return textFieldLogin(
                                autoFoc: true,
                                controller: email,
                                focusNode: fEmail,
                                label: "Email",
                                type: TextInputType.emailAddress,
                                message: va.res422Regis,
                                onChanged: (v) {
                                  setState(() {});
                                },
                              );
                            }),

                            SizedBox(
                              height: yd_defauld_padding + 5,
                            ),
                            Focus(
                              onFocusChange: (v) {
                                setState(() {
                                  vis = v;
                                });
                              },
                              child: OverlayTes(
                                chil: textFieldLogin(
                                  controller: password,
                                  focusNode: fPassword,
                                  label: "Kata Sandi",
                                  type: TextInputType.text,
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                  show: hidden,
                                  sufix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hidden ? hidden = false : hidden = true;
                                      });
                                    },
                                    child: Icon(
                                      hidden
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      color: yd_Color_Primary_Grey,
                                    ),
                                  ),
                                ),
                                visible: vis,
                                children: [
                                  MenuItem(
                                    onComplete: char8_20,
                                    text: "8 - 20 Karakter",
                                  ),
                                  MenuItem(
                                    onComplete: number1,
                                    text: "1 Angka",
                                  ),
                                  MenuItem(
                                    onComplete: capital1,
                                    text: "1 Huruf Kapital",
                                  ),
                                  MenuItem(
                                    onComplete: small1,
                                    text: "1 Huruf kecil",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: yd_defauld_padding + 5,
                            ),
                            textFieldLogin(
                              controller: password2,
                              focusNode: fPassword2,
                              label: "Konfirmasi Kata Sandi",
                              type: TextInputType.text,
                              onChanged: (v) {
                                setState(() {});
                              },
                              show: hidden,
                              sufix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hidden ? hidden = false : hidden = true;
                                  });
                                },
                                child: Icon(
                                  hidden
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: yd_Color_Primary_Grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: yd_defauld_padding * 2,
                            ),
                            _formKey.currentState == null
                                ? buttonDefaulLogin(
                                    backGround:
                                        yd_Color_Primary_Grey.withOpacity(0.2),
                                    textColor: yd_Color_Primary_Grey,
                                    text: "Selanjutnya")
                                : char8_20 &&
                                        number1 &&
                                        capital1 &&
                                        small1 &&
                                        isSame &&
                                        isEmal
                                    ? GestureDetector(
                                        onTap: () {
                                          regis.regis(
                                            email: email.text,
                                            pw: password.text,
                                          );
                                        },
                                        child: buttonDefaulLogin(
                                          backGround: yd_Color_Primary,
                                          textColor: Colors.white,
                                          text: "Selanjutnya",
                                        ),
                                      )
                                    : buttonDefaulLogin(
                                        backGround: yd_Color_Primary_Grey
                                            .withOpacity(0.2),
                                        textColor: yd_Color_Primary_Grey,
                                        text: "Selanjutnya"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
