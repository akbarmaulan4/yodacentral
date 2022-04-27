// To parse this JSON data, do
//
//     final modelChatLead = modelChatLeadFromMap(jsonString);

import 'dart:convert';

ModelChatLead modelChatLeadFromMap(String str) =>
    ModelChatLead.fromMap(json.decode(str));

String modelChatLeadToMap(ModelChatLead data) => json.encode(data.toMap());

class ModelChatLead {
  ModelChatLead({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ModelChatLead.fromMap(Map<String, dynamic> json) => ModelChatLead(
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
    this.pics,
    this.chats,
  });

  List<Pic>? pics;
  // List<Chat>? chats;
  dynamic? chats;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pics: json["pics"] == null ? null : List<Pic>.from(json["pics"].map((x) => Pic.fromMap(x))),
        chats: json["chats"],
    // chats: json["chats"] == null ? null : List<Chat>.from(json["chats"].map((x) => Chat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pics": pics == null
            ? null
            : List<dynamic>.from(pics!.map((x) => x.toMap())),
        "chats": chats == null
            ? null
            : List<dynamic>.from(chats!.map((x) => x.toMap())),
      };
}

class ChatModel {
  ChatModel({
    this.id,
    this.leadId,
    this.userId,
    this.message,
    this.createdAt,
    this.name,
    this.photoProfile,
    this.time,
    this.sortRole,
    this.self,
    this.category,
  });

  int? id;
  int? leadId;
  int? userId;
  String? message;
  DateTime? createdAt;
  String? name;
  String? photoProfile;
  String? time;
  String? sortRole;
  bool? self;
  String? category;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
    id: json["id"] == null ? null : json["id"],
    leadId: json["lead_id"] == null ? null : json["lead_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    message: json["message"] == null ? null : json["message"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    name: json["name"] == null ? null : json["name"],
    photoProfile:
    json["photo_profile"] == null ? null : json["photo_profile"],
    time: json["time"] == null ? null : json["time"],
    sortRole: json["sort_role"] == null ? null : json["sort_role"],
    self: json["self"] == null ? null : json["self"],
    category: json["category"] == null ? null : json["category"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "lead_id": leadId == null ? null : leadId,
    "user_id": userId == null ? null : userId,
    "message": message == null ? null : message,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "name": name == null ? null : name,
    "photo_profile": photoProfile == null ? null : photoProfile,
    "time": time == null ? null : time,
    "sort_role": sortRole == null ? null : sortRole,
    "self": self == null ? null : self,
    "category": category == null ? null : category,
  };
}

class Pic {
  Pic({
    this.id,
    this.leadId,
    this.userId,
    this.roleId,
    this.name,
    this.role,
    this.sortRole,
    this.photoProfile,
  });

  int? id;
  int? leadId;
  int? userId;
  int? roleId;
  String? name;
  String? role;
  String? sortRole;
  String? photoProfile;

  factory Pic.fromMap(Map<String, dynamic> json) => Pic(
        id: json["id"] == null ? null : json["id"],
        leadId: json["lead_id"] == null ? null : json["lead_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        name: json["name"] == null ? null : json["name"],
        role: json["role"] == null ? null : json["role"],
        sortRole: json["sort_role"] == null ? null : json["sort_role"],
        photoProfile:
            json["photo_profile"] == null ? null : json["photo_profile"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "lead_id": leadId == null ? null : leadId,
        "user_id": userId == null ? null : userId,
        "role_id": roleId == null ? null : roleId,
        "name": name == null ? null : name,
        "role": role == null ? null : role,
        "sort_role": sortRole == null ? null : sortRole,
        "photo_profile": photoProfile == null ? null : photoProfile,
      };
}
