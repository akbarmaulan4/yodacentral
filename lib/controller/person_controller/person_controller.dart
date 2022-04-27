
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/model_list_pic.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/person/person_role_model.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/models/person/person_model.dart';
import 'package:yodacentral/utils/utils.dart';
import 'package:yodacentral/models/person/pic_model.dart';
import 'package:yodacentral/models/person/cabang_model.dart';

class PersonController extends GetxController{
  RxList<PersonModel> dataPIC = <PersonModel>[].obs;
  RxList<PersonRoleModel> dataRolePIC = <PersonRoleModel>[].obs;
  Rx<ModelListPic> modelListPic = ModelListPic().obs;
  Rx<Cabang> cabangPIC = Cabang().obs;
  RxBool dataEmpty = false.obs;
  RxBool hasCO = false.obs;
  RxBool hasMO = false.obs;
  RxBool hasMH = false.obs;
  RxBool hasCR = false.obs;

  List<PersonModel> _dataPIC = <PersonModel>[];
  List<PersonModel> get getDataPIC => _dataPIC;

  List<PersonRoleModel> _dataRole = <PersonRoleModel>[];
  List<PersonRoleModel> get dataRole => _dataRole;

  TextEditingController edtSearch = TextEditingController();

  getNewPIC({String? leadID,  Function? onError}) async{
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/pic/${leadID}");
    print('URL ${url}');
    var res = await http.get(url!, headers: {'Authorization': 'Bearer ' + data.token.toString()});
    dataEmpty.value = false;
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print(jsonEncode(dataJson));
      var data = ModelListPic.fromMap(dataJson);
      modelListPic.value = data;
      if(data != null){
        cabangPIC.value = data.data!.cabang!;
        dataEmpty.value = true;
        var mh = data.data!.pic!.where((element) => element.roleId == 5).toList();
        var cr = data.data!.pic!.where((element) => element.roleId == 2).toList();
        var co = data.data!.pic!.where((element) => element.roleId == 6).toList();
        var mo = data.data!.pic!.where((element) => element.roleId == 7).toList();
        if(mh.length > 0){
          hasMH.value = true;
        }
        if(cr.length > 0){
          hasCR.value = true;
        }
        if(co.length > 0){
          hasCO.value = true;
        }
        if(mo.length > 0){
          hasMO.value = true;
        }
      }
    }else{
      dataEmpty.value = true;
      onError!(res.body);
    }
  }

  getAllOfficerByCabang({String? idRole, String? cabangID}) async{
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/pic/role/${idRole}/${cabangID}");
    print('URL ${url}');
    var res = await http.get(url!, headers: {'Authorization': 'Bearer ' + data.token.toString()});
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      dataEmpty.value = false;
      var data = (dataJson['data'] as List).map((e) => e == null ? null : PersonModel.fromJson(e as Map<String, dynamic>)).toList();
      if(data != null){
        if(data.length > 0){
          dataPIC.value = data as List<PersonModel>;
          _dataPIC.addAll(data as List<PersonModel>);
        }else{
          dataEmpty.value = true;
        }
      }else{
        dataEmpty.value = true;
      }
    }else{
      dataEmpty.value = true;
    }
  }

  setPIC({BuildContext? context, String? userId, String? leadId, Function? onSuccess, Function? onError}) async{
    Utils.loading(context!, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + ApiUrl.setPic.toString());
    print('URL ${ApiUrl.domain.toString() + ApiUrl.setPic.toString()}');
    var res = await http.post(url!, headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: {
      'user_id' : userId,
      'lead_id': leadId
    }).timeout(Duration(seconds: 30), onTimeout: ()=>timeout(onError!));
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      print('RESPONSE ${json.encode(jsonDecode)}');
      onSuccess!('success');
    }
  }

  timeout(Function? onError){
    Get.back();
    onError!('Timeout');
  }

  searchPIC(String val){
    var data = dataPIC.where((data) => data.name.toLowerCase().contains(val.toLowerCase())).toList();
    dataPIC.value = data;
  }

  getFirts(){
    var data = getDataPIC;
    dataPIC.value = data;
  }


}