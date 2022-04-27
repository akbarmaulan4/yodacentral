import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/api_url/api_url.dart';
// import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/models/model_lead_search_financing.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';

class ControllerSearchRefinancing extends GetxController {
  bool load = false;
  ModelLeadSearchFinancing? modelLeadSearchFinancing;

  searchRefinancing({String? search}) async {
    load = true;
    ModelSaveRoot value = await SaveRoot.callSaveRoot();

    var url = '${ApiUrl.domain.toString()}/api/lead/search/Refinancing?search=${search.toString()}';
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      load = false;
      log(res.body, name: "ini refinancing");
      modelLeadSearchFinancing = modelLeadSearchFinancingFromMap(res.body);
      // controllerHistory.addHistory(text: search);
      update();
    } else {
      load = false;
      update();
    }
    update();
  }
}
