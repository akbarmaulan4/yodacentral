import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_riwayat/controller_riwayat.dart';

import 'components/card_list_riwayat_masuk.dart';

class RiwayatMasuk extends StatefulWidget {
  const RiwayatMasuk({Key? key}) : super(key: key);

  @override
  _RiwayatMasukState createState() => _RiwayatMasukState();
}

class _RiwayatMasukState extends State<RiwayatMasuk> {
  ControllerRiwayat controllerRiwayat = Get.put(ControllerRiwayat());
  @override
  void initState() {
    super.initState();

    controllerRiwayat.getActiv();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(yd_defauld_padding),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 1.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(
                        "Riwayat Masuk",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: yd_defauld_padding * 2,
                    ),
                    GetBuilder<ControllerRiwayat>(builder: (v) {
                      return v.load
                          ? widgetLoadPrimary()
                          : v.modelLogActivity!.data!.length == 0
                              ? Text("Tidak ada aktifitas")
                              : Column(
                                  children: [
                                    for (var a in v.modelLogActivity!.data!)
                                      cardListRiwayatMasuk(
                                        devices: a.device,
                                        tgl: a.createdAt,
                                        kategori: a.category,
                                      ),
                                  ],
                                );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
