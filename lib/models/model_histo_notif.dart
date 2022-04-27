// To parse this JSON data, do
//
//     final modelHistoNotif = modelHistoNotifFromMap(jsonString);

import 'dart:convert';

ModelHistoNotif modelHistoNotifFromMap(String str) =>
    ModelHistoNotif.fromMap(json.decode(str));

String modelHistoNotifToMap(ModelHistoNotif data) => json.encode(data.toMap());

class ModelHistoNotif {
  ModelHistoNotif({
    this.message,
    this.lastPage,
    this.data,
  });

  String? message;
  int? lastPage;
  List<Datum>? data;

  factory ModelHistoNotif.fromMap(Map<String, dynamic> json) => ModelHistoNotif(
        message: json["message"] == null ? null : json["message"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "last_page": lastPage == null ? null : lastPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.leadId,
    this.unitId,
    this.message,
    this.seen,
    this.category,
    this.createdAt,
    this.namaUnit,
    this.subject,
    this.sampleImage,
  });

  int? leadId;
  int? unitId;
  String? message;
  bool? seen;
  String? category;
  String? createdAt;
  String? namaUnit;
  String? subject;
  String? sampleImage;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        leadId: json["lead_id"] == null ? null : json["lead_id"],
        unitId: json["unit_id"] == null ? null : json["unit_id"],
        message: json["message"] == null ? null : json["message"],
        seen: json["seen"] == null ? null : json["seen"],
        category: json["category"] == null ? null : json["category"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        namaUnit: json["nama_unit"] == null ? null : json["nama_unit"],
        subject: json["subject"] == null ? null : json["subject"],
        sampleImage: json["sample_image"],
      );

  Map<String, dynamic> toMap() => {
        "lead_id": leadId == null ? null : leadId,
        "unit_id": unitId == null ? null : unitId,
        "message": message == null ? null : message,
        "seen": seen == null ? null : seen,
        "category": category == null ? null : category,
        "created_at": createdAt == null ? null : createdAt,
        "nama_unit": namaUnit == null ? null : namaUnit,
        "subject": subject == null ? null : subject,
        "sample_image": sampleImage,
      };
}
