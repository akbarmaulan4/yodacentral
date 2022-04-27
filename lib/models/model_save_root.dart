class ModelSaveRoot {
  ModelSaveRoot({
    this.token,
    this.userData,
    required this.ingat,
  });

  String? message;
  String? token;
  int? ingat;
  UserData? userData;
}

class UserData {
  UserData({
    this.email,
    this.name,
    this.telp,
    this.avatar,
    this.role,
    this.kantor,
    this.kode,
    this.markNotif,
  });

  String? email;
  String? name;
  String? telp;
  String? avatar;
  String? role;
  String? kantor;
  String? kode;
  int? markNotif;
}
