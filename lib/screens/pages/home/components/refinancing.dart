import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_Lead_count/controller_lead_count.dart';
import 'package:yodacentral/models/model_pipeline_financing.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/daftar_kartu_financing_refinancing/daftar_kartu_financing/components/filterChipCustom.dart';
import 'package:yodacentral/screens/daftar_kartu_financing_refinancing/daftar_kartu_financing/daftar_kartu_financing.dart';
import 'package:yodacentral/screens/pages/home/components/card_pipeline.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/utils/utils.dart';

class Refinancing extends StatefulWidget {
  const Refinancing({Key? key}) : super(key: key);

  @override
  _RefinancingState createState() => _RefinancingState();
}

class _RefinancingState extends State<Refinancing> {
  bool loadPipeline = true;
  ModelPipelineFinancing? modelPipelineFinancing;
  ControllerLeadCount leadCount = Get.put(ControllerLeadCount());

  getPipelineRefinancing() async {
    setState(() {
      loadPipeline = true;
    });
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}${ApiUrl.pipelineRefinancing.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      setState(() {
        log(res.body);
        modelPipelineFinancing = modelPipelineFinancingFromMap(res.body);
        loadPipeline = false;
      });
    } else {
      setState(() {
        log(res.body);
        loadPipeline = false;
      });
    }
    log(url, name: "ini url refinancing");
  }

  @override
  void initState() {
    super.initState();
    getPipelineRefinancing();
    leadCount.getLeadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\n\n\n\n\n\n",
        ),
        loadPipeline
            ? SizedBox(
                width: Get.width,
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: yd_Color_Primary,
                )),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: yd_defauld_padding),
                        child: Text(
                          "Open",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: yd_defauld_padding - 5,
                      ),
                      if (modelPipelineFinancing!.data!.open!.length <= 0)
                        Text(" ")
                      else
                        for (var a in modelPipelineFinancing!.data!.open!)
                          InkWell(
                            hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            highlightColor:
                                yd_Color_Primary_Grey.withOpacity(0.3),
                            onTap: () {
                              Get.to(
                                () => DaftarKartuFinancing(
                                  isFinancing: false,
                                  modelReturnPipeline: ModelReturnPipeline(
                                    id: a.id!,
                                    title: a.title!,
                                    category: a.category!,
                                    isActive: true,
                                  ),
                                ),
                              )!.then((value) async {
                                bool val = await Utils.getUpdatePipeline();
                                if(val){
                                  getPipelineRefinancing();
                                  leadCount.getLeadCount();
                                }
                              });
                            },
                            child: cardPipeline(
                              isClose: false,
                              totalAmount: a.totalCard,
                              section: a.title,
                              position: a.category,
                            ),
                          ),
                    ],
                  ),
                  SizedBox(
                    height: yd_defauld_padding * 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: yd_defauld_padding),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: yd_defauld_padding - 5,
                      ),
                      if (modelPipelineFinancing!.data!.close!.length <= 0)
                        Text(" ")
                      else
                        for (var a in modelPipelineFinancing!.data!.close!)
                          InkWell(
                            hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
                            highlightColor:
                                yd_Color_Primary_Grey.withOpacity(0.3),
                            onTap: () {
                              Get.to(
                                () => DaftarKartuFinancing(
                                  isFinancing: false,
                                  modelReturnPipeline: ModelReturnPipeline(
                                    id: a.id!,
                                    title: a.title!,
                                    category: a.category!,
                                    isActive: true,
                                  ),
                                ),
                              )!.then((value) async {
                                bool val = await Utils.getUpdatePipeline();
                                if(val){
                                  getPipelineRefinancing();
                                  leadCount.getLeadCount();
                                }
                              });
                            },
                            child: cardPipeline(
                              isClose: true,
                              totalAmount: a.totalCard,
                              section: a.title,
                              position: a.category,
                            ),
                          ),
                    ],
                  )
                ],
              ),
        SizedBox(
          height: yd_defauld_padding * 8,
        ),
      ],
    );
  }
}
