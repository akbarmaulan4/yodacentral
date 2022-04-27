part of 'chat_model.dart';
NewChatModel _$fromJson(Map<String, dynamic> json) {
  return NewChatModel()
    ..tanggal = json['tanggal'] ?? ''
    ..chats = (json['chats'] as List).map((e) => e == null ? null : ChatItem.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$toJson(NewChatModel instance) =>
    <String, dynamic> {
      'tanggal': instance.tanggal,
      'chats': instance.chats,
    };