import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/cant_find.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/widget_load_primary.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_search_chat/controller_search_chat.dart';
import 'package:yodacentral/models/chat/chat_item.dart';
import 'package:yodacentral/screens/chat/chat.dart';

class ListSearchChat extends StatefulWidget {
  const ListSearchChat({Key? key}) : super(key: key);

  @override
  _ListSearchChatState createState() => _ListSearchChatState();
}

class _ListSearchChatState extends State<ListSearchChat> {

  ControllerSarchChat controllerSarchChat = Get.put(ControllerSarchChat());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var sdad = controllerSarchChat.dataChat;
    // var dsa = '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSarchChat>(builder: (v) {
      return SingleChildScrollView(
        child: v.load ?
        widgetLoadPrimary() :
        v.dataChat.length > 0 ? Column(
          children: v.dataChat.map((e) => card_chat_search(e!)).toList(),
        ):SizedBox(
          height: Get.height - 250,
          child: cantFind(
            title: "Pencarian Tidak Ditemukan",
            content: "Silahkan coba masukkan kata kunci lain.",
          ),
        )
          );
    });
  }
}

Widget card_chat_search(ChatItem data) {
  return InkWell(
    hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
    focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
    splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
    highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
    onTap: () {
      // history.addHistory(text: a.modelName!);
      Get.to(() => Chat(
          nameCar: data.name,
          namePipeline: '',
          pipeline: 0,
          id_unit: data.lead_id,
          lead_id: data.lead_id,
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(yd_defauld_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          Container(
            width: Get.width / 6,
            height: Get.width / 6,
            decoration: BoxDecoration(
              color: yd_Color_Primary_Grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: imageNetworkHandler(
              urlImage: data.photo_profile,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  data.message,
                  style: TextStyle(fontSize: 14, color: yd_Color_Primary_Grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
