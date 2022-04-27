import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class AddSellerBaruReview extends StatefulWidget {
  const AddSellerBaruReview({Key? key}) : super(key: key);

  @override
  _AddSellerBaruReviewState createState() => _AddSellerBaruReviewState();
}

class _AddSellerBaruReviewState extends State<AddSellerBaruReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "Tambah Lead Financing",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => CustomDialog(),
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
        elevation: 0,
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
                    width: Get.width * 1,
                  )
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(5),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
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
                height: 15,
              ),
              GetBuilder<ControllerAddLeadFinancing>(builder: (v) {
                log(v.listFoto1!.length.toString());
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
                          valueUnit: v.kondisiMobil1 == null
                              ? "-"
                              : v.kondisiMobil1!.name!,
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
                          valueUnit: v.jarakTempuh1 == null
                              ? "-"
                              : v.jarakTempuh1!.name!,
                        ),
                        ItemListUnit(
                          keyUnit: "Bahan Bakar",
                          valueUnit: v.bahanBakar1 == null
                              ? "-"
                              : v.bahanBakar1!.name!,
                        ),
                        ItemListUnit(
                          keyUnit: "Transmisi",
                          valueUnit:
                              v.transmisi1 == null ? "-" : v.transmisi1!.name!,
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
                            keyUnit: "Kecamatan",
                            valueUnit: v.kecamatan1!.name ?? "-"),
                        ItemListUnit(
                          keyUnit: "Cabang Pengelola",
                          valueUnit: v.kotaKabupaten1!.name ?? "-",
                        ),
                      ],
                    ),
                    fotoUnit(
                      subName: "Foto unit",
                      imgUrlFile: v.listFoto1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Informasi seller",
                        style: TextStyle(
                          fontSize: 12,
                          color: yd_Color_Primary_Grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        v.namaSeller!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        v.alamatSeller!,
                      ),
                    ),
                    ItemCardListUnis(
                      keyUnit: "Provinsi",
                      valueUnit: v.provinsiSeller!.name!,
                    ),
                    ItemCardListUnis(
                      keyUnit: "Kota/Kabupaten",
                      valueUnit: v.kotaKabupatenSeller!.name!,
                    ),
                    ItemCardListUnis(
                        keyUnit: "Kecamatan",
                        valueUnit: v.kecamatanSeller!.name!),
                    ItemCardListUnis(
                      keyUnit: "Nomor Telepon",
                      valueUnit: "+62 " + v.nomorSeller!,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          ControllerAddLeadFinancing addLeadFinancing =
              Get.put(ControllerAddLeadFinancing());

          addLeadFinancing.updalodAddLead(
            sellerBaru: true,
          );

          // Get.bottomSheet(
          //   GlobalScreenNotif(
          //     title: "Lead Telah Berhasil Diiklankan",
          //     content:
          //         "Cek leadmu pada menu Dasbor. Jika terjadi masalah, silahkan hubungi Customer Relation.",
          //     onTap: () {
          //       Get.back();
          //     },
          //     textButton: "Selesai",
          //   ),
          //   isScrollControlled: true,
          // );
        },
        child: buttonDefaulLogin(
          backGround: yd_Color_Primary,
          textColor: Colors.white,
          text: "Simpan",
        ),
      ),
    );
  }
}
