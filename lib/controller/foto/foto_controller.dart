
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/components/rawBottomNotif.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/detail_leads/edit_leads/edit_foto_unit/edit_foto_unit.dart';
import 'package:yodacentral/utils/utils.dart';
import 'package:http/http.dart' as http;

class FotoController extends GetxController{
  RxString status = 'add'.obs;

  changeStatus(String val){
    status.value = val;
  }

  setCover(BuildContext context, String unitID) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain}${ApiUrl.tambahImage}/${unitID}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    request.fields.addAll({'_method':'put'});
    request.fields.addAll({'cover': '1'});
  }

  updateImage(BuildContext context, String unitID, List<String> imgAwal, List<ModelListImageUpload> imgBaru) async{
    Utils.loading(context, 'Mohon tunggu...');
    var data = await SaveRoot.callSaveRoot();
    String bar = "Bearer ${data.token}";
    var headers = {"Authorization": bar};
    String url = '${ApiUrl.domain}${ApiUrl.tambahImage}/${unitID}';

    print('URL : ${url}');
    var request = http.MultipartRequest('POST', Uri.parse(url.trim()));
    print('TOKEN : ${data.token.toString()}');

    request.fields.addAll({'_method':'put'});
    request.fields.addAll({'cover': '1'});
    for(var i=0; i<imgAwal.length; i++){
      request.fields.addAll({'preserved_photo[$i]':imgAwal[i]});
    }
    // List<File> dataImgBaru = [];
    for (var i = 0; i < imgBaru.length; i++) {
      // dataImgBaru.add(File(imgBaru[i].image!.path));
      request.fields.addAll({'photo_unit[$i]': imgBaru[i].image!.path});
      request.files.add(await http.MultipartFile.fromPath('photo_unit[$i]', imgBaru[i].image!.path,));
    }

    print(jsonEncode(request.fields));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    Get.back();
    if (response.statusCode == 200) {
      if (Get.isBottomSheetOpen == true) Get.back();
      print(await response.stream.bytesToString());
      Get.back();
      Get.bottomSheet(
        GlobalScreenNotif(
          title: "Berhasil",
          content: "Foto berhasil di update",
          onTap: () {
            Get.back();
          },
          textButton: "Selesai",
        ),
        isScrollControlled: true,
      );
    } else {
      if (Get.isBottomSheetOpen == true) Get.back();
      rawBottomNotif(
        message: response.statusCode.toString() +
            " | " +
            await response.stream.asBroadcastStream().isBroadcast.toString(),
        colorFont: Colors.white,
        backGround: Colors.red,
      );
      // log(response.statusCode.toString());
      // log(response.reasonPhrase.toString());
      // log(await response.stream.bytesToString());
    }
  }
}