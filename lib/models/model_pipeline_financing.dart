// To parse this JSON data, do
//
//     final modelPipelineFinancing = modelPipelineFinancingFromMap(jsonString);

import 'dart:convert';

ModelPipelineFinancing modelPipelineFinancingFromMap(String str) =>
    ModelPipelineFinancing.fromMap(json.decode(str));

String modelPipelineFinancingToMap(ModelPipelineFinancing data) =>
    json.encode(data.toMap());

class ModelPipelineFinancing {
  ModelPipelineFinancing({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelPipelineFinancing.fromMap(Map<String, dynamic> json) =>
      ModelPipelineFinancing(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.open,
    this.close,
  });

  List<Close>? open;
  List<Close>? close;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        open: json["open"] == null
            ? null
            : List<Close>.from(json["open"].map((x) => Close.fromMap(x))),
        close: json["close"] == null
            ? null
            : List<Close>.from(json["close"].map((x) => Close.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "open": open == null
            ? null
            : List<dynamic>.from(open!.map((x) => x.toMap())),
        "close": close == null
            ? null
            : List<dynamic>.from(close!.map((x) => x.toMap())),
      };
}

class Close {
  Close({
    this.id,
    this.title,
    this.category,
    this.priority,
    this.status,
    this.totalCard,
  });

  int? id;
  String? title;
  String? category;
  int? priority;
  String? status;
  int? totalCard;

  factory Close.fromMap(Map<String, dynamic> json) => Close(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        category: json["category"] == null ? null : json["category"],
        priority: json["priority"] == null ? null : json["priority"],
        status: json["status"] == null ? null : json["status"],
        totalCard: json["total_card"] == null ? null : json["total_card"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "category": category == null ? null : category,
        "priority": priority == null ? null : priority,
        "status": status == null ? null : status,
        "total_card": totalCard == null ? null : totalCard,
      };
}
