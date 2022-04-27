import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/login/components/validation_isEmail.dart';
import 'package:yodacentral/screens/login/daftar/components/menu_components.dart';
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';
import 'package:http/http.dart' as http;

class UbahKataSandi extends StatefulWidget {
  const UbahKataSandi(
      {Key? key, required this.isProfile, required this.email, this.token})
      : super(key: key);
  final bool isProfile;
  final String email;
  final String? token;
  @override
  _UbahKataSandiState createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  FocusNode fEmail = new FocusNode();
  FocusNode fPassword = new FocusNode();
  FocusNode fPassword2 = new FocusNode();
  bool char8_20 = false;
  bool number1 = false;
  bool capital1 = false;
  bool small1 = false;
  bool isEmal = false;
  bool isSame = false;
  ControllerAuth auth = Get.put(ControllerAuth());

  // String? email01;

  @override
  void initState() {
    super.initState();
    setState(() {
      email.text == auth.modelSaveRoot!.userData!.email!;
      log(email.text);
    });

    log(widget.token == null ? "kosong" : widget.token!);
    log(widget.email);
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

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    bool? autoFoc = false,
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
        } else if (label == "Konfirmasi Kata Sandi Baru") {
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
        if (label == "Kata Sandi Baru") {
          setState(() {
            if (v.isEmpty) {
              small1 = false;
              number1 = false;
              log("kosong", name: "ini ubah kata sandi");
            } else {
              cekIsChar8_20(v: v);
              cekIsNumber(v: v);
              cekIsCapital(v: v);
              cekIsSmall(v: v);
              setState(() {
                if (v == password2.text) {
                  isSame = true;
                } else {
                  isSame = false;
                }
              });
            }
          });
        } else if (label == "Konfirmasi Kata Sandi Baru") {
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
          labelStyle: TextStyle(
            color:
                focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: yd_Color_Primary, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          suffixIcon: sufix),
      obscureText:
          label == "Kata Sandi Baru" || label == "Konfirmasi Kata Sandi Baru"
              ? show
              : false,
    );
  }

  bool vis = false;

  bool show = false;

  sho() {
    setState(() {
      !vis ? vis == true : vis = false;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool foc = false;

  // @override
  // void initState() {
  //   super.initState();
  //   email.text = "Baydim56@gmail.com";
  // }

  buatpw() async {
    modalLoad();
    var url = Uri.tryParse("${ApiUrl.domain.toString()}/api/forget/new-password");
    var res = await http.post(url!, body: {
      'email': widget.email.toString(),
      'token_reset_password': widget.token,
      'password': password.toString(),
    });

    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
            title: "Kata Sandi Diperbarui",
            content: widget.isProfile
                ? "Kata sandi Anda telah berhasil diperbarui."
                : "Kata sandi Anda telah berhasil diperbarui. Silahkan masuk menggunakan kata sandi yang baru.",
            onTap: () {
              widget.isProfile ? Get.back() : Get.offAll(Wraping());
            },
            textButton: "Selesai"),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      );
      log(res.body);
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: res.body,
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(res.body);
    }
  }

  cekToken() async {
    log(password.text);
    modalLoad();
    var url = Uri.tryParse("${ApiUrl.domain.toString()}/api/forget/cek-token");
    var res = await http.post(url!, body: {
      'token_reset_password': widget.token.toString(),
    });
    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      buatpw();

      log(res.body);
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      // rawBottomNotif(
      //   message: json.decode(res.body)["message"],
      //   colorFont: Colors.white,
      //   backGround: Colors.red,
      // );
      log(res.body);
    }
  }

  ubahFromPorfile() async {
    modalLoad();
    SaveRoot.callSaveRoot().then((value) async {
      log(value.token.toString());
      var url = Uri.tryParse("${ApiUrl.domain.toString()}/api/change_password",);

      var res = await http.post(
        url!,
        headers: {'Authorization': 'Bearer ' + value.token.toString()},
        body: {
          'password': password.text,
        },
      );

      if (res.statusCode == 200) {
        log(res.body);
        if (Get.isBottomSheetOpen == true) Get.back();
        Get.back();
        Get.bottomSheet(
          GlobalScreenNotif(
              title: "Kata Sandi Diperbarui",
              content: "Kata sandi Anda telah berhasil diperbarui.",
              onTap: () {
                Get.back();
              },
              textButton: "Tutup"),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
        );
      } else {
        log(res.body);
        if (Get.isBottomSheetOpen == true) Get.back();
        rawBottomNotif(
          message: res.body,
          colorFont: Colors.white,
          backGround: Colors.red,
        );
      }
    });
  }

  Widget newField({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController ctrl,
    TextInputType? type,
    bool? show = true,
    String? messageApi,
    Widget? sufix,
    bool readOnly = false,
    Function()? onTap,
  }) {
    return TextFormField(
      maxLines: type == TextInputType.multiline ? 4 : 1,
      onTap: onTap,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
          CreditCardFormatter(),
      ],
      validator: (v) {
        if (label == "Nama Lengkap Sesuai KTP" ||
            label == "Nama Lengkap Pasangan" ||
            label == "Nama Gadis Ibu Kandung") {
          if (v!.isEmpty || v.length > 254) {
            return "Masukkan nama yang benar";
          } else {
            return null;
          }
        } else if (label == "Nomor Handphone" ||
            label == "Nomor Telepon Institusi") {
          if (v!.length < 10 || v.length > 15) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor KTP" || label == "Nomor KTP Pasangan") {
          if (v!.length <= 0 || v.length > 19) {
            return "Nomor KTP tidak valid";
          }
        }
      },
      controller: ctrl,
      onChanged: (v){
        onChanged(v);
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding:
        label == "Alamat Institusi" || label == "Catatan Pekerjaan"
            ? EdgeInsets.symmetric(horizontal: 15, vertical: 15)
            : EdgeInsets.symmetric(horizontal: 15),
        errorText: messageApi == null ? null : messageApi,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        labelText: label,
        prefix: label == "Nomor Telepon" || label == "Nomor Telepon Institusi"
            ? Text(
          "+62 ",
          style: TextStyle(color: yd_Color_Primary_Grey),
        )
            : null,
        suffixIcon: sufix,
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
      obscureText: label == "Kata Sandi" ? show! : false,
    );
  }

  TextEditingController edtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    email.text == auth.modelSaveRoot!.userData!.email!;
    return GestureDetector(
      onTap: () {
        setState(() {
          fEmail.unfocus();
          fPassword.unfocus();
          fPassword2.unfocus();
          // fPassword.unfocus();
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox.expand(
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 15,
                      right: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.isProfile ? Get.back() : Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          widget.isProfile
                              ? SizedBox(width: 0, height: 0)
                              : GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(),
                                  barrierColor:
                                  Colors.black.withOpacity(0.7));
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
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: yd_defauld_padding * 4,
                      child: Padding(
                        padding: EdgeInsets.all(yd_defauld_padding),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                "Ubah Kata Sandi Anda",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(
                                height: yd_defauld_padding * 2,
                              ),
                              // Text(widget.email),
                              TextFormField(
                                readOnly: true,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (v) {},
                                controller: TextEditingController(
                                    text: auth.modelSaveRoot!.userData!.email!),
                                onChanged: (v) {
                                  setState(() {
                                    // log(v);
                                  });
                                  log(email.text);
                                },
                                focusNode: fEmail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: yd_Color_Primary_Grey.withOpacity(0.5),
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                                  labelText: "Email",
                                  hintText: "Email",
                                  labelStyle: TextStyle(
                                    color:
                                    yd_Color_Primary_Grey.withOpacity(0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: yd_Color_Primary_Grey
                                            .withOpacity(0.1),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: yd_Color_Primary_Grey
                                            .withOpacity(0.5),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: yd_Color_Primary_Grey
                                            .withOpacity(0.5),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: yd_Color_Primary_Grey
                                            .withOpacity(0.1),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
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
                                    sufix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          show ? show = false : show = true;
                                        });
                                      },
                                      child: Icon(
                                        show
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_rounded,
                                        color: yd_Color_Primary_Grey,
                                      ),
                                    ),
                                    controller: password,
                                    focusNode: fPassword,
                                    label: "Kata Sandi Baru",
                                    type: TextInputType.text,
                                    onChanged: (v) {
                                      setState(() {});
                                    },
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
                                sufix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      show ? show = false : show = true;
                                    });
                                  },
                                  child: Icon(
                                    show
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: yd_Color_Primary_Grey,
                                  ),
                                ),
                                focusNode: fPassword2,
                                onChanged: (v) {
                                  setState(() {});
                                },
                                label: "Konfirmasi Kata Sandi Baru",
                                type: TextInputType.text,
                                controller: password2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar:
              char8_20 && number1 && capital1 && small1 && isSame
                  ? GestureDetector(
                onTap: () {
                  widget.isProfile ? ubahFromPorfile() : cekToken();
                },
                child: buttonDefaulLogin(
                    backGround: yd_Color_Primary,
                    textColor: Colors.white,
                    text: "Ubah kata sandi"),
              )
                  : buttonDefaulLogin(
                  backGround: yd_Color_Primary_Grey.withOpacity(0.2),
                  textColor: yd_Color_Primary_Grey,
                  text: "Ubah kata sandi"),
            ),
          ),
        ),
      ),
    );
  }
}
