part 'person_model.g.dart';
class PersonModel{
  PersonModel(){}
  int id = -1;
  int role_id = -1;
  String name = '';
  String email = '';
  String telp = '';
  String status = '';
  String photo_profile = '';
  String active = '';
  String role = '';

  factory PersonModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}