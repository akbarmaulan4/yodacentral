part 'pipeline_model.g.dart';
class PipelineModel{
  PipelineModel(){}
  int id = -1;
  String title = '';
  String category = '';
  int priority = -1;
  String status = '';
  int total_card = 0;

  factory PipelineModel.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}