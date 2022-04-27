import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/controller/controller_lead_search_financing/controller_lead_search_financing.dart';

import 'package:yodacentral/models/model_dummy_pipeline/model_dummy_pipeline.dart';
import 'package:yodacentral/screens/detail_leads/detail_leads.dart';

import 'components/card_item_omnisearch.dart';

class ItemTabBarOmnisearch extends StatefulWidget {
  const ItemTabBarOmnisearch({Key? key}) : super(key: key);

  @override
  _ItemTabBarOmnisearchState createState() => _ItemTabBarOmnisearchState();
}

class _ItemTabBarOmnisearchState extends State<ItemTabBarOmnisearch> {
  ControllerHistory history = Get.put(ControllerHistory());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerLeadSearchFinancing>(builder: (v) {
      return SingleChildScrollView(
        child: v.load
            ? widgetLoadPrimary()
            : v.modelLeadSearchFinancing == null
                ? SizedBox(
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
                                  isFinancing: true,
                                  nameCar: a.modelName!,
                                  unit_id: a.id!,
                                  namePipeline: financing
                                      .where((element) =>
                                          a.pipelineId == element.id)
                                      .first
                                      .title,
                                  onBack: (){},
                                ),
                              ),
                            );
                            // Get.to(
                            //   () => DetailLeads(
                            //     idPipeline: a.pipelineId!,
                            //     isFinancing: true,
                            //     nameCar: a.modelName!,
                            //     unit_id: a.id!,
                            //     namePipeline: financing
                            //         .where(
                            //             (element) => a.pipelineId == element.id)
                            //         .first
                            //         .title,
                            //   ),
                            // );
                          },
                          child: cardItemOmnisearch(
                            urlImage: a.photoUnit,
                            name: a.modelName,
                            section: financing
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

var a = {
  "message": "Data Berhasil Didapatkan",
  "data": {
    "open": [
      {
        "id": 1,
        "title": "[Unit] Listing",
        "category": "Financing",
        "priority": 1,
        "status": "Open",
        "total_card": 13
      },
      {
        "id": 3,
        "title": "[Unit] Visiting",
        "category": "Financing",
        "priority": 3,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 4,
        "title": "[Unit] Visit done",
        "category": "Financing",
        "priority": 4,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 5,
        "title": "Assigning Credit Surveyor",
        "category": "Financing",
        "priority": 5,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 6,
        "title": "[Credit] Surveying",
        "category": "Financing",
        "priority": 6,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 7,
        "title": "[Credit] Approval",
        "category": "Financing",
        "priority": 7,
        "status": "Open",
        "total_card": 0
      }
    ],
    "close": [
      {
        "id": 2,
        "title": "[Unit] Not Available",
        "category": "Financing",
        "priority": 2,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 8,
        "title": "[Credit] Purchasing order",
        "category": "Financing",
        "priority": 8,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 9,
        "title": "[Credit] Rejected",
        "category": "Financing",
        "priority": 9,
        "status": "Close",
        "total_card": 0
      }
    ]
  }
};

var ii = {
  "message": "Data Berhasil Didapatkan",
  "data": {
    "open": [
      {
        "id": 10,
        "title": "SLIK Checking",
        "category": "Refinancing",
        "priority": 1,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 11,
        "title": "Assigning Credit Surveyor",
        "category": "Refinancing",
        "priority": 2,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 12,
        "title": "[Credit] Surveying",
        "category": "Refinancing",
        "priority": 3,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 13,
        "title": "[Credit] Approval",
        "category": "Refinancing",
        "priority": 4,
        "status": "Open",
        "total_card": 0
      }
    ],
    "close": [
      {
        "id": 14,
        "title": "[Credit] Purchasing order",
        "category": "Refinancing",
        "priority": 5,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 15,
        "title": "[Credit] Rejected",
        "category": "Refinancing",
        "priority": 6,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 16,
        "title": "SLIK Rejected",
        "category": "Refinancing",
        "priority": 7,
        "status": "Close",
        "total_card": 0
      }
    ]
  }
};
