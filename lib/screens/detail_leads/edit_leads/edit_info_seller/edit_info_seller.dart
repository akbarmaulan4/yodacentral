import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_search_seller/controller_search_seller.dart';
import 'package:yodacentral/models/model_seller_search.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/add_seller_baru.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/informasi_seller_mobil.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_info_seller/review_edit_info_seller.dart';

class EditInfoSeller extends StatefulWidget {
  const EditInfoSeller(
      {Key? key,
      required this.id_unit,
      required this.lead_id,
      required this.namePipeline,
      required this.namaSeller,
      required this.isFinancing,
      required this.onBack
      })
      : super(key: key);
  final int id_unit;
  final int lead_id;
  final String namePipeline;
  final String namaSeller;
  final bool isFinancing;
  final Function onBack;

  @override
  _EditInfoSellerState createState() => _EditInfoSellerState();
}

class _EditInfoSellerState extends State<EditInfoSeller> {
  PageController controller = PageController(initialPage: 0, keepPage: true);
  int pagei = 0;
  Datum? seller;
  FocusNode fSearch = new FocusNode();
  TextEditingController search = TextEditingController();
  ControllerSearchSeller controllerSearchSeller = Get.put(ControllerSearchSeller());

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    String? messageApi,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {},
      controller: controller,
      onChanged: (v) {
        controllerSearchSeller.searchSeller(search: v);
        setState(() {
          // log(v);
        });
        log(controller.text);
      },
      focusNode: focusNode,
      keyboardType: type,
      maxLines: label == "Catatan" ? 4 : 1,
      decoration: InputDecoration(
        prefixIcon: label == "Nama Seller"
            ? Icon(
                Icons.person_search_rounded,
                color: focusNode.hasFocus
                    ? yd_Color_Primary
                    : yd_Color_Primary_Grey,
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 15, vertical: label == "Catatan" ? 8 : 0),
        errorText: messageApi == null ? null : messageApi,
        labelText: label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    search.text = widget.namaSeller;
    controllerSearchSeller.searchSeller(search: widget.namaSeller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fSearch.unfocus();
        });
      },
      child: Scaffold(
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
                  Text(
                    widget.namePipeline,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "#" + widget.lead_id.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Obx(()=>SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(yd_defauld_padding),
            child: Column(children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(child: Text("Ubah Seller",style: TextStyle(fontSize: 22,),textAlign: TextAlign.center)),
              ),
              Container(
                color: Colors.transparent,
                height: Get.height / 1.3,
                child: PageView(
                  controller: controller,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        textFieldLogin(
                            focusNode: fSearch,
                            label: "Nama Seller",
                            controller: search,
                            onChanged: (v) {
                              setState(() {});
                            }),
                        SizedBox(height: 15),
                        search.text.length == 0 ? SizedBox(height: 0, width: 0) : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: yd_defauld_padding),
                          ],
                        ),
                        SizedBox(height: 20),
                        !controllerSearchSeller.findData.value ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Daftarkan Seller Baru", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                              SizedBox(height: yd_defauld_padding),
                              InkWell(
                                onTap: ()=>Get.to(() => AddSellerBaru(isFinancing: widget.isFinancing, nama: search.text), transition: Transition.noTransition,),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: Get.width,
                                  decoration: BoxDecoration(color: yd_Color_Primary.withOpacity(0.1), borderRadius: BorderRadius.circular(100),),
                                  child: Row(
                                    children: [Icon(Icons.add),
                                      SizedBox(width: 15),
                                      Text(search.text, style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: yd_defauld_padding),
                            ]):SizedBox(),
                        search.text.length == 0 ? cantFind(title: "Cari atau daftarkan seller", content: "Masukan nama seller dengan lengkap untuk memudahkan pencarian")
                            : ResultSearch(infoSeller: (v) {
                          setState(() {
                            seller = v;
                          });
                        }, page: (i) {
                          Get.to(() => ReviewEditInfoSeller(
                            id_unit: widget.id_unit,
                            lead_id: widget.lead_id ,
                            namePipeline: widget.namePipeline,
                            dataSeller: seller,
                            onBack: (val)=>widget.onBack(val),
                          ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        )),
      ),
    );
  }
}