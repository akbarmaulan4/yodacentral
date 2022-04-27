part of 'person_model.dart';
PersonModel _$fromJson(Map<String, dynamic> json) {
  return PersonModel()
    ..id = json['id'] ?? -1
    ..role_id = json['role_id'] ?? -1
    ..name = json['name'] ?? ''
    ..email = json['email'] ?? ''
    ..telp = json['telp'] ?? ''
    ..status = json['status'] ?? ''
    ..photo_profile = json['photo_profile'] ?? ''
    ..active = json['photo_profile'] ?? ''
    ..role = json['role'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(PersonModel instance) =>
    <String, dynamic> {
      'id': instance.id,
      'role_id': instance.role_id,
      'name': instance.name,
      'email': instance.email,
      'telp': instance.telp,
      'status': instance.status,
      'photo_profile': instance.photo_profile,
      'active': instance.active,
      'role': instance.role,
    };