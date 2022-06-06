
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yodacentral/components/yd_colors.dart';

class Utils{

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static clearTextfield(String val){
    return val != '0' ? val:'';
  }

  static loading(BuildContext context, String text) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          text,
                          // style: boldTextFont.copyWith(
                          //     fontSize: ScreenUtil().setSp(14)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void messageDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ya",
                    style: TextStyle(color: yd_Color_Primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              ),

              new FlatButton(
                child: new Text("Tidak",
                    style: TextStyle(color: yd_Color_Primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void messageAlertDialog(BuildContext context, String title, String message, void callback()) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK",
                    style: TextStyle(color: yd_Color_Primary)),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback();
                  }
                },
              ),
            ],
          );
        });
  }


  static Future<bool> removeNasabahIdentitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('nasabah_identitas');
  }

  static void saveNasabahIdentitas(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nasabah_identitas', val);
  }

  static Future<String> getNasabahIdentitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('nasabah_identitas');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeNasabahInstitusi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('nasabah_institusi');
  }

  static void saveNasabahInstitusi(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nasabah_institusi', val);
  }

  static Future<String> getNasabahInstitusi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('nasabah_institusi');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeFotoNasabah() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('foto_nasabah');
  }

  static void saveFotoNasabah(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('foto_nasabah', val);
  }

  static Future<String> getFotoNasabah() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('foto_nasabah');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeKreditJaminan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('kredit_jaminan');
  }

  static void saveKreditJaminan(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kredit_jaminan', val);
  }

  static Future<String> getKreditJaminan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('kredit_jaminan');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeKreditKontrak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('kredit_kontrak');
  }

  static void saveKreditKontrak(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kredit_kontrak', val);
  }

  static Future<String> getKreditKontrak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('kredit_kontrak');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeKecID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('kecamatan_id');
  }

  static void saveKecID(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kecamatan_id', val);
  }

  static Future<String> getKecID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('kecamatan_id');
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static Future<bool> removeUpdatePipeline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('pipeline');
  }

  static void saveUpdatePipeline(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pipeline', val);
  }

  static Future<bool> getUpdatePipeline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getBool('pipeline');
    if (data != null) {
      return data;
    }
    return false;
  }

  static Future<bool> removePlayerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('player_id');
  }

  static void savePlayerID(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('player_id', val);
  }

  static Future<bool> getPlayerID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getBool('player_id');
    if (data != null && data) {
      return data;
    }
    return false;
  }
}