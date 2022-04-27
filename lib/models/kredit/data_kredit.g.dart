part of 'data_kredit.dart';
DataKredit _$fromJson(Map<String, dynamic> json) {
  return DataKredit()
    ..id = json['id'] ?? 0
    ..machine_number = json['machine_number'] ?? ''
    ..chassis_number = json['chassis_number'] ?? ''
    ..name = json['name'] ?? 0
    ..bpkb_number = json['bpkb_number'] ?? ''
    ..bpkb_validity_period = json['bpkb_validity_period'] ?? ''
    ..stnk_validity_period = json['stnk_validity_period'] ?? ''
    ..nomer_rangka = json['nomer_rangka'] ?? ''
    ..nomor_mesin = json['nomor_mesin'] ?? ''
    ..kedaluarsa_bpkb = json['kedaluarsa_bpkb'] ?? ''
    ..kedaluarsa_stnk = json['kedaluarsa_stnk'] ?? ''
    ..kota_terbit_bpkb = json['Kota terbit BPK'] ?? ''
  ;
}

Map<String, dynamic> _$toJson(DataKredit instance) =>
    <String, dynamic> {
      'id': instance.id,
      'machine_number': instance.machine_number,
      'chassis_number': instance.chassis_number,
      'name': instance.name,
      'bpkb_number': instance.bpkb_number,
      'bpkb_validity_period': instance.bpkb_validity_period,
      'stnk_validity_period': instance.stnk_validity_period,
      'nomer_rangka': instance.nomer_rangka,
      'nomor_mesin': instance.nomor_mesin,
      'kedaluarsa_bpkb': instance.kedaluarsa_bpkb,
      'kedaluarsa_stnk': instance.kedaluarsa_stnk,
      'kota_terbit_bpkb': instance.kota_terbit_bpkb,
    };