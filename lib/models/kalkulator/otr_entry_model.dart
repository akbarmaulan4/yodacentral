part 'otr_entry_model.g.dart';
class ModelOTREntry{
  ModelOTREntry(){}
  String otr_value = '';
  String dp_value = '';
  String dp_percent = '';
  String ph_value = '';
  String ph_percent = '';
  String premi_insurance = '';
  String anuity_percent = '';
  String anuity_value = '';
  String total_payment = '';
  String duration_year = '';
  String duration_month = '';
  String termin_value = '';
  String administration = '';
  String termin_one = '';
  String provisi = '';
  String total_add_expense = '';
  String total_income = '';
  String refund_flat_percent = '';
  String refund_flat_value = '';
  String refund_admin_percent = '';
  String refund_admin_value = '';
  String total_refund = '';
  String id = '';

  factory ModelOTREntry.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}