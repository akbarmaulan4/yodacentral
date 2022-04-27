import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/controller/person_controller/person_controller.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/informasi_seller_mobil.dart';

class SearchPIC extends StatefulWidget {
  String? leadId;
  String? idRole;
  String? role;
  String? cabangID;
  SearchPIC({this.idRole, this.leadId, this.role, this.cabangID});
  @override
  _SearchPICState createState() => _SearchPICState();
}

class _SearchPICState extends State<SearchPIC> {
  PersonController controller = PersonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllOfficerByCabang(idRole: widget.idRole, cabangID: widget.cabangID);
    // controller.getAllOfficerByLead(leadID: widget.leadId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  children: [
                    InkWell(child: Icon(Icons.arrow_back_rounded), onTap: ()=> Get.back()),
                    Expanded(child: InkWell(
                      onTap: ()=>Get.back(),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text('Batalkan', style: TextStyle(color: yd_Color_Primary, fontWeight: FontWeight.bold),),
                      ),
                    ))
                  ],
                ),
              ),
              Text(widget.role!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),),
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
                onChanged: (val){
                  if(val != ''){
                    controller.searchPIC(val);
                  }else{
                    controller.getFirts();
                  }
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: controller.dataPIC.value.length > 0 ? controller.dataPIC.value.map((element) => InkWell(
                        onTap: ()=>controller.setPIC(
                            context: context,
                            leadId: widget.leadId,
                            userId: element.id.toString(),
                          onSuccess: (val){
                            Get.bottomSheet(
                              GlobalScreenNotif(
                                title: "Berhasil",
                                content: "${widget.role!} berhasil dirubah",
                                onTap: () {
                                  Get.back();
                                  Get.back();
                                },
                                textButton: "Selesai",
                              ),
                              isScrollControlled: true,
                            );
                            // rawBottomNotif(
                            //   message: val,
                            //   colorFont: Colors.white,
                            //   backGround: Colors.green,
                            // );
                          }
                        ),
                        child: cardSellerSearch(
                          name: element.name,
                          alamat: element.role,
                          imageUrl: element.photo_profile,
                        ),
                      )).toList():[
                        controller.dataEmpty.value ? Center(
                          child: Text('Belum terdapat data ${widget.role} untuk saat ini, silahakan hubungi petugas terkait',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ) : Padding(
                          padding: EdgeInsets.all(15),
                          child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: yd_Color_Primary,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
