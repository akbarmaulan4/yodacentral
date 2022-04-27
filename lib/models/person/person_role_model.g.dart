part of 'person_role_model.dart';
PersonRoleModel _$fromJson(Map<String, dynamic> json) {
  return PersonRoleModel()
    ..id = json['id'] ?? -1
    ..name = json['name'] ?? ''
    ..category = json['category'] ?? ''
    ..scope = json['scope'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(PersonRoleModel instance) =>
    <String, dynamic> {
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'scope': instance.scope,
    };