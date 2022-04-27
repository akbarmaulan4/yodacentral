import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class ReviewRefinancing extends StatefulWidget {
  const ReviewRefinancing({Key? key}) : super(key: key);

  @override
  _ReviewRefinancingState createState() => _ReviewRefinancingState();
}

class _ReviewRefinancingState extends State<ReviewRefinancing> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Apakah Semua Data Sudah Benar?",
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TabTop(
              index: 0,
              onClick: (i) {
                setState(() {
                  index = i;
                  log(i.toString());
                });
              },
            ),
            if (index == 0) UnitReview() else NasabahReview()
          ],
        ),
      ),
    );
  }
}

class TabTop extends StatefulWidget {
  const TabTop({Key? key, required this.onClick, required this.index})
      : super(key: key);
  final ValueChanged<int> onClick;
  final int index;

  @override
  _TabTopState createState() => _TabTopState();
}

class _TabTopState extends State<TabTop> {
  int page = 0;

  change({int? i}) {
    setState(() {
      widget.onClick(i!);
      page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(yd_defauld_padding, 10, yd_defauld_padding, 12),
      constraints: const BoxConstraints(maxHeight: 150.0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: yd_Color_Primary_Grey.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: page == 0 ? 0 : null,
            right: page == 1 ? 0 : null,
            duration: Duration(
              milliseconds: 100,
            ),
            child: Container(
              width: Get.width / 2 - yd_defauld_padding,
              decoration: BoxDecoration(
                  color: Color(0xFFD9EDE9),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: yd_Color_Primary_Grey.withOpacity(0.5),
                      offset: Offset(0, 0.5),
                      blurRadius: 0.4,
                    ),
                  ]),
              height: 40,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  change(i: 0);
                },
                child: Container(
                  color: Colors.green.withOpacity(0.0),
                  width: Get.width / 2 - yd_defauld_padding - 5,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Unit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  change(i: 1);
                },
                child: Container(
                  color: Colors.green.withOpacity(0.0),
                  width: Get.width / 2 - yd_defauld_padding - 5,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Nasabah",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnitReview extends StatefulWidget {
  const UnitReview({Key? key}) : super(key: key);

  @override
  _UnitReviewState createState() => _UnitReviewState();
}

class _UnitReviewState extends State<UnitReview> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAddLeadFinancing>(builder: (v) {
      return Column(
        children: [
          spekUnit(
            subName: "Spesifikasi unit",
            items: [
              ItemListUnit(
                keyUnit: "Nomor Polisi",
                valueUnit: v.nomorPolisi1 ?? "-",
              ),
              ItemListUnit(
                keyUnit: "Kondisi Mobil",
                valueUnit:
                    v.kondisiMobil1 == null ? "-" : v.kondisiMobil1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Merek",
                valueUnit: v.merek1 == null ? "-" : v.merek1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Model",
                valueUnit: v.model1 == null ? "-" : v.model1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Varian",
                valueUnit: v.varian1 == null ? "-" : v.varian1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Tahun",
                valueUnit: v.tahun1 == null ? "-" : v.tahun1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Jarak Tempuh",
                valueUnit: v.jarakTempuh1 == null ? "-" : v.jarakTempuh1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Bahan Bakar",
                valueUnit: v.bahanBakar1 == null ? "-" : v.bahanBakar1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Transmisi",
                valueUnit: v.transmisi1 == null ? "-" : v.transmisi1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Warna",
                valueUnit: v.warna1 == null ? "-" : v.warna1!.name!,
              ),
              ItemListUnit(
                keyUnit: "Harga",
                valueUnit: v.harga1 == null ? "-" : "Rp " + v.harga1!,
              ),
              ItemListUnit(
                keyUnit: "Catatan",
                valueUnit: v.catatan1 == null ? "-" : v.catatan1!,
              ),
            ],
          ),
          spekUnit(
            subName: "Lokasi unit",
            items: [
              ItemListUnit(
                keyUnit: "Provinsi",
                valueUnit: v.provinsi1!.name ?? "-",
              ),
              ItemListUnit(
                keyUnit: "Kota/Kabupaten",
                valueUnit: v.kotaKabupaten1!.name ?? "-",
              ),
              ItemListUnit(
                  keyUnit: "Kecamatan", valueUnit: v.kecamatan1!.name ?? "-"),
              ItemListUnit(
                keyUnit: "Cabang Pengelola",
                valueUnit: v.kotaKabupaten1!.name ?? "-",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: fotoUnit(
              subName: "Foto unit",
              imgUrlFile: v.listFoto1,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    });
  }
}

////////
///
///
///
///
///
///
///
///
///

class NasabahReview extends StatefulWidget {
  const NasabahReview({Key? key}) : super(key: key);

  @override
  _NasabahReviewState createState() => _NasabahReviewState();
}

class _NasabahReviewState extends State<NasabahReview> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAddLeadFinancing>(builder: (v) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                v.namaNasabah ?? "-",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(children: [
              ItemCardListUnis(
                  keyUnit: "Nomor KTP", valueUnit: v.nomorKtpNasabah ?? "-"),
              ItemCardListUnis(
                  keyUnit: "Nomor Telepon",
                  valueUnit: "+62 " + v.nomorTlpNasabah.toString()),
            ]),
          ),
          spekUnit(
            subName: "Domisili Nasabah",
            items: [
              ItemListUnit(
                keyUnit: "Provinsi",
                valueUnit: v.provinsiNasabah1!.name ?? "-",
              ),
              ItemListUnit(
                keyUnit: "Kota",
                valueUnit: v.kotaKabupatenNasabah1!.name ?? "-",
              ),
              ItemListUnit(
                keyUnit: "Kecamatan",
                valueUnit: v.kecamatanNasabah1!.name ?? "-",
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              v.addLeadRefinancing();
            },
            child: buttonDefaulLogin(
              backGround: yd_Color_Primary,
              textColor: Colors.white,
              text: "Simpan",
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
