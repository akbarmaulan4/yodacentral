import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/screens/login/components/validation_isEmail.dart';

import 'components/button_default_login.dart';
import 'daftar/daftra.dart';
import 'email_send.dart/email_send.dart';
import 'lupa_kata_sandi/lupa_kata_sandi.dart';
import 'package:device_info/device_info.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode fEmail = new FocusNode();
  FocusNode fPassword = new FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidden = true;

  ControllerAuth auth = Get.put(ControllerAuth());

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
      validator: (v) {
        if (v == null || v.length == 0) {
          return null;
        } else {
          if (label == "Email") {
            if (v.isValidEmail()) {
              return null;
            } else {
              return "Masukan email dengan benar";
            }
          }
        }
      },
      controller: controller,
      onChanged: (v) {
        setState(() {
          // log(v);
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
        // hintText: label,
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

  final _formKey = GlobalKey<FormState>();
  bool remember = true;
  String device = "";
  Future<void> initPlatformState() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log(androidInfo.brand, name: "brand android");

      log(androidInfo.model, name: "model android");

      if(mounted){
        setState(() {
          device = androidInfo.brand + " " + androidInfo.model;
        });
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      log(iosInfo.utsname.machine, name: "brand ios");
      log(iosInfo.model, name: "model ios");
      setState(() {
        device = iosInfo.utsname.machine + " " + iosInfo.model;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fEmail.unfocus();
          fPassword.unfocus();
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: false,
        backgroundColor: yd_Color_White,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: yd_defauld_padding),
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Image.asset(
                      "assets/images/Masuk-Logo Yodacentral - screenview 1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  GetBuilder<ControllerAuth>(
                      init: ControllerAuth(),
                      builder: (vv) {
                        return Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                            children: [
                              textFieldLogin(
                                label: "Email",
                                focusNode: fEmail,
                                controller: email,
                                type: TextInputType.emailAddress,
                                onChanged: (v) {},
                                messageApi: vv.errorEmail,
                              ),
                              SizedBox(
                                height: yd_defauld_padding + 5,
                              ),
                              textFieldLogin(
                                label: "Kata Sandi",
                                focusNode: fPassword,
                                controller: password,
                                onChanged: (v) {},
                                messageApi: vv.errorKataSandi,
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
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: yd_defauld_padding * 2 - 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RadioCus(
                        onTap: (v) {
                          setState(() {
                            remember = v;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => LupaKataSandi(),
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                          );
                        },
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: yd_Color_Primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: yd_defauld_padding * 2,
                  ),
                  _formKey.currentState == null
                      ? buttonDefaulLogin(
                          backGround: yd_Color_Primary_Grey.withOpacity(0.2),
                          textColor: yd_Color_Primary_Grey,
                          text: "Masuk")
                      : _formKey.currentState!.validate() &&
                              email.text.length > 0 &&
                              password.text.length > 0
                          ? GestureDetector(
                              onTap: () {
                                auth.login(
                                  email: email.text,
                                  kata_sandi: password.text,
                                  remember: remember,
                                  device: device,
                                );
                              },
                              child: buttonDefaulLogin(
                                backGround: yd_Color_Primary,
                                textColor: Colors.white,
                                text: "Masuk",
                              ),
                            )
                          : buttonDefaulLogin(
                              backGround:
                                  yd_Color_Primary_Grey.withOpacity(0.2),
                              textColor: yd_Color_Primary_Grey,
                              text: "Masuk"),
                  SizedBox(
                    height: yd_defauld_padding,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (v) => Daftar(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          " Daftar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: yd_Color_Primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: Get.width,
          height: 40,
          child: Center(
            child: Text("v.1.0.7.10"),
          ),
        ),
      ),
    );
  }
}

class RadioCus extends StatefulWidget {
  const RadioCus({Key? key, this.onTap}) : super(key: key);
  final ValueChanged<bool>? onTap;

  @override
  _RadioCusState createState() => _RadioCusState();
}

class _RadioCusState extends State<RadioCus> {
  bool active = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          !active ? active = true : active = false;
          active ? widget.onTap!(true) : widget.onTap!(false);
        });
      },
      child: Row(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.all(3),
            duration: Duration(
              milliseconds: 100,
            ),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: !active ? yd_Color_Primary_Grey : yd_Color_Primary,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: 100,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !active ? Colors.transparent : yd_Color_Primary,
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Ingat saya",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
