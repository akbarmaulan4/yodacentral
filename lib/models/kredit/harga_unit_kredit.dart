part 'harga_unit_kredit.g.dart';
class HargaUnitKredit{
  HargaUnitKredit(){}
  int hargaJual = 0;
  int hargaOTR = 0;
  int biayaMax = 0;

  factory HargaUnitKredit .fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}