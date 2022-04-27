part 'person_role_model.g.dart';
class PersonRoleModel{
  PersonRoleModel(){}
  int id = -1;
  String name = '';
  String category = '';
  String scope = '';

  factory PersonRoleModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}