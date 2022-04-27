part 'chat_item.g.dart';
class ChatItem{
  ChatItem(){}
  int id = 0;
  int lead_id = 0;
  int user_id = 0;
  String message = '';
  String created_at = '';
  String name = '';
  String photo_profile = '';
  String time = '';
  String sort_role = '';
  bool self = false;
  String category = '';

  factory ChatItem .fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}