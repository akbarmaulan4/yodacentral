import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/save_root/save_root.dart';

import 'components/card_list_informasi_akun.dart';

class InformasiAkun extends StatefulWidget {
  const InformasiAkun({Key? key}) : super(key: key);

  @override
  _InformasiAkunState createState() => _InformasiAkunState();
}

class _InformasiAkunState extends State<InformasiAkun> {
  bool i = true;

  String? name;
  String? email;
  String? noTlp;
  String? role;
  String? lokasi;

  getProfil() async {
    SaveRoot.callSaveRoot().then((value) {
      setState(() {
        name = value.userData!.name;
        email = value.userData!.email;
        noTlp = value.userData!.telp;
        role = value.userData!.role;
        lokasi = value.userData!.kantor;
        value.userData!.role == "External" ? false : true;
      });
      log(value.userData!.role!);
    });
  }

  @override
  void initState() {
    super.initState();
    getProfil();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: Get.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        "Informasi Akun",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: yd_defauld_padding * 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        cardListInformasiAkun(
                          key: "Nama Lengkap Sesuai KTP",
                          value: name ?? "",
                        ),
                        cardListInformasiAkun(
                          key: "Alamat E-mail",
                          value: email ?? "",
                        ),
                        cardListInformasiAkun(
                          key: "Nomor telepon",
                          value: noTlp == null ? "" : "+62 " + noTlp!,
                        ),
                        role == "External"
                            ? SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : Column(children: [
                                cardListInformasiAkun(
                                  key: "Role",
                                  value: role ?? "",
                                ),
                                cardListInformasiAkun(
                                  key: "Lokasi",
                                  value: lokasi ?? "",
                                ),
                              ])
                      ],
                    ),
                    SizedBox(
                      height: yd_defauld_padding * 5,
                    ),
                    role == null
                        ? SizedBox(width: 0, height: 0)
                        : role == "External"
                            ? Center(
                                child: Text(
                                  "Hubungi PIC\njika informasi Akun tidak sesuai",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: yd_Color_Primary_Grey,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "Hubungi Customer Relation\njika informasi Akun tidak sesuai",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: yd_Color_Primary_Grey,
                                  ),
                                ),
                              )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
