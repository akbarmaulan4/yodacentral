import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:yodacentral/components/imgaeNetworkHandler.dart';
import 'package:yodacentral/components/yd_colors.dart';
// import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/models/model_chat_lead.dart';
import 'package:yodacentral/models/chat/chat_item.dart';

class CardChat extends StatefulWidget {
  const CardChat(
      {Key? key,
      this.photo_profile,
      // this.name = "User",
      // this.self = false,
      // this.message = "",
      // this.time = "00:00",
      this.isSame,
      required this.chat})
      : super(key: key);
  final ChatItem chat;
  final String? photo_profile;
  final bool? isSame;
  // final String? name;
  // final bool? self;
  // final String? message;
  // final String? time;

  @override
  _CardChatState createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  @override
  void initState() {
    super.initState();
    // log(widget.chat.self.toString());
  }

  @override
  Widget build(BuildContext context) {
    return widget.chat.self
        ? Padding(
            padding: EdgeInsets.only(top: widget.isSame! ? 1 : 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 15),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.isSame! ? SizedBox(width: 0,height: 0) : Column(
                          children: [
                            Text("Kamu",style: TextStyle(color: Color(0xFF6F7977))),
                            SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                              decoration: BoxDecoration(color: Color(0xFFE0E3E3),borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.chat.message),
                                  SizedBox(height: 5),
                                  Text(widget.chat.time, style: TextStyle(fontSize: 10,)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        : Padding(
            padding: EdgeInsets.only(top: widget.isSame! ? 1 : 15),
            child: Row(children: [
              widget.isSame! ? SizedBox(width: 35,height: 35) :
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Container(
                    width: 35,
                    height: 35,
                    color: yd_Color_Primary_Grey,
                    child: imageNetworkHandler(
                      urlImage: widget.photo_profile,
                      nama: widget.chat.name,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                fit: FlexFit.loose,
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isSame!? SizedBox(width: 0,height: 0) :
                      Text(widget.chat.name + widget.isSame.toString() + widget.chat.user_id.toString(), style: TextStyle(color: Color(0xFF6F7977),)),
                    SizedBox( height: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          decoration: BoxDecoration(
                            color: yd_Color_Primary,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(widget.chat.message, style: TextStyle(color: Colors.white,),),
                              SizedBox(height: 5),
                              Text(widget.chat.time, style: TextStyle(fontSize: 10,color: Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          );
  }
}
