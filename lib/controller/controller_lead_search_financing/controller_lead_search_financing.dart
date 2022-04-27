import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/controller/controller_history/controller_history.dart';
import 'package:yodacentral/models/model_lead_search_financing.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';

class ControllerLeadSearchFinancing extends GetxController {
  bool load = true;
  ModelLeadSearchFinancing? modelLeadSearchFinancing;
  ControllerHistory controllerHistory = Get.put(ControllerHistory());

  searchLead({
    String? search,
    String? filter,
  }) async {
    // log(filter!, name: "ini filter");
    load = true;
    update();

    Uri? url;

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    if (search == null || search == '') {
      url = Uri.parse('${ApiUrl.domain.toString()}/api/lead/search/Financing?filter=$filter&page=1&perpage=50');
    } else if (filter == null) {
      url = Uri.parse(ApiUrl.domain.toString() + "/api/lead/search/Financing?search=$search&page=1&perpage=50");
    } else if (search.length != 0 && filter.length != 0) {
      url = Uri.parse(ApiUrl.domain.toString() + "/api/lead/search/Financing?search=$search&filter=$filter&page=1&perpage=50");
    } else if (search == null && filter == null) {
      url = Uri.parse(ApiUrl.domain.toString() + "/api/lead/search/Financing");
    }

    log('URL : ${url.toString()}');
    var res = await http.get(url!, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      load = false;
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var sdas  = json.encode(jsonDecode);
      print('RESPONSE ${json.encode(jsonDecode)}');
      modelLeadSearchFinancing = modelLeadSearchFinancingFromMap(res.body);

      log(res.body);
      update();
    } else {
      load = false;
      log(res.body);
      modelLeadSearchFinancing = null;
      update();
    }
    update();
  }

  searchLeadRefinancing({
    String? search,
    String? filter,
  }) async {
    // log(filter!, name: "ini filter");
    load = true;
    update();
    // String filter = "&filter=[1,2]";
    // /////[1.2.3];
    // String search = "?search=$";
    Uri? url;

    // if (search == null || search.length <= 0 && filter != null) {
    //   url = Uri.tryParse(ApiUrl.domain.toString() +
    //       "/api/lead/search/Financing?filter=$filter");
    // } else if (search.isNotEmpty ||
    //     search.length > 0 && filter == null ||
    //     filter!.length == 0) {
    //   url = Uri.tryParse(ApiUrl.domain.toString() +
    //       "/api/lead/search/Financing?search=$search");
    // } else if (search.length != 0 && filter != null) {
    //   url = Uri.tryParse(ApiUrl.domain.toString() +
    //       "/api/lead/search/Financing?search=$search&filter=$filter");
    // }

    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    if (search == null) {
      url = Uri.parse(ApiUrl.domain.toString() +
          "/api/lead/search/Refinancing?filter=$filter");
    } else if (filter == null) {
      url = Uri.parse(ApiUrl.domain.toString() +
          "/api/lead/search/Refinancing?search=$search");
    } else if (search.length != 0 && filter.length != 0) {
      url = Uri.parse(ApiUrl.domain.toString() +
          "/api/lead/search/Refinancing?search=$search&filter=$filter");
    } else if (search == null && filter == null) {
      url = Uri.parse(
          ApiUrl.domain.toString() + "/api/lead/search/Refinancing");
    }

    log(url.toString());
    var res = await http.get(url!, headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      load = false;
      modelLeadSearchFinancing = modelLeadSearchFinancingFromMap(res.body);
      // controllerHistory.addHistory(text: search);

      log(res.body);
      update();
    } else {
      load = false;
      log(res.body);
      modelLeadSearchFinancing = null;
      update();
    }
    update();
  }
}
