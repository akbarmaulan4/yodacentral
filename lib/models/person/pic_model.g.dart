part of 'pic_model.dart';
PICModel _$fromJson(Map<String, dynamic> json) {
  return PICModel()
    ..id = json['id'] ?? -1
    ..lead_id = json['lead_id'] ?? -1
    ..user_id = json['user_id'] ?? -1
    ..role_id = json['role_id'] ?? -1
    ..name = json['name'] ?? ''
    ..role = json['role'] ?? ''
    ..photo_profile = json['photo_profile'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(PICModel instance) =>
    <String, dynamic> {
      'id': instance.id,
      'lead_id': instance.lead_id,
      'user_id': instance.user_id,
      'role_id': instance.role_id,
      'name': instance.name,
      'role': instance.role,
      'photo_profile': instance.photo_profile
    };