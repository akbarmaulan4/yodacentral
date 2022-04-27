part 'data_unit_kredit.g.dart';
class DataUnitKredit{
  DataUnitKredit(){}
  String title = '';
  String note = '';
  String police_number = '';
  int kondisi = 0;
  String merek = '';
  String model = '';
  String varian = '';
  int tahun = 0;
  String jarak_tempuh = '';
  String bahan_bakar = '';
  String transmisi = '';
  String warna = '';

  factory DataUnitKredit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}