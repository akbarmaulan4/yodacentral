// To parse this JSON data, do
//
//     final modelLeadCount = modelLeadCountFromMap(jsonString);

import 'dart:convert';

ModelLeadCount modelLeadCountFromMap(String str) =>
    ModelLeadCount.fromMap(json.decode(str));

String modelLeadCountToMap(ModelLeadCount data) => json.encode(data.toMap());

class ModelLeadCount {
  ModelLeadCount({
    this.message,
    this.count,
  });

  String? message;
  Count? count;

  factory ModelLeadCount.fromMap(Map<String, dynamic> json) => ModelLeadCount(
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : Count.fromMap(json["count"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "count": count == null ? null : count!.toMap(),
      };
}

class Count {
  Count({
    this.open,
    this.close,
  });

  int? open;
  int? close;

  factory Count.fromMap(Map<String, dynamic> json) => Count(
        open: json["open"] == null ? null : json["open"],
        close: json["close"] == null ? null : json["close"],
      );

  Map<String, dynamic> toMap() => {
        "open": open == null ? null : open,
        "close": close == null ? null : close,
      };
}
