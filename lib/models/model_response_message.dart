// To parse this JSON data, do
//
//     final modelResponseMessage = modelResponseMessageFromMap(jsonString);

import 'dart:convert';

ModelResponseMessage modelResponseMessageFromMap(String str) =>
    ModelResponseMessage.fromMap(json.decode(str));

String modelResponseMessageToMap(ModelResponseMessage data) =>
    json.encode(data.toMap());

class ModelResponseMessage {
  ModelResponseMessage({
    this.message,
  });

  String? message;

  factory ModelResponseMessage.fromMap(Map<String, dynamic> json) =>
      ModelResponseMessage(
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
      };
}
