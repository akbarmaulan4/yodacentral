
import 'package:yodacentral/models/model_chat_lead.dart';
import 'package:yodacentral/models/chat/chat_item.dart';
part 'chat_model.g.dart';
class NewChatModel{
  NewChatModel();
  String tanggal = '';
  List<ChatItem?> chats = [];

  factory NewChatModel .fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}