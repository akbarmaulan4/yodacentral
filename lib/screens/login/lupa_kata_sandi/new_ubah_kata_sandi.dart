import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/login/daftar/components/menu_components.dart';

class NewUbahKataSandi extends StatefulWidget {
  @override
  _NewUbahKataSandiState createState() => _NewUbahKataSandiState();
}

class _NewUbahKataSandiState extends State<NewUbahKataSandi> {

  Widget newField({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController ctrl,
    TextInputType? type,
    bool? show = true,
    String? messageApi,
    Widget? sufix,
    bool readOnly = false,
    Function()? onTap,
  }) {
    return TextFormField(
      maxLines: type == TextInputType.multiline ? 4 : 1,
      onTap: onTap,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // inputFormatters: [
      //   if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
      //     CreditCardFormatter(),
      // ],
      validator: (v) {
        // if (label == "Nama Lengkap Sesuai KTP" ||
        //     label == "Nama Lengkap Pasangan" ||
        //     label == "Nama Gadis Ibu Kandung") {
        //   if (v!.isEmpty || v.length > 254) {
        //     return "Masukkan nama yang benar";
        //   } else {
        //     return null;
        //   }
        // } else if (label == "Nomor Handphone" ||
        //     label == "Nomor Telepon Institusi") {
        //   if (v!.length < 10 || v.length > 15) {
        //     return "Nomor telepon tidak valid";
        //   } else {
        //     return null;
        //   }
        // } else if (label == "Nomor KTP" || label == "Nomor KTP Pasangan") {
        //   if (v!.length <= 0 || v.length > 19) {
        //     return "Nomor KTP tidak valid";
        //   }
        // }
      },
      controller: ctrl,
      onChanged: (v){
        onChanged(v);
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding:
        label == "Alamat Institusi" || label == "Catatan Pekerjaan"
            ? EdgeInsets.symmetric(horizontal: 15, vertical: 15)
            : EdgeInsets.symmetric(horizontal: 15),
        errorText: messageApi == null ? null : messageApi,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        labelText: label,
        prefix: label == "Nomor Telepon" || label == "Nomor Telepon Institusi"
            ? Text(
          "+62 ",
          style: TextStyle(color: yd_Color_Primary_Grey),
        )
            : null,
        suffixIcon: sufix,
        labelStyle: TextStyle(color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      obscureText: label == "Kata Sandi" ? show! : false,
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtEPass = TextEditingController();
  TextEditingController edtEConfPass = TextEditingController();

  FocusNode nodeEmail = FocusNode();
  FocusNode nodePass = FocusNode();
  FocusNode nodeConfPass = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: ()=>Get.back(),
                        child: Icon(Icons.arrow_back),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (context) => CustomDialog(),
                      //         barrierColor:
                      //         Colors.black.withOpacity(0.7));
                      //   },
                      //   child: Center(
                      //     child: Text(
                      //       "Batalkan",
                      //       style: TextStyle(
                      //         color: yd_Color_Primary,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text("Ubah Kata Sandi Anda", style: TextStyle(fontSize: 32)),
                SizedBox(height: yd_defauld_padding * 2),
                newField(
                    onChanged: (val){},
                    focusNode: nodeEmail,
                    label: 'Email',
                    ctrl: edtEmail
                ),
                SizedBox(
                  height: yd_defauld_padding + 5,
                ),
                newField(
                    onChanged: (val){},
                    focusNode: nodePass,
                    label: 'Kata Sandi Baru',
                    ctrl: edtEPass
                ),
                SizedBox(
                  height: yd_defauld_padding + 5,
                ),
                newField(
                    onChanged: (val){},
                    focusNode: nodeConfPass,
                    label: 'Konfirmasi Kata Sandi Baru',
                    ctrl: edtEConfPass
                ),
                OverlayTes(
                  chil: newField(
                      onChanged: (val){},
                      focusNode: nodeConfPass,
                      label: 'Konfirmasi Kata Sandi Baru',
                      ctrl: edtEConfPass
                  ),
                  visible: true,
                  children: [
                    MenuItem(
                      onComplete: false,
                      text: "8 - 20 Karakter",
                    ),
                    MenuItem(
                      onComplete: false,
                      text: "1 Angka",
                    ),
                    MenuItem(
                      onComplete: false,
                      text: "1 Huruf Kapital",
                    ),
                    MenuItem(
                      onComplete: false,
                      text: "1 Huruf kecil",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
