part 'data_kredit.g.dart';
class DataKredit{
  DataKredit(){}
  int id = -1;
  String machine_number = '';
  String chassis_number = '';
  String name = '';
  String bpkb_number = '';
  String bpkb_validity_period = '';
  String stnk_validity_period = '';
  String nomer_rangka = '';
  String nomor_mesin = '';
  String kedaluarsa_bpkb = '';
  String kedaluarsa_stnk = '';
  String kota_terbit_bpkb = '';

  factory DataKredit.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}