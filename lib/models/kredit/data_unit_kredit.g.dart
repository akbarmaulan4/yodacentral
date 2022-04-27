part of 'data_unit_kredit.dart';
DataUnitKredit _$fromJson(Map<String, dynamic> json) {
  return DataUnitKredit()
    ..title = json['title'] ?? ''
    ..note = json['note'] ?? ''
    ..police_number = json['police_number'] ?? ''
    ..kondisi = json['kondisi'] ?? 0
    ..merek = json['merek'] ?? ''
    ..model = json['model'] ?? ''
    ..varian = json['varian'] ?? ''
    ..tahun = json['tahun'] ?? 0
    ..jarak_tempuh = json['jarak_tempuh'] ?? ''
    ..bahan_bakar = json['bahan_bakar'] ?? ''
    ..transmisi = json['transmisi'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataUnitKredit instance) =>
    <String, dynamic> {
      'title': instance.title,
      'note': instance.note,
      'police_number': instance.police_number,
      'kondisi': instance.kondisi,
      'merek': instance.merek,
      'model': instance.model,
      'varian': instance.varian,
      'tahun': instance.tahun,
      'jarak_tempuh': instance.jarak_tempuh,
      'bahan_bakar': instance.bahan_bakar,
      'transmisi': instance.transmisi,
    };