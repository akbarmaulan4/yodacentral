part of 'harga_unit_kredit.dart';
HargaUnitKredit _$fromJson(Map<String, dynamic> json) {
  return HargaUnitKredit()
    ..hargaJual = json['Harga Jual'] ?? 0
    ..hargaOTR = json['Harga OTR'] ?? 0
    ..biayaMax = json['Maksimum Pembiayaan'] ?? 0
  ;
}

Map<String, dynamic> _$toJson(HargaUnitKredit instance) =>
    <String, dynamic> {
      'hargaJual': instance.hargaJual,
      'hargaOTR': instance.hargaOTR,
      'biayaMax': instance.biayaMax,
    };