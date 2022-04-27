// To parse this JSON data, do
//
//     final modelLeadSearchFinancing = modelLeadSearchFinancingFromMap(jsonString);

import 'dart:convert';

ModelLeadSearchFinancing modelLeadSearchFinancingFromMap(String str) =>
    ModelLeadSearchFinancing.fromMap(json.decode(str));

String modelLeadSearchFinancingToMap(ModelLeadSearchFinancing data) =>
    json.encode(data.toMap());

class ModelLeadSearchFinancing {
  ModelLeadSearchFinancing({
    this.message,
    this.data,
    this.access
  });

  String? message;
  List<Datum>? data;
  Access? access;

  factory ModelLeadSearchFinancing.fromMap(Map<String, dynamic> json) =>
      ModelLeadSearchFinancing(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        access: json["access"] == null ? null : Access.fromMap(json["access"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Access{
  Access({this.mobileAccess});
  MobileAccess? mobileAccess;

  factory Access.fromMap(Map<String, dynamic> json) => Access(
      mobileAccess: json["mobile_access"] == null ? null : MobileAccess.fromMap(json["mobile_access"])
  );

  Map<String, dynamic> toMap() => {
    "mobile_access": mobileAccess == null ? null : mobileAccess,
  };
}

class MobileAccess{
  MobileAccess({this.tambahUnit});
  int? tambahUnit;

  factory MobileAccess.fromMap(Map<String, dynamic> json) => MobileAccess(
    tambahUnit: json["Tambah Unit"] == null ? null : json["Tambah Unit"]
  );

  Map<String, dynamic> toMap() => {
    "Tambah Unit": tambahUnit == null ? null : tambahUnit,
  };
}

class Datum {
  Datum({
    this.id,
    this.unitId,
    this.pipelineId,
    this.modelName,
    this.lastUpdate,
    // this.num,
    this.sellerName,
    this.photoUnit,
  });

  int? id;
  int? unitId;
  int? pipelineId;
  String? modelName;
  String? lastUpdate;
  // int num;
  String? sellerName;
  String? photoUnit;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        unitId: json["unit_id"] == null ? null : json["unit_id"],
        pipelineId: json["pipeline_id"] == null ? null : json["pipeline_id"],
        modelName: json["model_name"] == null ? null : json["model_name"],
        lastUpdate: json["last_update"] == null ? null : json["last_update"],
        // num: json["num"] == null ? null : json["num"],
        sellerName: json["seller_name"] == null ? null : json["seller_name"],
        photoUnit: json["photo_unit"] == null ? null : json["photo_unit"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "unit_id": unitId == null ? null : unitId,
        "pipeline_id": pipelineId == null ? null : pipelineId,
        "model_name": modelName == null ? null : modelName,
        "last_update": lastUpdate == null ? null : lastUpdate,
        // "num": num == null ? null : "num",
        "seller_name": sellerName == null ? null : sellerName,
        "photo_unit": photoUnit == null ? null : photoUnit,
      };
}
