import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_biodata/controller_biodata.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/screens/login/data_diri.dart/data_diri.dart';

class EmailSend extends StatefulWidget {
  const EmailSend({Key? key}) : super(key: key);

  @override
  _EmailSendState createState() => _EmailSendState();
}

class _EmailSendState extends State<EmailSend> {
  Timer? _timer;
  int _start = 60;
  RxInt count = 59.obs;

  ControllerBiodata controllerBiodata = Get.put(ControllerBiodata());

  resendEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? emailRegis = sharedPreferences.getString("emailRegis");
    log(emailRegis.toString());
    modalLoad();
    var url =
        Uri.tryParse(ApiUrl.domain.toString() + ApiUrl.resendEmail.toString());

    var res = await http.post(url!, body: {
      'email': emailRegis.toString(),
      'category': 'mobile',
    });

    if (res.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      var mes = json.decode(res.body);
      count.value = 59;
      startTimer();
      rawBottomNotif(
        message: mes["message"],
        colorFont: Colors.white,
        backGround: yd_Color_Primary,
      );
      log(res.body);
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      var mes = json.decode(res.body);
      rawBottomNotif(
        message: mes["message"],
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      log(res.body);
    }
  }

  Timer? _timer10;

  int _start10 = 15;

  // setState(() {
  //   _start = 60;
  //   startTimer();
  // });

  void startTimer10() {
    // setState(() {
    //   _timer10 == null ? log("null timer10") : _timer10!.cancel();
    //   _start = 10;
    // });
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

  String? token;
  cekStatusEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? emailRegis = sharedPreferences.getString("emailRegis");
    log(emailRegis ?? "--", name: "ini email regis");
    // setState(() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          backgroundColor: yd_Color_Primary,
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    );

    var url = Uri.tryParse(ApiUrl.domain.toString() + cekStatusEmail.toString());
    log("lagi cek status");
    var res = await http.post(
        url ?? Uri.tryParse("${ApiUrl.domain}/api/register/cek-status")!,
        body: {
          'email': emailRegis,
          'category': 'mobile',
        });

    if (res.statusCode == 200) {
      Get.back();

      Get.to(() => DataDiri());
      var tok = json.decode(res.body);
      token = tok['token'];
      controllerBiodata.setToken(tokenRegis: tok['token']);
      log(res.body);
    } else {
      token = null;
      _start10 = 15;
      startTimer10();
      log(res.body);
      Get.back();
    }
    // });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
        var value = count.value;
        if(value > 0){
          value--;
          count.value = value;
        }else{
          timer.cancel();
        }
      // (count.value > 0) ? count.value-- : timer.cancel();
        // if (_start == 0) {
        //   setState(() {
        //     timer.cancel();
        //   });
        // } else {
        //   setState(() {
        //     _start--;
        //   });
        // }
      },
    );
  }

  Widget kirimUlang() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _start == 0
              ? yd_Color_Primary
              : yd_Color_Primary_Grey.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            _start == 0
                ? GestureDetector(
                    onTap: () {
                      log("satu");
                      setState(() {
                        _start = 60;
                        startTimer();
                      });
                      resendEmail();
                    },
                    child: Text("Kirim ulang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: yd_Color_Primary,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      log("dua");
                      resendEmail();
                    },
                    child: Text(
                      "Kirim ulang " +
                          " " +
                          DateFormat('(mm:ss)').format(DateTime(
                            0,
                            0,
                            0,
                            0,
                            0,
                            _start,
                          )),
                      // "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: yd_Color_Primary_Grey.withOpacity(0.5),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // @override
  void initState() {
    super.initState();
    // cekStatusEmail();
    // startTimer10();
    // cekSEM();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: yd_defauld_padding * 2.5,
            ),
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
                      child: Text("", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                    ),
                  ),
                  Column(
                    children: [
                      SvgPicture.asset("assets/images/Daftar-Lock.svg"),
                      Text("Email telah dikirim!", style: TextStyle(fontSize: 32,),),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          "Email verifikasi akun Anda telah berhasil dikirim kembali. Harap cek email Anda untuk melanjutkan proses verifikasi.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Obx(()=>Column(
                      children: [
                        // kirimUlang(),
                        InkWell(
                          onTap:()=>  count.value == 0 ? resendEmail():null,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: _start == 0
                                    ? yd_Color_Primary
                                    : yd_Color_Primary_Grey.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text('Kirim ulang (00:${count.value}${count.value == 0 ? 0:''})', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: count.value == 0 ? yd_Color_Primary:yd_Color_Primary_Grey.withOpacity(0.5),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: yd_defauld_padding,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: buttonDefaulLogin(
                            backGround: yd_Color_Primary,
                            textColor: Colors.white,
                            text: "Tutup",
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
