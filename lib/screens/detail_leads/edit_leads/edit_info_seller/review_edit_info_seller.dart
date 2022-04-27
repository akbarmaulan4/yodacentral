import 'dart:developer';

// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_search_seller/controller_search_seller.dart';
import 'package:yodacentral/models/model_seller_search.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';

class ReviewEditInfoSeller extends StatefulWidget {
  const ReviewEditInfoSeller(
      {Key? key,
      required this.id_unit,
      required this.lead_id,
      required this.namePipeline,
      required this.dataSeller,
      required this.onBack
      })
      : super(key: key);
  final int id_unit;
  final int lead_id;
  final String namePipeline;
  final Datum? dataSeller;
  final Function onBack;

  @override
  _ReviewEditInfoSellerState createState() => _ReviewEditInfoSellerState();
}

class _ReviewEditInfoSellerState extends State<ReviewEditInfoSeller> {

  ControllerSearchSeller controller = ControllerSearchSeller();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.namePipeline, style: TextStyle(color: Colors.black, fontSize: 16)),
                  Text("#" + widget.id_unit.toString(), style: TextStyle(fontSize: 12, color: Colors.black)),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(yd_defauld_padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: Text("Ubah Seller", style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: Get.width,
                  height: Get.width,
                  child: imageNetworkHandler(
                    urlImage: widget.dataSeller!.photo,
                  ),
                ),
                SizedBox(height: 30),
                Text(widget.dataSeller!.name!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                SizedBox(height: 14),
                Text(widget.dataSeller!.address!, style: TextStyle()),
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
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () =>controller.updateSeller(
                      unitid: widget.id_unit,
                      idPenjual: widget.dataSeller!.id.toString(),
                      dataSeller: {
                        'name': widget.dataSeller!.name.toString(),
                        'provinsi':widget.dataSeller!.provinsi!,
                        'kabupaten':widget.dataSeller!.kabupaten!,
                        'kecamatan':widget.dataSeller!.kecamatan!,
                        'telp': "+62 " + widget.dataSeller!.telp!
                      },
                    onSuccess: (val)=>widget.onBack(val)
                  ),
                  child: buttonDefaulLogin(
                    backGround: yd_Color_Primary,
                    textColor: Colors.white,
                    text: "Pilih",
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
