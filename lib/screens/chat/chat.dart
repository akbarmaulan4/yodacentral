import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/chat/chat_controller.dart';
import 'package:yodacentral/models/model_chat_lead.dart';
import 'package:yodacentral/screens/chat/components/card_chat.dart';
import 'package:yodacentral/screens/chat/components/text_notif.dart';
import 'package:yodacentral/models/chat/chat_model.dart';

//////chat menggunakan id_unit
class Chat extends StatefulWidget {
  const Chat({
    Key? key,
    required this.nameCar,
    required this.namePipeline,
    required this.pipeline,
    required this.id_unit,
    required this.lead_id,
  }) : super(key: key);
  final String nameCar;
  final String namePipeline;
  final int pipeline;
  final int id_unit;
  final int lead_id;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // ModelChatLead? modelChatLead;
  // bool? load = true;
  List<Chat> chat = [];
  List<ChatModel> dataChat = [];
  ChatController controller = ChatController();

  refresh(var data){
   // setState(() {
   //   // modelChatLead!.data!.chats!.add(data);
   //   dataChat.add(data);
   // });
    controller.refreshChat(data);
   Timer(Duration(milliseconds: 500), () => scrollController.jumpTo(scrollController.position.minScrollExtent));
  }

  // getChatLead() async {
  //   setState(() {
  //     load = true;
  //   });
  //   SaveRoot.callSaveRoot().then((value) async {
  //     var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/lead/chat/" + widget.lead_id.toString(),);
  //     var res = await http.get(url!, headers: {
  //       'Authorization': 'Bearer ' + value.token.toString(),
  //     });
  //     log(res.body, name: "res chat");
  //     if (res.statusCode == 200) {
  //       var jsonDecode = json.decode(res.body);
  //       var dataJson = jsonDecode as Map<String, dynamic>;
  //       setState(() {
  //         modelChatLead = modelChatLeadFromMap(res.body);
  //         modelChatLead!.data!.chats!.forEach((dynamicKey, list) {
  //           // dynamicKey will be 'ones', 'twos', ....
  //           // list will be the corresponding list of maps
  //           dataChat = List<ChatModel>.from(list.map((x) => ChatModel.fromMap(x)));
  //           print(dynamicKey);
  //         });
  //         load = false;
  //       });
  //       log(res.body);
  //     } else {
  //       setState(() {
  //         modelChatLead = null;
  //         load = false;
  //       });
  //       log(res.body);
  //     }
  //     log(url.toString());
  //   });
  // }

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // getChatLead();
    // log(widget.id_unit.toString(), name: "idpipeline");
    super.initState();
    controller.getChat(leadId:  widget.lead_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.nameCar, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Text(widget.namePipeline, style: TextStyle(color: Colors.black,)),
                ]
            ),
          )
        ],
      ),
      body: Obx(()=>MediaQuery(
        data: scaleFactor,
        child: Column(
          children: [
            Expanded(
                child: controller.loading.value ? widgetLoadPrimary() :
                controller.allChat.length < 1 ? Center(child: Text("Tidak ada Chat")) : Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    reverse: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.allChat.value.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (contex, index){
                          return loadChat(controller.allChat.value[index]);
                        }
                    ),
                  ),
                )
            ),
            Container(
              color: Color(0xFFD9EDE9),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 20, maxHeight: 80),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),),
                    width: Get.width / 1.35,
                    child: TextField(
                      controller: controller.edtChat,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Kirim pesan",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF5F4),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: yd_Color_Primary_Grey.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: controller.loading.value ? Container(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(),
                    ) : InkWell(
                      onTap: (){
                        if(controller.edtChat.text != ''){
                          controller.sendChat(context, widget.lead_id.toString(), (data)=>refresh(data));
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }

  loadChat(NewChatModel data){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Colors.grey.shade300)
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(data.tanggal)
        ),
        SizedBox(height: 5),
        Column(
          children: data.chats.asMap().map((i, item) => MapEntry(i, Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            child: item!.category == 'event' ? textNotif(
              text: item.message + " at " + item.time.toString(),
              isNotEvent: false,
            ):Container(
              child: CardChat(
                isSame: i > 0 ? true : false,
                photo_profile: item.photo_profile,
                chat: item,
              ),
            ),
          ))).values.toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  rightBuble(){
    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.cyan[900],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Text(
                        'Ini contoh pesan sa8 svg hpogjmvoaahgiavhnhvwhtouavhvihWPEIVHTPOIEVHPTHVIOETVEWTET',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  // CustomPaint(painter: CustomShape(Colors.cyan[900])),
                ],
              )),
        ],
      ),
    );
  }

}
