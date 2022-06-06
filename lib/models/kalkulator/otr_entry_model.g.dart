part of 'otr_entry_model.dart';
ModelOTREntry _$fromJson(Map<String, dynamic> json) {
  return ModelOTREntry()
    ..otr_value = json['otr_value'] is num ? (json['otr_value'] as num).toString() : '0'
    ..dp_value = json['dp_value'] is num ? (json['dp_value'] as num).toString() : '0'
    ..dp_percent = json['dp_percent'] is num ? (json['dp_percent'] as num).toString() : '0'
    ..ph_value = json['ph_value'] is num ? (json['ph_value'] as num).toString() : '0'
    ..ph_percent = json['ph_percent'] is num ? (json['ph_percent'] as num).toString() : '0'
    ..premi_insurance = json['premi_insurance'] is num ? (json['premi_insurance'] as num).toString() : '0'
    ..anuity_percent = json['anuity_percent'] is num ? (json['anuity_percent'] as num).toString() : '0'
    ..anuity_value = json['anuity_value'] is num ? (json['anuity_value'] as num).toString() : '0'
    ..total_payment = json['total_payment'] is num ? (json['total_payment'] as num).toString() : '0'
    ..duration_year = json['duration_year'] is num ? (json['duration_year'] as num).toString() : '0'
    ..duration_month = json['duration_month'] is num ? (json['duration_month'] as num).toString() : '0'
    ..termin_value = json['termin_value'] is num ? (json['termin_value'] as num).toString() : '0'
    ..administration = json['administration'] is num ? (json['administration'] as num).toString() : '0'
    ..termin_one = json['termin_one'] is num ? (json['termin_one'] as num).toString() : '0'
    ..provisi =  json['provisi'] is num ? (json['provisi'] as num).toString() : '0'
    ..total_add_expense = json['total_add_expense'] is num ? (json['total_add_expense'] as num).toString() : '0'
    ..total_income = json['total_income'] is num ? (json['total_income'] as num).toString() : '0'
    ..refund_flat_percent = json['refund_flat_percent'] is num ? (json['refund_flat_percent'] as num).toString() : '0'
    ..refund_flat_value = json['refund_flat_value'] is num ? (json['refund_flat_value'] as num).toString() : '0'
    ..refund_admin_percent = json['refund_admin_percent'] is num ? (json['refund_admin_percent'] as num).toString() : '0'
    ..refund_admin_value = json['refund_admin_value'] is num ? (json['refund_admin_value'] as num).toString() : '0'
    ..total_refund = json['total_refund'] is num ? (json['total_refund'] as num).toString() : '0'
    ..id = json['id'] is num ? (json['id'] as num).toString() : '0'
  ;
}

Map<String, dynamic> _$toJson(ModelOTREntry instance) =>
    <String, dynamic> {
      'otr_value': instance.otr_value,
      'dp_value': instance.dp_value,
      'dp_percent': instance.dp_percent,
      'ph_value': instance.ph_value,
      'ph_percent': instance.ph_percent,
      'premi_insurance': instance.premi_insurance,
      'anuity_percent': instance.anuity_percent,
      'anuity_value': instance.anuity_value,
      'total_payment': instance.total_payment,
      'duration_year': instance.duration_year,
      'duration_month': instance.duration_month,
      'termin_value': instance.termin_value,
      'administration': instance.administration,
      'termin_one': instance.termin_one,
      'provisi': instance.provisi,
      'total_add_expense': instance.total_add_expense,
      'total_income': instance.total_income,
      'refund_flat_percent': instance.refund_flat_percent,
      'refund_flat_value': instance.refund_flat_value,
      'refund_admin_percent': instance.refund_admin_percent,
      'refund_admin_value': instance.refund_admin_value,
      'total_refund': instance.total_refund,
      'id': instance.id,
    };