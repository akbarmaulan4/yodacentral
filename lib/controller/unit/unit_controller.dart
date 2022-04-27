
import 'dart:convert';

import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/pipeline/pipeline_model.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:http/http.dart' as http;

class UnitController extends GetxController{
  RxInt idPipeline = 0.obs;
  RxString titlePipeline = ''.obs;
  RxList<PipelineModel> dataOpen = <PipelineModel>[].obs;
  RxList<PipelineModel> dataClose = <PipelineModel>[].obs;

  changeIdPipeline(int val, String title){
    idPipeline.value = val;
    titlePipeline.value = title;
  }

  getPipeline({Function? onSuccess, String? path}) async {
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/lead/list-pipeline/$path';
    print('URL ${url}');
    print('TOKEN ${value.token.toString()}');
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var open = (dataJson['data']['open']  as List).map((e) => e == null ? null : PipelineModel.fromJson(e as Map<String, dynamic>)).toList();
      var close = (dataJson['data']['close'] as List).map((e) => e == null ? null : PipelineModel.fromJson(e as Map<String, dynamic>)).toList();
      if(open != null){
        Map map = Map();
        map.addAll({'open':open, 'close':close});
        dataOpen.value = open as List<PipelineModel>;
        dataClose.value = close as List<PipelineModel>;
        onSuccess!(map);
      }
      print('RESPONSE ${json.encode(jsonDecode)}');
    }
  }

  updatePipeline({int? leadId, int? idPipeline, String? titlePipe, Function? onSuccess}) async{
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/lead/update/$leadId';
    print('URL ${url}');
    print('TOKEN ${value.token.toString()}');
    var res = await http.post(Uri.parse(url.trim()),
      headers: {'Authorization': 'Bearer ' + value.token.toString()},
      body: {
        'idPipeline':idPipeline.toString(),
        '_method':'put'
      }
    );
    var jsonDecode = json.decode(res.body);
    if (res.statusCode == 200) {
      var dataJson = jsonDecode as Map<String, dynamic>;
      changeIdPipeline(idPipeline!, titlePipe!);
      onSuccess!(titlePipe);
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Berhasil merubah pipeline",
          onTap: () {
            Get.back();
            // onSuccess!(titlePipe);
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
      print('RESPONSE ${json.encode(jsonDecode)}');
    }
    print('RESPONSE ${json.encode(jsonDecode)}');
  }

  reloadPipeling(Function onReload){
    onReload();
  }
}