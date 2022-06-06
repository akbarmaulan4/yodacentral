import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';

import 'controller/controller_auth.dart/controller_auth.dart';
import 'api_url/http_overide.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  await Permission.camera.request();
  HttpOverrides.global = new IgnoreCertificateErrorOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void oneSignalPack() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId('32ea9861-cc89-4f04-9710-85b9cbdaa888');
    // OneSignal.shared.setAppId('ca76b77b-42b7-4795-8dbd-d41cb0c516e0');

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oneSignalPack();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Portal(
      child: GetMaterialApp(
        title: "Yoda Central",
        smartManagement: SmartManagement.keepFactory,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary),
            ),
          ),

          fontFamily: "RR",
          primaryColor: yd_Color_Primary,
          highlightColor: yd_Color_Primary,
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: yd_Color_Primary,
              ),
          // colorScheme:
          //     ColorScheme.fromSwatch().copyWith(secondary: yd_Color_Primary),
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),

        ),
        debugShowCheckedModeBanner: false,
        // initialRoute: "/",
        home: FirstWrap(),
        // TesTypeHead(),

        // getPages: [
        //   GetPage(
        //     name: "/",
        //     page: () => Wraping(),
        //   ),
        //   GetPage(
        //     name: Login.routeName,
        //     page: () => Login(),
        //   ),
        // ],
      ),
    );
  }
}

class FirstWrap extends StatefulWidget {
  const FirstWrap({Key? key}) : super(key: key);

  @override
  _FirstWrapState createState() => _FirstWrapState();
}

class _FirstWrapState extends State<FirstWrap> {
  int? data;

  cek() {
    SaveRoot.callSaveRoot().then((value) {
      log(value.ingat.toString(), name: "ini ingat");
      ControllerAuth auth = Get.put(ControllerAuth());
      if (value.ingat == null ||
          value.ingat!.bitLength == 0 ||
          value.ingat == 0) {
        log(value.ingat.toString(), name: "ini tidak ada");
        auth.logout();

        Get.offAll(Wraping());
        // rawBottomNotif(
        //   message: "Session anda habis",
        //   colorFont: Colors.white,
        //   backGround: yd_Color_Primary,
        // );
      } else {
        log(value.ingat.toString(), name: "ini ada");
        Get.offAll(() => Wraping());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cek();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
