part of 'mobile_access.dart';

MobileAccess _$fromJson(Map<String, dynamic> json) {
  return MobileAccess()
    ..tambahUnit = json['Tambah Unit'] ?? 0
    ..home = json['Home'] ?? ''
    // ..notifikasi = json['name'] ?? ''
    // ..chat_notifikasi = json['my_access'] ?? 0
    // ..kalkulator = json['my_access'] ?? 0
    // ..refinancing = json['my_access'] ?? 0
  ;
}

Map<String, dynamic> _$toJson(MobileAccess instance) =>
    <String, dynamic> {
      'Tambah Unit': instance.tambahUnit,
      'Home': instance.home,
      // 'name': instance.name,
      // 'my_access': instance.my_access,
    };