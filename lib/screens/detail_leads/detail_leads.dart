import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/screens/detail_leads/components/tab_top_detail_leads.dart';
import 'package:yodacentral/screens/detail_leads/components/unit.dart';
import 'package:yodacentral/utils/utils.dart';
import 'components/kredit.dart';
import 'components/nasabah.dart';

class DetailLeads extends StatefulWidget {
  const DetailLeads({
    Key? key,
    required this.unit_id,
    required this.namePipeline,
    required this.nameCar,
    required this.isFinancing,
    required this.idPipeline,
    required this.lead_id,
    required this.unitForSeller,
    required this.onBack
  }) : super(key: key);
  final int unit_id;
  final String namePipeline;
  final int idPipeline;
  final String nameCar;
  final bool isFinancing;
  final int lead_id;
  final int unitForSeller;
  final Function onBack;

  @override
  _DetailLeadsState createState() => _DetailLeadsState();
}

class _DetailLeadsState extends State<DetailLeads> {
  int page = 0;
  ControllerAuth auth = Get.put(ControllerAuth());

  @override
  void initState() {
    super.initState();
    strTitlePipeline = widget.namePipeline;
    auth.detailLead(id: widget.lead_id.toString());
  }

  String nomerTlpSeller = "0";
  String nameUnit = "";
  String strTitlePipeline = '';

  Future<bool> popBack() async {
    widget.onBack();
    Get.back();
    return true;
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: popBack,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    strTitlePipeline,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "#" + widget.lead_id.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
          bottom: PreferredSize(
            child: Obx(()=>TabTopDetailLeads(
              index: page,
              // menu: auth.modelSaveRoot!.userData!.role! == "External" ? ["Unit", "Nasabah"]: null,
              menu: auth.menuLeads.value,
              onClick: (i) {
                setState(() {
                  page = i;
                });
              },
            )),
            preferredSize: Size.fromHeight(60.0),
          ),
        ),
        body: Obx(()=>Container(
          child: auth.menuLeads.value.length > 0 ? getChild(auth.menuLeads.value[page]):Container(
            child: Center(
                child: Text('Maaf anda tidak memiliki akses ke menu ini')),
          ) ,
        )),
      ),
    );
  }
  
  // loadMenu(List<String> data){
  //   List<Widget> menu = [];
  //   for(String str in  data){
  //     menu.add(getChild(str));
  //   }
  //   return menu;
  // }
  
  getChild(String label){
    switch(label){
      case 'Unit':
        return Unit(
          unitForSeller: widget.unitForSeller,
          lead_id: widget.lead_id,
          unit_id: widget.unitForSeller,
          nomerTlp: (v) {
            setState(() {
              nomerTlpSeller = v;
            });
          },
          isFinancing: widget.isFinancing,
          namePipeline: widget.namePipeline,
          idPipeline: widget.idPipeline,
          nameUnit: (String v) {
            setState(() {
              nameUnit = v;
            });
          },
          onUpdate: (val){
            // widget.onBack(val);
            Utils.saveUpdatePipeline(true);
            setState(() {
              strTitlePipeline = val;
            });
          },
        );
        case 'Nasabah':
          return Nasabah(
            isFinancing: widget.isFinancing,
            lead_id: widget.lead_id,
            unit_id: widget.unitForSeller,
            namePipeline: widget.namePipeline,
            idPipeline: widget.idPipeline,
            nameUnit: nameUnit,
          );
      case 'Kredit':
        return Kredit(
          isFinancing: widget.isFinancing,
          lead_id: widget.lead_id,
          unit_id: widget.unitForSeller,
          namePipeline: widget.namePipeline,
          idPipeline: widget.idPipeline,
          nameUnit: nameUnit,
        );
    }
  }
}
