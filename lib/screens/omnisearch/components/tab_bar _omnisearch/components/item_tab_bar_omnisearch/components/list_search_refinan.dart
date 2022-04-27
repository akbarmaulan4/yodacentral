import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/controller/controller_search_refinancing/controller_search_refinancing.dart';
import 'package:yodacentral/models/model_dummy_pipeline/model_dummy_pipeline.dart';
import 'package:yodacentral/screens/detail_leads/detail_leads.dart';
import 'package:yodacentral/screens/omnisearch/components/tab_bar%20_omnisearch/components/item_tab_bar_omnisearch/components/card_item_omnisearch.dart';

class ListSearchRefinan extends StatefulWidget {
  const ListSearchRefinan({
    Key? key,
  }) : super(key: key);

  @override
  _ListSearchRefinanState createState() => _ListSearchRefinanState();
}

class _ListSearchRefinanState extends State<ListSearchRefinan> {
  // history.addHistory(text: a.modelName!);
  ControllerHistory history = Get.put(ControllerHistory());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSearchRefinancing>(builder: (v) {
      return SingleChildScrollView(
        child: v.load
            ? widgetLoadPrimary()
            : v.modelLeadSearchFinancing!.data!.length == 0
                ?
                // v.modelLeadSearchFinancing == null
                //     ?
                SizedBox(
                    height: Get.height - 250,
                    child: cantFind(
                      title: "Pencarian Tidak Ditemukan",
                      content: "Silahkan coba masukkan kata kunci lain.",
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: yd_defauld_padding,
                      ),
                      for (var a in v.modelLeadSearchFinancing!.data!)
                        InkWell(
                          hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                          focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                          splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                          highlightColor:
                              yd_Color_Primary_Grey.withOpacity(0.3),
                          onTap: () {
                            history.addHistory(
                              modelListHisto: ModelListHisto(
                                name: a.modelName!,
                                date: DateTime.now(),
                              ),
                            );
                            // Get.back();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailLeads(
                                  unitForSeller: a.unitId!,
                                  lead_id: a.id!,
                                  idPipeline: a.pipelineId!,
                                  isFinancing: false,
                                  nameCar: a.modelName!,
                                  unit_id: a.id!,
                                  namePipeline: refinancing
                                      .where((element) =>
                                          a.pipelineId == element.id)
                                      .first
                                      .title,
                                  onBack: (){},
                                ),
                              ),
                            );
                          },
                          child: cardItemOmnisearch(
                            urlImage: a.photoUnit,
                            name: a.modelName,
                            section: refinancing
                                .where((element) => a.pipelineId == element.id)
                                .first
                                .title,
                          ),
                        ),
                    ],
                  ),
      );
    });
  }
}
