import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';
import 'package:yodacentral/controller/controller_search_seller/controller_search_seller.dart';
import 'package:yodacentral/models/model_seller_search.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/add_seller_baru.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/screens/login/daftar/daftra.dart';
import 'package:yodacentral/utils/utils.dart';

class InformasiSellerMobil extends StatefulWidget {
  const InformasiSellerMobil(
      {Key? key, required this.toChangePage, required this.isFinancing})
      : super(key: key);
  final ValueChanged<int>? toChangePage;
  final bool isFinancing;

  @override
  _InformasiSellerMobilState createState() => _InformasiSellerMobilState();
}

class _InformasiSellerMobilState extends State<InformasiSellerMobil>
    with AutomaticKeepAliveClientMixin {
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

  // Widget resultSearch({
  //   required ValueChanged<int> page,
  //   required ValueChanged<Datum> infoSeller,
  // }) {
  //   return GetBuilder<ControllerSearchSeller>(builder: (v) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Seller Terdaftar",
  //           style: TextStyle(
  //             fontSize: 12,
  //             color: yd_Color_Primary_Grey,
  //           ),
  //         ),
  //         SizedBox(
  //           height: yd_defauld_padding,
  //         ),
  //         v.load
  //             ? Center(
  //                 child: CircularProgressIndicator(
  //                 color: yd_Color_Primary,
  //               ))
  //             : v.modelSellerSearch == null ||
  //                     v.modelSellerSearch!.data!.length == 0
  //                 ? Center(child: Text("Data penjual tidak ada"))
  //                 : Column(
  //                     children: [
  //                       for (var i = 0;
  //                           i < v.modelSellerSearch!.data!.length;
  //                           i++)
  //                         GestureDetector(
  //                           onTap: () {
  //                             setState(() {
  //                               seller = v.modelSellerSearch!.data![i];
  //                               controller.animateToPage(1,
  //                                   duration: Duration(milliseconds: 300),
  //                                   curve: Curves.easeInOut);
  //                             });
  //                             // widget(1);
  //                             // widget.infoSeller!(v.modelSellerSearch!.data![i]);
  //                           },
  //                           child: cardSellerSearch(
  //                             name: v.modelSellerSearch!.data![i].name,
  //                             alamat: v.modelSellerSearch!.data![i].kecamatan! +
  //                                 "," +
  //                                 v.modelSellerSearch!.data![i].kabupaten! +
  //                                 "," +
  //                                 v.modelSellerSearch!.data![i].provinsi!,
  //                             imageUrl: v.modelSellerSearch!.data![i].photo,
  //                           ),
  //                         ),
  //                     ],
  //                   ),
  //       ],
  //     );
  //   });
  // }

  FocusNode fSearch = new FocusNode();
  TextEditingController search = TextEditingController();
  ControllerSearchSeller controllerSearchSeller =
      Get.put(ControllerSearchSeller());

  PageController controller = PageController(initialPage: 0, keepPage: true);
  int pagei = 0;
  Datum? seller;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          fSearch.unfocus();
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(yd_defauld_padding),
            child: Column(children: [
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
              Container(
                color: Colors.transparent,
                height: Get.height / 1.3,
                child: PageView(
                  controller: controller,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        textFieldLogin(
                            focusNode: fSearch,
                            label: "Nama Seller",
                            controller: search,
                            onChanged: (v) {
                              setState(() {});
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        search.text.length == 0
                            ? SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                      "Daftarkan Seller Baru",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: yd_Color_Primary_Grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: yd_defauld_padding,
                                    ),
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
                                        decoration: BoxDecoration(
                                          color:
                                              yd_Color_Primary.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.add),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(search.text,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: yd_defauld_padding,
                                    ),
                                  ]),
                        SizedBox(
                          height: 20,
                        ),
                        search.text.length == 0
                            ? cantFind(
                                title: "Cari atau daftarkan seller",
                                content:
                                    "Masukan nama seller dengan lengkap untuk memudahkan pencarian",
                              )
                            : ResultSearch(infoSeller: (v) {
                                setState(() {
                                  seller = v;
                                });
                              }, page: (i) {
                                controller.animateToPage(i,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }),
                      ],
                    ),
                    InforSel(
                      dataSeller: seller,
                      toChangePage: (i) {
                        setState(() {
                          widget.toChangePage!(i);
                        });
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        // bottomNavigationBar: GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       widget.toChangePage!(4);
        //     });
        //   },
        //   child: buttonDefaulLogin(
        //       backGround: yd_Color_Primary,
        //       textColor: Colors.white,
        //       text: "Selanjutnya"),
        // ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key, required this.page, this.infoSeller})
      : super(key: key);
  final ValueChanged<int> page;
  final ValueChanged<Datum>? infoSeller;
  // final  String edt;

  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSearchSeller>(builder: (v) {
      return SizedBox(
        height: Get.height / 2.1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seller Terdaftar", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,),),
              SizedBox(height: yd_defauld_padding),
              v.load ? Center(child: CircularProgressIndicator()) : v.modelSellerSearch == null || v.modelSellerSearch!.data!.length == 0
                      ? Column(
                        children: [
                          Center(child: Text("Data penjual tidak ada")),
                        ],
                      )
                      : Column(
                          children: [
                            for (var i = 0; i < v.modelSellerSearch!.data!.length; i++)
                              GestureDetector(
                                onTap: () {
                                  widget.page(1);
                                  widget.infoSeller!(v.modelSellerSearch!.data![i]);
                                },
                                child: cardSellerSearch(
                                  name: v.modelSellerSearch!.data![i].name,
                                  alamat: v.modelSellerSearch!.data![i].kecamatan! + "," + v.modelSellerSearch!.data![i].kabupaten! + "," + v.modelSellerSearch!.data![i].provinsi!,
                                  imageUrl: v.modelSellerSearch!.data![i].photo,
                                ),
                              ),
                          ],
                        ),
            ],
          ),
        ),
      );
    });
  }
}

Widget cardSellerSearch({
  String? name = "-",
  String? alamat = "-",
  String? imageUrl = "-"
}) {
  return Container(
    // padding: EdgeInsets.all(yd_defauld_padding),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 1,
      ),
      borderRadius: BorderRadius.circular(
        12,
      ),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                SizedBox(
                  width: Get.width / 2,
                  child: Text(
                    name!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: Text(
                    alamat!,
                    style: TextStyle(
                      fontSize: 14,
                      color: yd_Color_Primary_Grey,
                    ),
                    maxLines: 2,
                  ),
                )
              ]),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Container(
            width: Get.width / 4,
            height: Get.width / 4,
            decoration: BoxDecoration(
              color: yd_Color_Primary_Grey.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: imageNetworkHandler(
              urlImage: imageUrl,
            ),
          ),
        ),
      ],
    ),
  );
}

class InforSel extends StatefulWidget {
  const InforSel({Key? key, this.dataSeller, required this.toChangePage})
      : super(key: key);
  final Datum? dataSeller;
  final ValueChanged<int> toChangePage;

  @override
  _InforSelState createState() => _InforSelState();
}

class _InforSelState extends State<InforSel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerAddLeadFinancing>(
      builder: (v) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text(widget.dataSeller!.name!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                      Text("Foto Seller", style: TextStyle(fontSize: 12, color: yd_Color_Primary_Grey,)),
                      SizedBox(height: 15,),
                      SizedBox(
                        width: Get.width,
                        height: Get.width - 30,
                        child: imageNetworkHandler(urlImage: widget.dataSeller!.photo),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.toChangePage(4);
                  });
                  v.inputSeller(
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
                },
                child: buttonDefaulLogin(
                  backGround: yd_Color_Primary,
                  textColor: Colors.white,
                  text: "Pilih",
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
