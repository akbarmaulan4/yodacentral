import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/models/model_seller_search.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/save_root/save_root.dart';

class ControllerSearchSeller extends GetxController {
  Rx<ModelSellerSearch> dataSellerSearch = ModelSellerSearch().obs;
  RxBool loadData = false.obs;
  RxBool findData = false.obs;
  bool load = true;
  ModelSellerSearch? modelSellerSearch;
  searchSeller({String? search}) async {
    load = true;
    loadData.value = true;
    modelSellerSearch = null;
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/v1/penjual?perpage=0&search=${search!}';
    log(url.toString());
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    if (res.statusCode == 200) {
      modelSellerSearch = modelSellerSearchFromMap(res.body);
      dataSellerSearch.value = modelSellerSearchFromMap(res.body);
      log(res.body);
      load = false;
      loadData.value = false;
      findData.value = true;
      update();
    } else {
      findData.value = false;
      modelSellerSearch = null;
      dataSellerSearch.value = ModelSellerSearch();
      log(res.body);
      load = false;
      loadData.value = false;
      update();
    }
    update();
  }

  updateSeller({int? unitid, String? idPenjual, dynamic dataSeller, Function? onSuccess}) async{
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/lead/penjual/$unitid';
    print('URL ${url}');
    print('TOKEN ${value.token.toString()}');
    var bodyPos = {
      'seller_id':idPenjual.toString(),
      '_method':'put'
    };
    print('Bodu ${jsonEncode(bodyPos)}');
    var res = await http.post(Uri.parse(url.trim()),
        headers: {'Authorization': 'Bearer ' + value.token.toString()},
        body: bodyPos
    );
    if (res.statusCode == 200) {
      Get.back();
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Berhasil merubah Seller",
          onTap: () {
            Get.back();
            onSuccess!(dataSeller);
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    }
  }

  findSeller(String search) async{
    ModelSaveRoot value = await SaveRoot.callSaveRoot();
    var url = '${ApiUrl.domain.toString()}/api/v1/penjual?perpage=0&search=${search}';
    print('URL ${url}');
    print('TOKEN ${value.token.toString()}');
    var res = await http.get(Uri.parse(url.trim()), headers: {'Authorization': 'Bearer ' + value.token.toString()});
    var jsonDecode = json.decode(res.body);
    loadData.value = true;
    if (res.statusCode == 200) {
      dataSellerSearch.value = modelSellerSearchFromMap(res.body);
      loadData.value = false;
      findData.value = true;
    }else{
      dataSellerSearch.value = ModelSellerSearch();
      loadData.value = false;
      findData.value = false;
    }
  }
}
