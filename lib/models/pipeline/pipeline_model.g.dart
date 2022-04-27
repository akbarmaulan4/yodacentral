part of 'pipeline_model.dart';
PipelineModel _$fromJson(Map<String, dynamic> json) {
  return PipelineModel()
    ..id = json['id'] ?? -1
    ..title = json['title'] ?? ''
    ..category = json['category'] ?? ''
    ..priority = json['priority'] ?? -1
    ..status = json['status'] ?? ''
    ..total_card = json['total_card'] ?? -1
  ;
}

Map<String, dynamic> _$toJson(PipelineModel instance) =>
    <String, dynamic> {
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'priority': instance.priority,
      'status': instance.status,
      'total_card': instance.total_card,
    };