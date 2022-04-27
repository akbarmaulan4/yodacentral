import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';

class WaitingVerification extends StatefulWidget {
  const WaitingVerification({Key? key}) : super(key: key);

  @override
  _WaitingVerificationState createState() => _WaitingVerificationState();
}

class _WaitingVerificationState extends State<WaitingVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
                  SizedBox(
                    height: 0,
                  ),
                  Column(
                    children: [
                      SvgPicture.asset("assets/images/Daftar-Lock.svg"),
                      Text(
                        "Terima kasih",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          "Akun kamu telah didaftarkan. Silahkan tunggu 1x24 Jam (waktu jam kerja) untuk bisa menggunakan akunmu.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(Wraping());
                      // Get.offAllNamed("/login");
                      // if (Platform.isAndroid) {
                      //   SystemNavigator.pop();
                      // } else if (Platform.isIOS) {
                      //   exit(0);
                      // }
                    },
                    child: buttonDefaulLogin(
                      backGround: yd_Color_Primary,
                      textColor: Colors.white,
                      text: "Tutup",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
