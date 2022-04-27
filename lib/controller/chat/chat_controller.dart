
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/models/chat/chat_model.dart';
import 'package:yodacentral/models/model_chat_lead.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/utils/utils.dart';
import 'package:yodacentral/models/chat/chat_item.dart';

class ChatController extends GetxController{

  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  TextEditingController edtChat = TextEditingController();
  RxList<NewChatModel> allChat = <NewChatModel>[].obs;

  List<NewChatModel> _dataChat = [];
  List<NewChatModel> get dataChat => _dataChat;

  refreshChat(ChatItem data){
    List<NewChatModel> model = dataChat.where((element) => element.tanggal.toLowerCase() == 'hari ini').toList();
    if(model.length > 0){
       model.first.chats.add(data);
    }else{
      NewChatModel chatModel = NewChatModel();
      List<ChatItem> item = [];
      item.add(data);
      chatModel.tanggal = 'Hari ini';
      chatModel.chats = item;
      dataChat.add(chatModel);
    }
    allChat.value = dataChat;
  }

  getChat({String? leadId}) async{
    dataChat.clear();
    loading.value = true;
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/chat/"+leadId!);
    var res = await http.get(url!, headers: {
      'Authorization': 'Bearer ' + data.token.toString(),
    });
    var jsonDecode = json.decode(res.body);
    var dataJson = jsonDecode as Map<String, dynamic>;
    var sda = json.encode(jsonDecode);
    print('RESPONSE ${json.encode(jsonDecode)}');
    List<NewChatModel> chats = [];
    if (res.statusCode == 200) {
      var data = ModelChatLead.fromMap(dataJson);
      if(data != null){
        var sdaas= data.data!.chats;
        data.data!.chats.forEach((dynamicKey, list) {
          NewChatModel chatModel = NewChatModel();
          chatModel.tanggal = dynamicKey;
          chatModel.chats = List<ChatItem>.from(list.map((x) => ChatItem.fromJson(x)));
          chats.add(chatModel);
        });
      }
      _dataChat = chats;
      allChat.value = chats;
    } else {
      errorMessage.value =  dataJson['message'];
    }
    loading.value = false;
  }

  sendChat(BuildContext context, String unitId, Function onSuccess) async{
    Utils.loading(context, 'Loading...');
    loading.value = true;
    var data = await SaveRoot.callSaveRoot();
    var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/chat/$unitId");
    var res = await http.post(url!, headers: {'Authorization': 'Bearer ' + data.token.toString()}, body: {'message': edtChat.text});
    edtChat.text = '';
    Get.back();
    if (res.statusCode == 200) {
      var jsonDecode = json.decode(res.body);
      var dataJson = jsonDecode as Map<String, dynamic>;
      var data = dataJson['data'];
      print('RESPONSE ${json.encode(jsonDecode)}');
      ChatItem chatItem = ChatItem.fromJson(data);

      // chatItem.id = data['id'];
      // ChatModel chat = new ChatModel(
      //     id: data['id'],
      //   userId: data['user_id'],
      //   leadId:  int.parse(data['lead_id']),
      //   message: data['message'],
      //   category: data['category'],
      //   createdAt: DateTime.parse(data['created_at']),
      //   name: data['name'],
      //   photoProfile: data['photo_profile'],
      //   self: data['self'],
      //   sortRole: data['sort_role'],
      //   time: data['time']
      // );
      onSuccess(chatItem);
    }
    loading.value = false;
  }
}