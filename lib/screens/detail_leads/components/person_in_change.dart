import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/person_controller/person_controller.dart';
import 'package:yodacentral/controller/person_controller/person_controller.dart';
import 'package:yodacentral/models/model_list_pic.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/informasi_seller_mobil.dart';
import 'package:yodacentral/models/person/person_model.dart';
import 'package:yodacentral/screens/detail_leads/components/search_pic.dart';

class PesionInChange extends StatefulWidget {
  const PesionInChange({Key? key, required this.id, required this.namePipeline})
      : super(key: key);
  final String id;
  final String namePipeline;

  @override
  _PesionInChangeState createState() => _PesionInChangeState();
}

class _PesionInChangeState extends State<PesionInChange> {
  bool load = true;
  ModelListPic? modelListPic;
  PersonController controller = PersonController();
  // getPic({required String id}) async {
  //   setState(() {
  //     load = true;
  //   });
  //   ModelSaveRoot value = await SaveRoot.callSaveRoot();
  //   var url = '${ApiUrl.domain.toString()}/api/lead/detail_pic/${id.toString()}';
  //   var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
  //
  //   if (res.statusCode == 200) {
  //     setState(() {
  //       modelListPic = modelListPicFromMap(res.body);
  //       load = false;
  //     });
  //     log(res.body);
  //   } else {
  //     setState(() {
  //       load = false;
  //       rawBottomNotif(
  //         message: res.body,
  //         colorFont: Colors.white,
  //         backGround: Colors.red,
  //       );
  //       log(res.body);
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    controller.getNewPIC(leadID: widget.id);
    // controller.getAllPICRole(onError: (message){});
    // controller.getAllPICByCabang();
    // controller.getAllOfficerByLead(leadID: widget.id);
    // controller.getPIC(id: widget.id, onError: (message)=>rawBottomNotif(
    //   message: message,
    //   colorFont: Colors.white,
    //   backGround: Colors.red,
    // ));
  }

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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.namePipeline, style: TextStyle(color: Colors.black, fontSize: 16,),),
                Text(widget.id, style: TextStyle(fontSize: 12, color: Colors.black,)),
              ],
            ),
          )
        ],
      ),
      body: Obx(()=>SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(child: Text("Person in Charge", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,),),
            Padding(
              padding: EdgeInsets.all(yd_defauld_padding),
              child: Column(
                children: controller.modelListPic.value.data != null ? controller.modelListPic.value.data!.pic!.map((data) =>  InkWell(
                  onTap: ()=>data.roleId != 5 ? Get.to(()=>SearchPIC(
                    idRole: data.roleId.toString(),
                    leadId: data.leadId.toString(),
                    cabangID: controller.cabangPIC.value.id.toString(),
                    role: data.role.toString(),
                  ))!.then((value) => controller.getNewPIC(leadID: widget.id, onError: (message)=>rawBottomNotif(
                    message: message,
                    colorFont: Colors.white,
                    backGround: Colors.red,
                  ))):null,
                  child: cardSellerSearch(
                    name: data.name,
                    alamat: data.role,
                    imageUrl: data.photoProfile,
                  ),
                )).toList():[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: yd_Color_Primary,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: yd_defauld_padding),
              child: Column(
                children: [
                  !controller.hasMH.value ? newCard(label: 'Marketing Head', onClick: ()=>Get.to(()=>SearchPIC(
                    idRole: '5',
                    leadId: widget.id.toString(),
                    cabangID: controller.cabangPIC.value.id.toString(),
                    role: 'Marketing Head',
                  ))!.then((value) => controller.getNewPIC(leadID: widget.id, onError: (message)=>rawBottomNotif(
                    message: message,
                    colorFont: Colors.white,
                    backGround: Colors.red,
                  )))):SizedBox(),
                  !controller.hasCR.value ?newCard(label: 'Customer Relation', onClick: ()=>Get.to(()=>SearchPIC(
                    idRole: '2',
                    leadId: widget.id.toString(),
                    cabangID: controller.cabangPIC.value.id.toString(),
                    role: 'Customer Relation',
                  ))!.then((value) => controller.getNewPIC(leadID: widget.id, onError: (message)=>rawBottomNotif(
                    message: message,
                    colorFont: Colors.white,
                    backGround: Colors.red,
                  )))):SizedBox(),
                  !controller.hasCO.value ?newCard(label: 'Credit Officer', onClick: ()=>Get.to(()=>SearchPIC(
                    idRole: '6',
                    leadId: widget.id.toString(),
                    cabangID: controller.cabangPIC.value.id.toString(),
                    role: 'Credit Officer',
                  ))!.then((value) => controller.getNewPIC(leadID: widget.id, onError: (message)=>rawBottomNotif(
                    message: message,
                    colorFont: Colors.white,
                    backGround: Colors.red,
                  )))):SizedBox(),
                  !controller.hasMO.value ?newCard(label: 'Marketing Officer', onClick: ()=>Get.to(()=>SearchPIC(
                    idRole: '7',
                    leadId: widget.id.toString(),
                    cabangID: controller.cabangPIC.value.id.toString(),
                    role: 'Marketing Officer',
                  ))!.then((value) => controller.getNewPIC(leadID: widget.id, onError: (message)=>rawBottomNotif(
                    message: message,
                    colorFont: Colors.white,
                    backGround: Colors.red,
                  )))):SizedBox()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  showDialog(List<PersonModel> data){
    return showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: Get.context!,
      builder: (v) => SizedBox.expand(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_rounded),
                    Expanded(child: Container(
                      alignment: Alignment.centerRight,
                      child: Text('Batalkan'),
                    ))
                  ],
                ),
              ),
              Text('PIC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),),
              SizedBox(height: 30),
              TextField(
                // focusNode: _focusEmail,
                controller: controller.edtSearch,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.black87)),
                    fillColor: Colors.white,
                    hintText: 'Cari',
                    prefixIcon: Icon(Icons.person_search_rounded, color: Colors.black87),
                    contentPadding: EdgeInsets.only(left: 20)
                ),
                onChanged: (val)=> controller.searchPIC(val),
              ),
              SizedBox(height: 15),
              Obx(()=>Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: data.map((element) => InkWell(
                        onTap: ()=>controller.setPIC(context: context, leadId: element.id.toString(), userId: element.id.toString()),
                        child: cardSellerSearch(
                          name: element.name,
                          alamat: element.role,
                          imageUrl: element.photo_profile,
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  newCard({String? label, Function? onClick}){
    return InkWell(
      onTap: ()=>onClick!(),
      child: Container(
        // padding: EdgeInsets.all(yd_defauld_padding),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: Text(
                        label!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                width: Get.width / 4,
                height: Get.width / 4,
                decoration: BoxDecoration(
                  color: yd_Color_Primary_Grey.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Icon(Icons.supervised_user_circle_rounded, size: 40,),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
