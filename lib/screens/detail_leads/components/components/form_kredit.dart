import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/controller/kredit/kredit_controller.dart';

import '../tab_top_detail_leads.dart';
import 'package:yodacentral/screens/detail_leads/components/kredit/jaminan_view.dart';
import 'package:yodacentral/screens/detail_leads/components/kredit/kontrak_view.dart';

class FormKredit extends StatefulWidget {
  const FormKredit({Key? key, required this.unit_id, required this.lead_id, this.onBack}) : super(key: key);
  final int unit_id;
  final int lead_id;
  final Function? onBack;

  @override
  _FormKreditState createState() => _FormKreditState();
}

class _FormKreditState extends State<FormKredit> {
  KreditController controller = KreditController();
  PageController pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          bottom: PreferredSize(
            child: Obx(()=>TabTopDetailLeads(
              index: controller.pageKredir.value,
              menu: ["Jaminan", "Kontrak"],
              onClick: (int value) {
                controller.changePage(value);
                pageController.jumpToPage(value);
                // controller.initFormKredit();
              },
            )),
            preferredSize: Size.fromHeight(60.0),
          ),
        ),
        body: Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Container(
                child: JaminanView(
                  lead_id: widget.lead_id,
                  unit_id: widget.unit_id,
                  onNext: (){
                    widget.onBack!();
                    // controller.changePage(1);
                    // pageController.jumpToPage(1);
                  },
                ),
              ),
              Container(
                child: KontrakView(
                  lead_id: widget.lead_id,
                  unit_id: widget.unit_id,
                  onNext: (){
                    widget.onBack!();
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
