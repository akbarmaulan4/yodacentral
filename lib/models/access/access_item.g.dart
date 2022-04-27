part of 'access_item.dart';
AccessItem _$fromJson(Map<String, dynamic> json) {
  return AccessItem()
    ..id = json['id'] ?? 0
    ..category = json['category'] ?? ''
    ..name = json['name'] ?? ''
    ..my_access = json['my_access'] ?? 0
  ;
}

Map<String, dynamic> _$toJson(AccessItem instance) =>
    <String, dynamic> {
      'id': instance.id,
      'category': instance.category,
      'name': instance.name,
      'my_access': instance.my_access,
    };