part of 'chat_item.dart';
ChatItem _$fromJson(Map<String, dynamic> json) {
  return ChatItem()
    ..id = json['id'] ?? 0
    ..lead_id = json['lead_id'] is num ? (json['lead_id'] as num).toInt() : 0
    ..user_id = json['user_id'] ?? 0
    ..message = json['message'] ?? ''
    ..created_at = json['created_at'] ?? ''
    ..name = json['name'] ?? ''
    ..photo_profile = json['photo_profile'] ?? ''
    ..time = json['time'] ?? ''
    ..sort_role = json['sort_role'] ?? ''
    ..self = json['self'] ?? false
    ..category = json['category'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(ChatItem instance) =>
    <String, dynamic> {
      'id': instance.id,
      'lead_id': instance.lead_id,
      'user_id': instance.user_id,
      'message': instance.message,
      'created_at': instance.created_at,
      'name': instance.name,
      'photo_profile': instance.photo_profile,
      'time': instance.time,
      'sort_role': instance.sort_role,
      'self': instance.self,
      'category': instance.category,
    };