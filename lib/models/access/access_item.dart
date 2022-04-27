part 'access_item.g.dart';
class AccessItem{
  AccessItem(){}
  int id = 0;
  String category = '';
  String name = '';
  int my_access = 0;

  factory AccessItem .fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}