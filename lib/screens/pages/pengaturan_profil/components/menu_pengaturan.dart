import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_auth.dart/controller_auth.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/lupa_kata_sandi/new_ubah_kata_sandi.dart';
import 'package:yodacentral/screens/login/lupa_kata_sandi/ubah_kata_sandi.dart';
import 'package:yodacentral/screens/pages/pengaturan_profil/informasi_akun/informasi_akun.dart';
import 'package:yodacentral/screens/pages/pengaturan_profil/riwayat_masuk/riwayat_masuk.dart';

Widget menuPengaturan({required BuildContext context}) {
  ControllerAuth auth = Get.put(ControllerAuth());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
        child: Text(
          "Pengaturan",
          style: TextStyle(
            fontSize: 16,
            color: yd_Color_Primary_Grey,
          ),
        ),
      ),
      SizedBox(
        height: 7,
      ),
      itemList(
          icon: Icons.account_circle_outlined,
          name: "Informasi Akun",
          onTap: () {
            Get.bottomSheet(
              Padding(
                padding: EdgeInsets.only(top: yd_defauld_padding * 2 + 5),
                child: InformasiAkun(),
              ),
              isScrollControlled: true,
            );
          }),
      itemList(
          icon: Icons.security_rounded,
          name: "Ubah Kata Sandi",
          onTap: () {
            SaveRoot.callSaveRoot().then((value) {
              // Get.bottomSheet(
              //   Padding(
              //     padding: EdgeInsets.only(top: yd_defauld_padding * 2 + 5),
              //     child: NewUbahKataSandi(
              //       // email: value.userData == null ? "" : value.userData!.email!,
              //       // isProfile: true,
              //     ),
              //   ),
              //   isScrollControlled: true,
              // );
              // Get.bottomSheet(
              //   Padding(
              //     padding: EdgeInsets.only(top: yd_defauld_padding * 2 + 5),
              //     child: UbahKataSandi(
              //       email: value.userData == null ? "" : value.userData!.email!,
              //       isProfile: true,
              //     ),
              //   ),
              //   isScrollControlled: true,
              // );
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => UbahKataSandi(
                  email: value.userData == null ? "" : value.userData!.email!,
                  isProfile: true,
                ),
              );
            });
          }),
      itemList(
          icon: Icons.history_rounded,
          name: "Riwayat Masuk",
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => RiwayatMasuk(),
            );
          }),
      itemList(
        icon: Icons.exit_to_app_rounded,
        name: "Keluar",
        onTap: () {
          auth.logout();
        },
      ),
    ],
  );
}

Widget itemList({
  required IconData icon,
  required String name,
  required Function() onTap,
}) {
  return InkWell(
    hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
    focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
    splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
    highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: yd_defauld_padding,
          ),
          Row(
            children: [
              Icon(icon),
              SizedBox(
                width: 12,
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: yd_defauld_padding,
          ),
        ],
      ),
    ),
  );
}
