part 'mobile_access.g.dart';
class MobileAccess{
  MobileAccess(){}
  int infoUnit = 0;
  int infoNasabah = 0;
  int tambahUnit = 0;
  int home = 0;
  int notifikasi = 0;
  int chat_notifikasi = 0;
  int kalkulator = 0;
  int refinancing = 0;

  factory MobileAccess .fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}