import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_search_seller/controller_search_seller.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/add_seller_baru.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/info_seller_mobil/seller_review.dart';

import '../informasi_seller_mobil.dart';

class SellerSearch extends StatefulWidget {
  const SellerSearch({Key? key, required this.isFinancing}) : super(key: key);
  final bool isFinancing;

  @override
  _SellerSearchState createState() => _SellerSearchState();
}

class _SellerSearchState extends State<SellerSearch> {
  FocusNode fSearch = new FocusNode();
  TextEditingController search = TextEditingController();
  ControllerSearchSeller controllerSearchSeller =
      Get.put(ControllerSearchSeller());
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
        // setState(() {
        //   // log(v);
        // });
        // log(controller.text);
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fSearch.unfocus();
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.all(yd_defauld_padding),
              child: Column(
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
                  SizedBox(
                    height: 30,
                  ),
                  textFieldLogin(
                      focusNode: fSearch,
                      label: "Nama Seller",
                      controller: search,
                      onChanged: (v) {
                        // setState(() {});
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(()=>Container(
                    child: controllerSearchSeller.dataSellerSearch.value.data != null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Seller Terdaftar", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                        SizedBox(height: yd_defauld_padding),
                        controllerSearchSeller.loadData.value ? Center(child: CircularProgressIndicator(backgroundColor: yd_Color_Primary))
                            : controllerSearchSeller.dataSellerSearch.value.data == null
                            ? Center(child: Text("Data penjual tidak ada"))
                            : Column(
                          children: controllerSearchSeller.dataSellerSearch.value.data != null ? controllerSearchSeller.dataSellerSearch.value.data!.asMap().map((index, value) => MapEntry(index, GestureDetector(
                            onTap: () {
                              Get.to(() => SellerReview(
                                isFinancing: widget.isFinancing,
                                dataSeller: controllerSearchSeller.dataSellerSearch.value.data![index],
                              ));
                            },
                            child: cardSellerSearch(
                              name: controllerSearchSeller.dataSellerSearch.value.data![index].name,
                              alamat: controllerSearchSeller.dataSellerSearch.value.data![index].kecamatan! + "," + controllerSearchSeller.dataSellerSearch.value.data![index].kabupaten! + "," + controllerSearchSeller.dataSellerSearch.value.data![index].provinsi!,
                              imageUrl: controllerSearchSeller.dataSellerSearch.value.data![index].photo,
                            ),
                          ))).values.toList():[],
                        ),
                      ],
                    ):search.text.isEmpty ? cantFind(
                        title: "Cari atau daftarkan seller",
                        content: "Masukan nama seller dengan lengkap untuk memudahkan pencarian") : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Daftarkan Seller Baru", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
                          SizedBox(height: yd_defauld_padding),
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => AddSellerBaru(
                                  isFinancing: widget.isFinancing,
                                  nama: search.text,
                                ),
                                transition: Transition.noTransition,
                              );
                            },
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
                        ]),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
