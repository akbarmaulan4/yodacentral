import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_wilayah/controller_wilayah.dart';
// import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/cek_nomor-polisi.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/info_seller_mobil/info.seller_mobil.dart';
// import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/informasi_seller_mobil.dart';

import 'components/apakah_semua_data_benar.dart';
import 'components/informasi_nasabah.dart';
import 'components/mobil_diiklan.dart';
import 'components/review_refinancing.dart';
import 'components/unggah_foto.dart';

class AddNewLeadFinancing extends StatefulWidget {
  const AddNewLeadFinancing({Key? key, required this.isFinancing})
      : super(key: key);
  final bool isFinancing;

  @override
  _AddNewLeadFinancingState createState() => _AddNewLeadFinancingState();
}

class _AddNewLeadFinancingState extends State<AddNewLeadFinancing> {
  PageController controller = PageController(initialPage: 0, keepPage: true);
  ControllerWilayah controllerWilayah = Get.put(ControllerWilayah());

  int page = 0;
  double wi = 0;
  lineBarDynamic({int? i}) {
    if (i == 0 || page == 0) {
      setState(() {
        wi = Get.width * 0.25;
      });
    }
    if (i == 1) {
      wi = Get.width * 0.50;
    }
    if (i == 2) {
      wi = Get.width * 0.75;
    }
    if (i == 3) {
      wi = Get.width * 1;
    }
    if (i == 4) {
      wi = Get.width * 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAddLeadFinancing>(builder: (v) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              if (page == null || page == 0) {
                Get.back();
              } else {
                setState(() {
                  controller.animateToPage(
                    page - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              }
            },
            child: Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: widget.isFinancing
              ? Text(
                  "Tambah Lead Financing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : Text(
                  "Tambah Lead Refinancing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => CustomDialog(batal: (){
                      // controllerWilayah.allClear();
                      Get.back();
                    },),
                    barrierColor: Color(0xFF0D0A19).withOpacity(0.75));
              },
              child: Text(
                "Batalkan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: yd_Color_Primary,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: yd_Color_Primary.withOpacity(0.3),
                height: 5,
                width: Get.width,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      color: yd_Color_Primary,
                      height: 5,
                      width: page == 0 ? Get.width * 0.25 : wi,
                    )
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(5),
          ),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          onPageChanged: (i) {
            log(i.toString());
            setState(() {
              page = i;
              lineBarDynamic(i: i);
            });
          },
          children: [
            MobilYangDiIklan(
              isFinancing: widget.isFinancing,
              toChangePage: (i) {
                setState(() {
                  controller.animateToPage(i,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                });
              },
            ),
            UnggahFoto(
              toChangePage: (i) {
                setState(() {
                  controller.animateToPage(i,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                });
              },
            ),
            widget.isFinancing
                ? InfoSellerMobil(isFinancing: widget.isFinancing)
                : InformasiNasabah(
                    toChangePage: (i) {
                      setState(() {
                        controller.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      });
                    },
                  ),
            widget.isFinancing ? ApakahSemuaDataBenar(isFinancing: widget.isFinancing) : ReviewRefinancing(),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerWilayah.allClear();
  }
}
