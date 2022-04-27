import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/data_dummy_pipeline.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_lead_search_financing/controller_lead_search_financing.dart';
import 'package:yodacentral/controller/unit/unit_controller.dart';
import 'package:yodacentral/models/model_dummy_pipeline/model_dummy_pipeline.dart';
import 'package:yodacentral/screens/daftar_kartu_financing_refinancing/daftar_kartu_financing/components/card_list_financing_search.dart';
import 'package:yodacentral/screens/daftar_kartu_financing_refinancing/daftar_kartu_financing/components/filterChipCustom.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/screens/detail_leads/detail_leads.dart';
import 'package:yodacentral/utils/utils.dart';

class DaftarKartuFinancing extends StatefulWidget {
  const DaftarKartuFinancing(
      {Key? key, required this.modelReturnPipeline, required this.isFinancing, this.onBack})
      : super(key: key);
  final bool isFinancing;
  final ModelReturnPipeline modelReturnPipeline;
  final Function? onBack;

  @override
  _DaftarKartuFinancingState createState() => _DaftarKartuFinancingState();
}

class _DaftarKartuFinancingState extends State<DaftarKartuFinancing> with WidgetsBindingObserver {

  FocusNode fSearch = new FocusNode();
  TextEditingController search = TextEditingController();
  ControllerLeadSearchFinancing controllerLeadSearchFinancing = Get.put(ControllerLeadSearchFinancing());
  List<ModelReturnPipeline> listSearch = [];
  bool show = false;

  Widget searchTop() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(yd_defauld_padding),
        border: Border.all(
          color: yd_Color_Primary_Grey,
        ),
      ),
      margin: EdgeInsets.all(yd_defauld_padding),
      child: Column(
        children: [
          TextField(
            onChanged: (v) {
              List li = [
                for (var a in listSearch) a.id.toString(),
              ];
              log(li.toString());
              widget.isFinancing
                  ? controllerLeadSearchFinancing.searchLead(search: v, filter: listSearch.length == 0 ? null : li.toString())
                  : controllerLeadSearchFinancing.searchLeadRefinancing(search: v, filter: listSearch.length == 0 ? null : li.toString());
            },
            focusNode: fSearch,
            controller: search,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: fSearch.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,),
              hintText: "Cari",
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary_Grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: yd_Color_Primary_Grey),),
              prefixIcon: Icon(Icons.search, color: yd_Color_Primary_Grey),
            ),
          ),
          SizedBox(height: yd_defauld_padding),
          GestureDetector(
            onTap: () {
              setState(() {
                show ? show = false : show = true;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: yd_defauld_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter", style: TextStyle(fontWeight: FontWeight.bold,)),
                  Container(
                    decoration: BoxDecoration(color: yd_Color_Primary_Grey.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(show ? "Tutup daftar filter" : "Buka daftar filter", style: TextStyle(color: yd_Color_Primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: yd_defauld_padding / 2),
          show
              ? Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: SizedBox(
                    width: Get.width,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 7.5,
                        runSpacing: 0,
                        children: [
                          for (var a in widget.isFinancing
                              ? pipeLineFinancing
                              : pipeLineRefinancing)
                            FilterChipCustom(
                              isCek: listSearch.where((element) => element.id == a.id).length == 0 ? false : true,
                              onTap: (v) {
                                setState(() {
                                  listSearch.where((element) => v.id == element.id).length == 0 ? listSearch.add(v) : listSearch.removeWhere((element) => element.id == v.id);
                                  for (var gg in listSearch) {
                                    log(gg.id.toString(),);
                                  }
                                });
                                List li = [for (var a in listSearch) a.id.toString()];
                                log(li.toString());
                                widget.isFinancing
                                    ? controllerLeadSearchFinancing.searchLead(
                                        search: search.text.length == 0 ? null : search.text,
                                        filter: listSearch.length == 0 ? null : li.toString(),
                                      )
                                    : controllerLeadSearchFinancing.searchLeadRefinancing(search: search.text.length == 0 ? null : search.text,
                                        filter: listSearch.length == 0 ? null : li.toString());
                              },
                              modelPipeline: a,
                            ),
                        ]
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: SizedBox(
                    width: Get.width,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 7.5,
                        runSpacing: 0,
                        children: [
                          for (var a in listSearch)
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listSearch.removeWhere((element) => element.id == a.id);
                                  });
                                  List li = [for (var a in listSearch) a.id.toString()];
                                  log(li.toString());
                                  widget.isFinancing ? controllerLeadSearchFinancing.searchLead(search: search.text.length == 0 ? null : search.text, filter: listSearch.length == 0 ? null : li.toString())
                                      : controllerLeadSearchFinancing.searchLeadRefinancing(search: search.text.length == 0 ? null : search.text, filter: listSearch.length == 0 ? null : li.toString());
                                  log("message");
                                },
                                child: chipSelected(a)),
                        ]),
                  ),
                ),
        ],
      ),
    );
  }

  UnitController unitController = UnitController();
  @override
  void initState() {
    super.initState();
    listSearch.add(widget.modelReturnPipeline);
    int fil = widget.modelReturnPipeline.id;
    if (widget.isFinancing) {
      controllerLeadSearchFinancing.searchLead(filter: "[$fil]");
    } else {
      controllerLeadSearchFinancing.searchLeadRefinancing(filter: "[$fil]");
    }
    // refinancing
  }

  @override
  void dispose() {
    super.dispose();
  }

  refreshData(){
    // listSearch.add(widget.modelReturnPipeline);
    int fil = widget.modelReturnPipeline.id;
    if (widget.isFinancing) {
      controllerLeadSearchFinancing.searchLead(filter: "[$fil]");
    } else {
      controllerLeadSearchFinancing.searchLeadRefinancing(filter: "[$fil]");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerLeadSearchFinancing>(builder: (val) {
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
            centerTitle: true,
            title: Text(
              widget.isFinancing ? "Financing" : "Refinancing",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                searchTop(),
                val.load
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: yd_Color_Primary,
                        ),
                      )
                    : val.modelLeadSearchFinancing == null
                        ? Text("Data Tidak tersedia")
                        : Column(
                            children: [
                              for (var a in val.modelLeadSearchFinancing!.data!)
                                cardListFinancingSearch(
                                  isFinancing: widget.isFinancing,
                                  data: a,
                                  onClick: (data){
                                    Get.to(() => DetailLeads(
                                        unitForSeller: data!.unitId!,
                                        lead_id: data.id!,
                                        idPipeline: data.pipelineId!,
                                        isFinancing: widget.isFinancing,
                                        unit_id: data.unitId!,
                                        nameCar: data.modelName!,
                                        namePipeline: widget.isFinancing
                                            ? financing.where((element) => data.pipelineId == element.id).first.title
                                            : refinancing.where((element) => data.pipelineId == element.id).first.title,
                                        onBack: (){
                                          refreshData();
                                        },
                                      ),
                                    );
                                  }
                                ),
                            ],
                          )
              ],
            ),
          ),
        ),
      );
    });
  }
}
