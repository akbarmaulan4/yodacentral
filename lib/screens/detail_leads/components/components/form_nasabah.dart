
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/form_dokument.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/form_identitas.dart';
import 'package:yodacentral/screens/detail_leads/components/nasabah/form_kerjaan.dart';
import 'package:yodacentral/screens/detail_leads/components/tab_top_detail_leads.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/utils/utils.dart';

class AddFormNasabah extends StatefulWidget {
  const AddFormNasabah({
    Key? key,
    required this.namePipeline,
    required this.unit_id,
    required this.lead_id,
    required this.onBack
  }) : super(key: key);
  final String namePipeline;
  final int unit_id;
  final int lead_id;
  final Function onBack;

  @override
  _AddFormNasabahState createState() => _AddFormNasabahState();
}

class _AddFormNasabahState extends State<AddFormNasabah> {
  // int page = 0;
  PageController pageController = PageController(keepPage: true);
  NasabahController controller = Get.put(NasabahController());
  var menus = ["Identitas", "Pekerjaan", "Dokumen"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initFormNasabah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black,),
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.namePipeline, style: TextStyle(color: Colors.black, fontSize: 16,),),
                  Text("#" + widget.unit_id.toString(), style: TextStyle(fontSize: 12, color: Colors.black,),),
                ],
              ),
            )
          ],
          bottom: PreferredSize(
            child: Obx(()=>TabTopDetailLeads(
              index: controller.indexPage.value,
              menu: menus,
              onClick: (i) {
                if(controller.indexPage.value == 0){
                  if(!controller.allFieldIdentityEmpty && !controller.enableButton.value){
                    Utils.messageAlertDialog(context, 'Peringatan', 'Isi setiap validasi field di form Identitas dengan benar', () { });
                    return;
                  }
                }else if(controller.indexPage.value == 1){
                  if(!controller.allFieldKerjaanEmpty && !controller.enableButtonInstitusi.value){
                    Utils.messageAlertDialog(context, 'Peringatan', 'Penuhi semua validasi di form Pekerjaan sebelum pindah tab', () { });
                    return;
                  }
                }
                // else if(controller.indexPage.value == 2){
                //   if(!controller.enableButtonFoto.value){
                //     Utils.messageAlertDialog(context, 'Peringatan', 'Penuhi semua validasi di form Dokumen sebelum pindah tab', () { });
                //     return;
                //   }
                // }
                controller.changePage(i);
                pageController.jumpToPage(i);
                controller.initFormNasabah();
              },
            )),
            preferredSize: Size.fromHeight(60.0),
          ),
        ),
        body: Obx(()=>PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            FormIdentitas(
              hasComplete: controller.identityComplete.value,
              onSave: ()=>controller.initFormNasabah(),
              allComplete: controller.allDOkNasabahComplete.value,
              lead_id: widget.lead_id,
              onNext: (){
                widget.onBack();
                // controller.changePage(1);
                // pageController.jumpToPage(1);
              },
            ),
            FormPekerjaan(
              hasComplete: controller.institusiComplete.value,
              onSave: ()=>controller.initFormNasabah(),
              allComplete: controller.allDOkNasabahComplete.value,
              lead_id: widget.lead_id,
              onNext: (){
                // controller.changePage(2);
                // pageController.jumpToPage(2);
                widget.onBack();
              },
            ),
            FormIDokumen(
              hasComplete: controller.fotoNasabah.value,
              onSave: ()=>controller.initFormNasabah(),
              allComplete:  controller.allDOkNasabahComplete.value,
              lead_id: widget.lead_id,
              onNext: ()=>widget.onBack(),
            ),
          ],
        )));
  }
}
