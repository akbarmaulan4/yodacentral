import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/models/model_dummy_pipeline/model_dummy_pipeline.dart';
import 'package:yodacentral/models/model_lead_search_financing.dart';
import 'package:yodacentral/screens/detail_leads/detail_leads.dart';

Widget cardListFinancingSearch({Datum? data, required bool isFinancing, Function? onClick}) {
  return InkWell(
    hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
    focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
    splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
    highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
    onTap: () {
      onClick!(data);
      // Get.to(
      //   () => DetailLeads(
      //     unitForSeller: data!.unitId!,
      //     lead_id: data.id!,
      //     idPipeline: data.pipelineId!,
      //     isFinancing: isFinancing,
      //     unit_id: data.id!,
      //     nameCar: data.modelName!,
      //     namePipeline: isFinancing
      //         ? financing.where((element) => data.pipelineId == element.id).first.title
      //         : refinancing.where((element) => data.pipelineId == element.id).first.title,
      //   ),
      // );
    },
    child: Container(
      margin: EdgeInsets.symmetric(
          vertical: yd_defauld_padding / 2, horizontal: yd_defauld_padding),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(yd_defauld_padding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.modelName!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data.lastUpdate!,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data.sellerName ?? "-",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ]),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: yd_Color_Primary_Grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: imageNetworkHandler(
                urlImage: data.photoUnit,
                nama: data.modelName,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
