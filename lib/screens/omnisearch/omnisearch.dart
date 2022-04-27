import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/controller/controller_lead_search_financing/controller_lead_search_financing.dart';
import 'package:yodacentral/controller/controller_search_chat/controller_search_chat.dart';
import 'package:yodacentral/controller/controller_search_refinancing/controller_search_refinancing.dart';
import 'package:yodacentral/screens/omnisearch/components/riwayat_pencarian.dart';
import 'components/tab_bar _omnisearch/tab_bar_omnisearch.dart';

class Omisearch extends StatefulWidget {
  const Omisearch({Key? key}) : super(key: key);

  @override
  _OmisearchState createState() => _OmisearchState();
}

class _OmisearchState extends State<Omisearch> {
  FocusNode fSearch = new FocusNode();
  TextEditingController search = TextEditingController();
  ControllerLeadSearchFinancing searchFinancing = Get.put(ControllerLeadSearchFinancing());
  ControllerSearchRefinancing searchRefinancing = Get.put(ControllerSearchRefinancing());
  ControllerSarchChat controllerSarchChat = Get.put(ControllerSarchChat());
  ControllerHistory history = Get.put(ControllerHistory());

  Timer? _timer;
  int _start = 1;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    history.callHisto();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fSearch.unfocus();
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: yd_defauld_padding * 2.5),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              // toolbarHeight: 40,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: yd_defauld_padding * 2 - 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: yd_defauld_padding),
                        child: TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (s) {
                            history.addHistory(
                                modelListHisto: ModelListHisto(
                              name: s,
                              date: DateTime.now(),
                            ));
                            var i = DateTime.now();
                            var a = {"name": "aston", "date": i};
                            log(a.toString());
                          },
                          onChanged: (v) {
                            if (v.length == 0) {
                              log("v kosong");
                              _timer!.cancel();
                            } else {
                              if (_timer != null) {
                                _timer!.cancel();
                                _start = 1;
                              }
                              _timer = Timer.periodic(
                                Duration(seconds: 1),
                                (Timer timer) {
                                  if (_start == 0) {
                                    if (search.text.length == 0) {
                                      log("kosong", name: "ini omnisearch");
                                    } else {
                                      setState(() {
                                        timer.cancel();
                                        searchFinancing.searchLead(search: v);
                                        searchRefinancing.searchRefinancing(search: v);
                                        controllerSarchChat.searchRefinancing(search: v);
                                      });
                                      // history.addHistory(text: v);
                                    }
                                  } else {
                                    setState(() {
                                      _start--;
                                    });
                                  }
                                },
                              );
                            }
                            // streamController.add(v);
                            setState(() {});

                            // log(search.text);
                          },
                          controller: search,
                          focusNode: fSearch,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            // hintText: "Cari",
                            labelText: "Cari",
                            prefixIcon: Icon(
                              Icons.search,
                              color: fSearch.hasFocus
                                  ? yd_Color_Primary
                                  : yd_Color_Primary_Grey,
                            ),
                            // suffix: Text(_start.toString()),
                            labelStyle: TextStyle(
                                color: fSearch.hasFocus
                                    ? yd_Color_Primary
                                    : yd_Color_Primary_Grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: yd_Color_Primary_Grey, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: yd_Color_Primary, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      search.text.length > 0
                          ? TabBarOmniSearch(strSearch: search.text)
                          : RiwayatPencarian(
                              onClick: (v) {
                                history.addHistory(
                                    modelListHisto: ModelListHisto(
                                  name: v.name,
                                  date: DateTime.now(),
                                ));
                                setState(() {
                                  // log(v.name!);

                                  search.text = v.name!;
                                });
                              },
                            ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
