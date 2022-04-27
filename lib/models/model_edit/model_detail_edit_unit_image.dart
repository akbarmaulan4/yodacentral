// To parse this JSON data, do
//
//     final modelDetailEditUnitImage = modelDetailEditUnitImageFromMap(jsonString);

import 'dart:convert';

ModelDetailEditUnitImage modelDetailEditUnitImageFromMap(String str) =>
    ModelDetailEditUnitImage.fromMap(json.decode(str));

String modelDetailEditUnitImageToMap(ModelDetailEditUnitImage data) =>
    json.encode(data.toMap());

class ModelDetailEditUnitImage {
  ModelDetailEditUnitImage({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelDetailEditUnitImage.fromMap(Map<String, dynamic> json) =>
      ModelDetailEditUnitImage(
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
    this.unitId,
    this.image,
  });

  int? unitId;
  List<String>? image;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        unitId: json["unit_id"] == null ? null : json["unit_id"],
        image: json["image"] == null
            ? null
            : List<String>.from(json["image"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "unit_id": unitId == null ? null : unitId,
        "image":
            image == null ? null : List<dynamic>.from(image!.map((x) => x)),
      };
}
