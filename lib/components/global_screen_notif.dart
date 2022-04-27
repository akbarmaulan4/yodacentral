import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class GlobalScreenNotif extends StatefulWidget {
  const GlobalScreenNotif(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.textButton})
      : super(key: key);
  final String title;
  final String content;
  final String textButton;
  final Function() onTap;

  @override
  _GlobalScreenNotifState createState() => _GlobalScreenNotifState();
}

class _GlobalScreenNotifState extends State<GlobalScreenNotif> {
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
