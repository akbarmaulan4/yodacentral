import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/controller/controller_lead_search_financing/controller_lead_search_financing.dart';
import 'package:yodacentral/controller/controller_search_chat/controller_search_chat.dart';
import 'package:yodacentral/controller/controller_search_refinancing/controller_search_refinancing.dart';

class RiwayatPencarian extends StatefulWidget {
  const RiwayatPencarian({Key? key, this.onClick}) : super(key: key);
  final ValueChanged<ModelListHisto>? onClick;

  @override
  _RiwayatPencarianState createState() => _RiwayatPencarianState();
}

class _RiwayatPencarianState extends State<RiwayatPencarian> {
  ControllerLeadSearchFinancing leadSearchFinancing =
      Get.put(ControllerLeadSearchFinancing());

  ControllerSearchRefinancing searchRefinancing =
      Get.put(ControllerSearchRefinancing());
  ControllerSarchChat controllerSarchChat = Get.put(ControllerSarchChat());
  ControllerHistory histo = Get.put(ControllerHistory());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerHistory>(builder: (v) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 5),
            child: Text(
              "Riwayat Pencarian",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if (v.history.length == 0)
                  SizedBox(width: 0, height: 0)
                else if (v.history.length < 4)
                  for (var a in v.history)
                    InkWell(
                      hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      onTap: () {
                        setState(() {
                          widget.onClick!(ModelListHisto(
                            name: a.name,
                            date: DateTime.now(),
                          ));
                        });
                        leadSearchFinancing.searchLead(search: a.name);
                        searchRefinancing.searchRefinancing(search: a.name);
                        controllerSarchChat.searchRefinancing(search: a.name);
                      },
                      child: listHistory(name: a.name!),
                    )
                else
                  for (var i = 0; i < 4; i++)
                    InkWell(
                      hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
                      onTap: () {
                        setState(() {
                          widget.onClick!(ModelListHisto(
                            name: v.history[i].name,
                            date: DateTime.now(),
                          ));
                        });
                        leadSearchFinancing.searchLead(
                            search: v.history[i].name);
                        searchRefinancing.searchRefinancing(
                            search: v.history[i].name);
                        controllerSarchChat.searchRefinancing(
                            search: v.history[i].name);
                      },
                      child: listHistory(name: v.history[i].name!),
                    )
              ],
            ),
          ),
        ],
      );
    });
  }
}

Widget listHistory({required String name}) {
  return Container(
    padding: EdgeInsets.all(15),
    child: Row(
      children: [
        Icon(
          Icons.history_rounded,
        ),
        SizedBox(
          width: yd_defauld_padding * 2,
        ),
        Text(name),
      ],
    ),
  );
}
