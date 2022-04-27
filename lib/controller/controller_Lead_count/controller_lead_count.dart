import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_lead_count.dart';
import 'package:yodacentral/models/model_lead_search_financing.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/login.dart';
import 'package:yodacentral/utils/utils.dart';
import 'package:yodacentral/models/access/access_item.dart';

class ControllerLeadCount extends GetxController {

  RxList<AccessItem?> accessMenu = <AccessItem?>[].obs;
  RxInt tambahUnit = 0.obs;
  ModelLeadCount? modelLeadCount;
  bool loadCount = true;

  logout(){
    Future.delayed(Duration(milliseconds: 300), () {
      SaveRoot.deleteSaveRoot();
      if (Get.isBottomSheetOpen == true) Get.back();
      update();
    });

    // modelSaveRoot = null;
    update();
  }

   getLeadCount() async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    loadCount = true;
    String strUrl = '${ApiUrl.domain.toString()}${ApiUrl.leadCount.toString()}';
    var res = await http.get(Uri.parse(strUrl.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if(res.statusCode == 401){
      Utils.messageAlertDialog(Get.context!, 'Informasi', 'Maaf, anda harus login kembali', () {
        logout();
        // SaveRoot.deleteSaveRoot();
        // Get.offAll(()=>Login());
      });
    } else if (res.statusCode == 200) {
      // var jsonDecode = json.decode(res.body);
      // var dataJson = jsonDecode as Map<String, dynamic>;
      // print('RESPONSE ${json.encode(jsonDecode)}');
      modelLeadCount = modelLeadCountFromMap(res.body);
      loadCount = false;
      update();
    } else {
      log(res.body, name: "gagal load lead count");
      loadCount = false;
      update();
    }
    update();
  }

  List<String> dsasd = [];
  getAccess(Function onSucces) async{
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + ApiUrl.homeAccess.toString());
    var res = await http.get(url!, headers: {
      'Authorization': 'Bearer ' + data.token.toString(),
    });
    var jsonDecode = json.decode(res.body);
    var dataJson = jsonDecode as Map<String, dynamic>;
    var sad = json.encode(jsonDecode);
    print('RESPONSE ${json.encode(jsonDecode)}');
    if (res.statusCode == 200) {
      MobileAccess access = MobileAccess.fromMap(dataJson['access']['mobile_access']);
      if(access != null){
        tambahUnit.value = access.tambahUnit!;
        onSucces(access.tambahUnit!);
      }
      // List<AccessItem?> data = (dataJson['access'] as List).map((e) => e == null ? null : AccessItem.fromJson(e as Map<String, dynamic>)).toList();
      // if(data != null){
      //   var accessMobile = data.where((element) => element!.category == 'Mobile').toList();
      //   accessMenu.value = accessMobile;
      // }
    } else {
      // errorMessage.value =  dataJson['message'];
    }
  }
}
