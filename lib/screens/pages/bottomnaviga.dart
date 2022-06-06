import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
import 'package:yodacentral/utils/utils.dart';

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
  bool showNotif = false;

  @override
  void initState() {
    super.initState();
    controllerLeadCount.getAccess((val){
      setState(() {
        tambahUnit = val;
      });
    });

    OneSignal.shared.setAppId('38cea32a-e3e2-4c86-aef9-caf7b1bf212a');
    setupPlayerId();
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final data = result.notification.additionalData;
      // var orderId = data!['order_id'];
      // var type = data['type'];
      if (data != null) {
        // if (type == 'order') {
        //   Navigator.pushNamed(context, "/order_detail_page",
        //       arguments: orderId.toString());
        // } else {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/main_home', (Route<dynamic> route) => false);
        // }
      }
      // will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
      setState(() {
        showNotif = true;
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
        },
        index: hlmn,
        onTap: (i) {
          setState(() {
            hlmn = i;
            controller.jumpToPage(i);
            if(i == 2){
              showNotif = false;
            }
          });
        },
        items: [
          BottomNavItem(
            icon: Icons.home,
            showNotif: false,
          ),
          BottomNavItem(
            icon: Icons.calculate_rounded,
            showNotif: false,
          ),
          BottomNavItem(
            icon: Icons.notifications_rounded,
            showNotif: showNotif,
          ),
          BottomNavItem(
            icon: Icons.person,
            showNotif: false,
          ),
        ],
      ),
    );
  }

  void setupPlayerId() async {
    var hasPlayerId = await Utils.getPlayerID();
    if (!hasPlayerId) {
      var status = await OneSignal.shared.getDeviceState();
      var playerId = status!.userId;
      if (playerId != null) {
        auth.postPlayerID(playerId);
      } else {
        setupPlayerId();
      }
    }
  }
}
