import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_lupa_sandi/controller_lupa_sandi.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/login/components/validation_isEmail.dart';

class LupaKataSandi extends StatefulWidget {
  const LupaKataSandi({Key? key}) : super(key: key);

  @override
  _LupaKataSandiState createState() => _LupaKataSandiState();
}

class _LupaKataSandiState extends State<LupaKataSandi> {
  TextEditingController email = TextEditingController();
  FocusNode fEmail = new FocusNode();
  ControllerLupaSandi lupaSandi = Get.put(ControllerLupaSandi());

  Widget textFieldLogin(
      {required Function(String) onChanged,
      required FocusNode focusNode,
      required String label,
      required TextEditingController controller,
      TextInputType? type,
      String? msg}) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        if (label == "Email") {
          if (v!.isValidEmail()) {
            return null;
          } else {
            return "Masukan email dengan benar";
          }
        }
        // else if (label == "Password") {
        //   if (v!.length < 8) {
        //     return "Password tidak valid";
        //   }
        // }
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
        labelText: label,
        // hintText: label,
        errorText: msg,
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
      obscureText: label == "Kata Sandi" ? true : false,
    );
  }

  // final _formKey = GlobalKey<FormState>();
  bool foc = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fEmail.unfocus();
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
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: yd_defauld_padding * 2,
                      child: Column(
                        children: [
                          // foc
                          //     ? SizedBox(
                          //         width: 0,
                          //         height: 0,
                          //       )
                          //     :

                          SvgPicture.asset("assets/images/Daftar-Lock.svg"),
                          Text(
                            "Lupa Kata Sandi?",
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Harap masukkan email Anda. Kami akan mengirimkan link untuk mengubah kata sandi melalui email Anda.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: yd_Color_Primary_Grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: yd_defauld_padding * 3,
                          ),
                          GetBuilder<ControllerLupaSandi>(builder: (v) {
                            return Form(
                              child: Focus(
                                onFocusChange: (value) {
                                  setState(() {
                                    value ? foc = true : foc = false;
                                  });
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(yd_defauld_padding),
                                    child: textFieldLogin(
                                      focusNode: fEmail,
                                      onChanged: (v) {
                                        setState(() {});
                                      },
                                      label: "Email",
                                      type: TextInputType.emailAddress,
                                      controller: email,
                                      msg: v.msg,
                                    )),
                              ),
                            );
                          }),

                          // foc
                          //     ? SizedBox(
                          //         height: yd_defauld_padding * 3,
                          //       )
                          //     :
                          SizedBox(
                            width: 0,
                            height: 0,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: email.text.isValidEmail()
                  ? GestureDetector(
                      // onLongPress: () {
                      //   Get.to(
                      //     () => UbahKataSandi(
                      //       isProfile: false,
                      //     ),
                      //   );
                      // },
                      onTap: () {
                        lupaSandi.sendEmail(
                          email: email.text,
                          context: context,
                        );
                      },
                      child: buttonDefaulLogin(
                          backGround: yd_Color_Primary,
                          textColor: Colors.white,
                          text: "Lanjutkan"),
                    )
                  : buttonDefaulLogin(
                      backGround: yd_Color_Primary_Grey.withOpacity(0.2),
                      textColor: yd_Color_Primary_Grey,
                      text: "Lanjutkan"),
            ),
          ),
        ),
      ),
    );
  }
}
