import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/screens/login/lupa_kata_sandi/ubah_kata_sandi.dart';

class CekEmailAndaPw extends StatefulWidget {
  const CekEmailAndaPw(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.textButton,
      required this.email})
      : super(key: key);
  final String email;
  final String title;
  final String content;
  final String textButton;
  final Function() onTap;

  @override
  _CekEmailAndaPwState createState() => _CekEmailAndaPwState();
}

class _CekEmailAndaPwState extends State<CekEmailAndaPw> {
  Timer? _timer10;

  int _start10 = 15;

  // setState(() {
  //   _start = 60;
  //   startTimer();
  // });

  void startTimer10() {
    const sec10 = const Duration(seconds: 1);
    _timer10 = new Timer.periodic(
      sec10,
      (Timer timer) {
        if (_start10 == 1) {
          setState(() {
            cekStatusEmail();
            _timer10!.cancel();
          });
        } else {
          setState(() {
            _start10--;
            log(_start10.toString());
          });
        }
      },
    );
  }

  cekStatusEmail() async {
    modalLoad();
    var url = Uri.tryParse(
        "https://yoda-central-app.herokuapp.com/api/forget/cek-status");
    var res = await http.post(
      url!,
      body: {
        'email': widget.email,
      },
    );
    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      Get.to(
        () => UbahKataSandi(
          isProfile: false,
          email: widget.email,
          token: json.decode(res.body)["token"],
        ),
      );
      log(res.body);
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      setState(() {
        _start10 = 15;
        startTimer10();
      });
      log(res.body);
    }
  }

  @override
  void initState() {
    super.initState();
    // startTimer10();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: yd_defauld_padding * 2.5,
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: Get.width,
                height: Get.height - (yd_defauld_padding * 2.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(yd_defauld_padding),
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 12,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Column(
                      children: [
                        SvgPicture.asset("assets/images/Daftar-Lock.svg"),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            widget.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: yd_Color_Primary_Grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: buttonDefaulLogin(
                        backGround: yd_Color_Primary,
                        textColor: Colors.white,
                        text: widget.textButton,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
