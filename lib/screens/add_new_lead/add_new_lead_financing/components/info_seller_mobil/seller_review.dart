import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/models/model_seller_search.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/add_seller_baru.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/apakah_semua_data_benar.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';

class SellerReview extends StatefulWidget {
  const SellerReview(
      {Key? key, required this.dataSeller, required this.isFinancing, re})
      : super(key: key);
  final Datum? dataSeller;
  final bool isFinancing;

  @override
  _SellerReviewState createState() => _SellerReviewState();
}

class _SellerReviewState extends State<SellerReview> {
  ControllerAddLeadFinancing controllerAddLeadFinancing =
      Get.put(ControllerAddLeadFinancing());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  builder: (ctx) => CustomDialog(backI: () {
                        Get.offAll(() => Wraping());
                      }),
                  barrierColor: Colors.black.withOpacity(0.7));
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
                    width: Get.width * 0.75,
                  )
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(5),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: Text(
                      "Informasi Seller Mobil",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.dataSeller!.name!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  widget.dataSeller!.address!,
                  style: TextStyle(),
                ),
                SizedBox(height: 30),
                ItemCardListUnis(
                  keyUnit: "Provinsi",
                  valueUnit: widget.dataSeller!.provinsi!,
                ),
                ItemCardListUnis(
                  keyUnit: "Kota/Kabupaten",
                  valueUnit: widget.dataSeller!.kabupaten!,
                ),
                ItemCardListUnis(
                  keyUnit: "Kecamatan",
                  valueUnit: widget.dataSeller!.kecamatan!,
                ),
                ItemCardListUnis(
                  keyUnit: "Nomor Telepon",
                  valueUnit: "+62 " + widget.dataSeller!.telp!,
                ),
                SizedBox(
                  height: 30,
                ),
                DottedBorder(
                  radius: Radius.circular(8),
                  color: yd_Color_Primary_Grey.withOpacity(0.1),
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  dashPattern: [10, 1],
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foto Seller",
                          style: TextStyle(
                            fontSize: 12,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.width - 30,
                          child: imageNetworkHandler(
                            urlImage: widget.dataSeller!.photo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // GestureDetector(
                //   onTap: () {
                //     Get.to(
                //       () => AddSellerBaru(
                //         isFinancing: widget.isFinancing,
                //         nama: widget.dataSeller!.name!,
                //         isEdit: true,
                //       ),
                //     );
                //   },
                //   child: buttonDefaulLogin(
                //     backGround: Colors.white,
                //     textColor: yd_Color_Primary,
                //     text: "Edit",
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   widget.toChangePage(4);
                    // });

                    controllerAddLeadFinancing.inputSeller(
                      dataSeller: DataSeller(
                        id: widget.dataSeller!.id,
                        name: widget.dataSeller!.name,
                        address: widget.dataSeller!.address,
                        telp: widget.dataSeller!.telp,
                        photo: widget.dataSeller!.photo,
                        kode: widget.dataSeller!.kode,
                        kecamatan: widget.dataSeller!.kecamatan,
                        kabupaten: widget.dataSeller!.kabupaten,
                        provinsi: widget.dataSeller!.provinsi,
                        registerDate: widget.dataSeller!.registerDate,
                        registerTime: widget.dataSeller!.registerTime,
                      ),
                    );
                    Get.to(
                      () => ApakahSemuaDataBenar(
                        isFinancing: widget.isFinancing,
                      ),
                      transition: Transition.noTransition,
                    );
                  },
                  child: buttonDefaulLogin(
                    backGround: yd_Color_Primary,
                    textColor: Colors.white,
                    text: "Pilih",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
