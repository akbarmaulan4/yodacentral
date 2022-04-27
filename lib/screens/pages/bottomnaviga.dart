import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:yodacentral/components/bottom_sheet_floating_add.dart';
import 'package:yodacentral/controller/controller_Lead_count/controller_lead_count.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/controller/controller_wilayah/controller_wilayah.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/pages/histori_notifikasi/history_notifikasi.dart';
import 'package:yodacentral/screens/pages/home/home.dart';
import 'package:yodacentral/screens/pages/kalkulator/kalkulator.dart';
import 'package:yodacentral/screens/pages/pengaturan_profil/pengaturan_profil.dart';

class BottomNaviga extends StatefulWidget {
  const BottomNaviga({Key? key}) : super(key: key);

  @override
  _BottomNavigaState createState() => _BottomNavigaState();
}

class _BottomNavigaState extends State<BottomNaviga> {
  PageController controller = PageController(keepPage: true, initialPage: 0);
  ControllerWilayah controllerWilayah = Get.put(ControllerWilayah());
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());
  ControllerAuth auth = Get.put(ControllerAuth());
  ControllerHistory history = Get.put(ControllerHistory());
  ControllerLeadCount controllerLeadCount = Get.put(ControllerLeadCount());

  int hlmn = 0;
  int tambahUnit = 2;
  @override
  void initState() {
    super.initState();
    controllerLeadCount.getAccess((val){
      setState(() {
        tambahUnit = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Home(),
          Kalkulator(),
          HistoryNotifikasi(),
          PengaturanProfil(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        isActiveAdd: tambahUnit,
        onTapFloat: () {
          Get.dialog(
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: BottomSheetFloatingAdd(),
            ),
            barrierDismissible: true,
            barrierColor: Colors.transparent,
          );
          // showDialog(
          //   context: context,
          //   builder: (_) => GestureDetector(
          //     onTap: () {
          //       Get.back();
          //     },
          //     child: BottomSheetFloatingAdd(),
          //   ),
          // );
        },
        index: hlmn,
        onTap: (i) {
          setState(() {
            hlmn = i;
            controller.jumpToPage(i);
          });
        },
        items: [
          BottomNavItem(
            icon: Icons.home,
          ),
          BottomNavItem(
            icon: Icons.calculate_rounded,
          ),
          BottomNavItem(
            icon: Icons.notifications_rounded,
          ),
          BottomNavItem(
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
