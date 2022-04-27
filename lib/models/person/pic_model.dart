part 'pic_model.g.dart';
class PICModel{
  PICModel(){}
  int id = -1;
  int lead_id = -1;
  int user_id = -1;
  int role_id = -1;
  String name = '';
  String role = '';
  String photo_profile = '';

  factory PICModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}