import 'dart:developer';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerHistory extends GetxController {
  List<ModelListHisto> history = [];

  // List<String> historyAkit = [];

  saveHisto({List<ModelListHisto>? list}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("histo", modelListHistoToMap(list!));
    callHisto();
    update();
  }

  callHisto() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? list = sharedPreferences.getString("histo");

    history = modelListHistoFromMap(list!);
    update();
  }

  addHistory({ModelListHisto? modelListHisto}) {
    // log(modelListHisto!.name.toString(), name: "ini histo click");
    if (history
        .where((element) => element.name == modelListHisto!.name)
        .isEmpty) {
      history.add(modelListHisto!);
      history.sort((a, b) => b.date!.compareTo(a.date!));
      saveHisto(list: history);
      update();
    } else {
      history.removeWhere((element) => element.name == modelListHisto!.name);
      update();
      history.add(modelListHisto!);
      history.sort((a, b) => b.date!.compareTo(a.date!));
      saveHisto(list: history);
      update();
    }

    log(history.toString(), name: "ini history search");
    update();
  }
}

List<ModelListHisto> modelListHistoFromMap(String str) =>
    List<ModelListHisto>.from(
        json.decode(str).map((x) => ModelListHisto.fromMap(x)));

String modelListHistoToMap(List<ModelListHisto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelListHisto {
  ModelListHisto({
    this.name,
    this.date,
  });

  String? name;
  DateTime? date;

  factory ModelListHisto.fromMap(Map<String, dynamic> json) => ModelListHisto(
        name: json["name"] == null ? null : json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "date": date == null ? null : date!.toIso8601String(),
      };
}
