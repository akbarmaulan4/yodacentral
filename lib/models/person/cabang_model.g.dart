part of 'cabang_model.dart';
CabangModel _$fromJson(Map<String, dynamic> json) {
  return CabangModel()
    ..id = json['id'] ?? -1
    ..code = json['code'] ?? ''
    ..name = json['name'] ?? ''
    ..area_id = json['area_id'] ?? -1
    ..user_id = json['user_id'] ?? -1
    ..telp = json['telp'] ?? ''
    ..address = json['address'] ?? ''
    ..register = json['register'] ?? ''
    ..area = json['area'] ?? ''
    ..pic = json['pic'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(CabangModel instance) =>
    <String, dynamic> {
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'area_id': instance.area_id,
      'user_id': instance.user_id,
      'telp': instance.telp,
      'address': instance.address,
      'register': instance.register,
      'area': instance.area,
      'pic': instance.pic,
    };