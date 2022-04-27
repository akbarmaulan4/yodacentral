import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/models/chat/chat_item.dart';
import 'package:yodacentral/models/model_chat_lead.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';

class ControllerSarchChat extends GetxController {
  bool load = false;
  List<ChatItem?> dataChat = [];
  searchRefinancing({String? search}) async {
    load = true;
    ModelSaveRoot value = await SaveRoot.callSaveRoot();

    var url = '${ApiUrl.domain.toString()}/api/lead/search/Chat?search=${search.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      // print('RESPONSE ${data}');
      // controllerHistory.addHistory(text: search);
      load = false;
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      List<ChatItem?> data = (dataJson['data'] as List).map((e) => e == null ? null : ChatItem.fromJson(e as Map<String, dynamic>)).toList();
      if(data != null){
        dataChat=data;
      }
      // var data = ModelDetailNasabah.fromMap(dataJson);
      update();
    } else {
      load = false;
      update();
    }
    update();
  }
}
