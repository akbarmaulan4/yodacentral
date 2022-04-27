import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/controller/controller_riwayat/controller_riwayat.dart';
import 'package:yodacentral/save_root/save_root.dart';

import 'components/menu_pengaturan.dart';
import 'components/top_image_profil.dart';

class PengaturanProfil extends StatefulWidget {
  const PengaturanProfil({Key? key}) : super(key: key);

  @override
  _PengaturanProfilState createState() => _PengaturanProfilState();
}

class _PengaturanProfilState extends State<PengaturanProfil> {
  String? name;
  String? imgUrl;
  String? kode;

  getProfil() async {
    SaveRoot.callSaveRoot().then((value) {
      setState(() {
        imgUrl = value.userData!.avatar;
        name = value.userData!.name;
        kode = value.userData!.kode;
      });
    });
  }

  ControllerRiwayat controllerRiwayat = Get.put(ControllerRiwayat());

  @override
  void initState() {
    super.initState();
    getProfil();
    controllerRiwayat.getActiv();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              topImageProfil(
                name: name ?? "",
                registerNumber: kode ?? "",
                imgUrl: imgUrl ?? "",
              ),
              SizedBox(
                height: 50,
              ),
              menuPengaturan(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
