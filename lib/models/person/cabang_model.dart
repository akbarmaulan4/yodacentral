part 'cabang_model.g.dart';
class CabangModel{
  CabangModel(){}
  int id = -1;
  String code = '';
  String name = '';
  int area_id = -1;
  int user_id = -1;
  String telp = '';
  String address = '';
  String register = '';
  String area = '';
  String pic = '';

  factory CabangModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}