import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/bottom_sheet_floating_add.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/date_format.dart';
// import 'package:yodacentral/components/modal_Load.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:get/get.dart';
import 'package:yodacentral/models/model_histo_notif.dart';
import 'package:yodacentral/save_root/save_root.dart';

import 'components/card_list_notifikasi.dart';
import 'package:http/http.dart' as http;

class HistoryNotifikasi extends StatefulWidget {
  const HistoryNotifikasi({Key? key}) : super(key: key);

  @override
  _HistoryNotifikasiState createState() => _HistoryNotifikasiState();
}

class _HistoryNotifikasiState extends State<HistoryNotifikasi> {
  bool product = false;
  String? nameProduct = "Semua Product";
  bool tgl = false;
  DateTimeRange? range;

  cekProduct({bool? value}) {
    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: BottomSheetFloatingAddNotif(
          onTap: (s) {
            setState(() {
              product = s == "Semua Product" ? false : true;
              nameProduct = s;
              if (s == "Semua Product") {
                getHistoryNotif(
                  category: null,
                  start: start,
                  end: end,
                );
              } else {
                getHistoryNotif(
                  category: s,
                  start: start,
                  end: end,
                );
              }
              log(s);
              // setState(() {
              //   product = value!;
              // });
            });
          },
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );

    // setState(() {
    //   product = value!;
    // });
  }

  dateTimeRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: DateTimeRange(
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
          start: DateTime.now(),
        ),
        builder: (BuildContext ctx, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              // colorScheme: ColorScheme.fromSwatch(

              //   primarySwatch: Color(0xFF78BFB1),
              //   primaryColorDark: Colors.teal,
              //   accentColor: Colors.teal,
              // ),

              dialogBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: yd_Color_Primary,
                primary: yd_Color_Primary,
                // primaryColorDark: yd_Color_Primary,
              ),
            ),
            child: child!,
          );
        });
    setState(() {
      range = picked;
      if (picked == null) {
        tgl = false;
        start = null;
        end = null;
        getHistoryNotif(
          category: nameProduct,
          start: null,
          end: null,
        );
      } else {
        start = DateFormat("dd-MM-yyyy").format(picked.start);
        end = DateFormat("dd-MM-yyyy").format(picked.end);
        getHistoryNotif(
          category: nameProduct,
          start: start,
          end: end,
        );
      }

      // start = DateFormat("dd-MM-yyyy").format(picked!.start);
      // end = DateFormat("dd-MM-yyyy").format(picked.end);
      // getHistoryNotif(
      //   category: nameProduct,
      //   start: start,
      //   end: end,
      // );
      log(start!);
      log(end!);
      picked == null ? tgl = false : tgl = true;
    });
    // print(picked);
  }

  String? start;
  String? end;

  Widget tabTop() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(
            left: yd_defauld_padding, right: yd_defauld_padding),
        child: Row(
          children: [
            FilterChip(
              selected: product,
              selectedColor: Color(0xFFD9EDE9),
              label: Row(
                children: [
                  Text("$nameProduct"),
                  Icon(Icons.arrow_drop_down_rounded)
                ],
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: !product
                    ? BorderSide(
                        color: yd_Color_Primary_Grey,
                        width: 1,
                      )
                    : BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (bool value) {
                cekProduct(value: value);
              },
            ),
            SizedBox(
              width: yd_defauld_padding,
            ),
            FilterChip(
              selected: tgl,
              selectedColor: Color(0xFFD9EDE9),
              label: Row(
                children: [
                  range == null
                      ? Text("Semua Tanggal")
                      : Text(
                          bulan.format(range!.start) +
                              " - " +
                              bulan.format(range!.end),
                        ),
                  Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: !tgl
                    ? BorderSide(
                        color: yd_Color_Primary_Grey,
                        width: 1,
                      )
                    : BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (v) {
                dateTimeRangePicker();
              },
            ),
          ],
        ),
      ),
    );
  }

  bool load = true;
  bool kosong = false;
  ModelHistoNotif? modelHistoNotif;

  getHistoryNotif({String? category, String? start, String? end}) async {
    // log(category!, name: "in kategori");
    // log(start!, name: "in start");
    // log(end!, name: "in end");
    setState(() {
      load = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      log(value.token!);
      Uri? url;
      if (category == null && start == null && end == null) {
        url =
            Uri.tryParse(ApiUrl.domain.toString() + "/api/admin/notification");
      } else if (category!.isNotEmpty && start == null && end == null) {
        url = Uri.tryParse(ApiUrl.domain.toString() +
            "/api/admin/notification?category=$category");
      } else if (category.isEmpty && start!.isNotEmpty && end!.isNotEmpty) {
        url = Uri.tryParse(ApiUrl.domain.toString() +
            "/api/admin/notification?start=$start&end=$end");
      } else if (category.isNotEmpty && start!.isNotEmpty && end!.isNotEmpty) {
        url = Uri.tryParse(ApiUrl.domain.toString() +
            "/api/admin/notification?category=$category&start=$start&end=$end");
      } else {
        Uri.tryParse(ApiUrl.domain.toString() + "/api/admin/notification");
      }

      log(url.toString(), name: "ini url notif");

      var res = await http.get(url!,
          headers: {'Authorization': 'Bearer ' + value.token.toString()});
      if (res.statusCode == 200) {
        log(res.body);
        setState(() {
          kosong = false;
          load = false;
          modelHistoNotif = modelHistoNotifFromMap(res.body);
          var ddsa = modelHistoNotif;
        });
      } else if (res.statusCode == 204) {
        log(res.statusCode.toString());
        setState(() {
          kosong = true;
          load = false;
        });
      } else {
        log(res.body);
        setState(() {
          load = false;
          kosong = false;
        });
      }
    });
  }

  @override
  void initState() {
    // getHistoryNotif();
    super.initState();
    // modalLoad();
    getHistoryNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: yd_defauld_padding * 3.5,
            ),
            Center(
              child: Text(
                "Notifikasi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: yd_defauld_padding,
            ),
            tabTop(),
            load
                ? widgetLoadPrimary()
                : kosong
                    ? SizedBox(
                        height: Get.height / 2,
                        child: cantFind(
                          title: null,
                          content: "Tidak ada notifikasi.",
                        ),
                      )
                    : modelHistoNotif == null
                        ? cantFind(
                            title: null,
                            content: "Tidak ada notifikasi.",
                          )
                        : modelHistoNotif!.data!.length <= 0
                            ? cantFind(
                                title: null,
                                content: "Tidak ada notifikasi.",
                              )
                            : Column(children: [
                                for (var a in modelHistoNotif!.data!)
                                  CardListNotifilasi(
                                    category: a.category!,
                                    name: a.subject,
                                    date: a.createdAt,
                                    content: a.message,
                                    seen: a.seen,
                                    unit_id: a.unitId,
                                    lead_id: a.leadId,
                                    nama_unit: a.namaUnit,
                                  )
                              ]),
            // for (var i = 0; i < 7; i++) cardListNotifilasi(),
            SizedBox(
              height: yd_defauld_padding * 10,
            ),
          ],
        ),
      ),
    );
  }
}
