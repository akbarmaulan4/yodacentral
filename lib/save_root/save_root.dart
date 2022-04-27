import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yodacentral/models/model_save_akun_register.dart';
import 'package:yodacentral/models/model_save_root.dart';

class SaveRoot {
  static saveRoot({
    required String token,
    required String email,
    required String name,
    required String telp,
    required String avatar,
    required String role,
    required String kantor,
    required String kode,
    required int markNotif,
    required int ingat,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("telp", telp);
    sharedPreferences.setString("avatar", avatar);
    sharedPreferences.setString("role", role);
    sharedPreferences.setString("kantor", kantor);
    sharedPreferences.setString("kode", kode);
    sharedPreferences.setInt("markNotif", markNotif);
    sharedPreferences.setInt("ingat", ingat);

    log("simpan data root");
  }

  static Future<ModelSaveRoot> callSaveRoot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString("token");
    String? email = sharedPreferences.getString("email");
    String? name = sharedPreferences.getString("name");
    String? telp = sharedPreferences.getString("telp");
    String? avatar = sharedPreferences.getString("avatar");
    String? role = sharedPreferences.getString("role");
    String? kantor = sharedPreferences.getString("kantor");
    String? kode = sharedPreferences.getString("kode");
    int? markNotif = sharedPreferences.getInt("markNotif");
    int? ingat = sharedPreferences.getInt("ingat");

    if (token == null ||
        email == null ||
        name == null ||
        telp == null ||
        avatar == null ||
        role == null ||
        kantor == null ||
        kode == null ||
        markNotif == null) {
      return ModelSaveRoot(
        token: null,
        ingat: 0,
        userData: UserData(
          email: null,
          name: null,
          telp: null,
          avatar: null,
          role: null,
          kantor: null,
          kode: null,
          markNotif: null,
        ),
      );
    } else {
      return ModelSaveRoot(
        token: token,
        ingat: ingat,
        userData: UserData(
          email: email,
          name: name,
          telp: telp,
          avatar: avatar,
          role: role,
          kantor: kantor,
          kode: kode,
          markNotif: markNotif,
        ),
      );
    }
  }

  static deleteSaveRoot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("hapus data root");
    sharedPreferences.clear();
  }
}

class SaveRootDaftar {
  static saveRootRegis({
    required String emailRegis,
    required String pwRegis,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("emailRegis", emailRegis);
    sharedPreferences.setString("pwRegis", pwRegis);

    log("simpan data root");
  }

  static Future<ModelSaveAkunRegister> callSaveRootRegis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? pwRegis = sharedPreferences.getString("pwRegis");
    String? emailRegis = sharedPreferences.getString("emailRegis");

    if (emailRegis == null || pwRegis == null) {
      return ModelSaveAkunRegister(
        email: null,
        password: null,
      );
    } else {
      return ModelSaveAkunRegister(
        email: emailRegis,
        password: pwRegis,
      );
    }
  }

  static deleteSaveRootRegis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove("pwRegis");
    await sharedPreferences.remove("emailRegis");
    print("hapus data root");
  }
}
