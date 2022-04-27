import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/models/model_detail_nasabah.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/utils/utils.dart';


class EditFormPekerjaan extends StatefulWidget {
  // const FormPekerjaan({Key? key}) : super(key: key);
  ModelDetailNasabah? data;
  Function? onBack;
  int? lead_id;
  String? namePipeline;

  EditFormPekerjaan({this.data, this.onBack, this.lead_id, this.namePipeline});

  @override
  _EditFormPekerjaanState createState() => _EditFormPekerjaanState();
}

class _EditFormPekerjaanState extends State<EditFormPekerjaan>
    with AutomaticKeepAliveClientMixin {

  NasabahController controller = Get.put(NasabahController());

  Widget textFieldLogin({
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
      inputFormatters: [
        if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
          CreditCardFormatter(),
      ],
      validator: (v) {
        if (label == "Nama Lengkap Sesuai KTP" ||
            label == "Nama Lengkap Pasangan" ||
            label == "Nama Gadis Ibu Kandung") {
          if (v!.isEmpty || v.length > 254) {
            return "Masukkan nama yang benar";
          } else {
            return null;
          }
        } else if (label == "Nomor Handphone" ||
            label == "Nomor Telepon Institusi") {
          if (v!.length < 10 || v.length > 15) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor KTP" || label == "Nomor KTP Pasangan") {
          if (v!.length <= 0 || v.length > 19) {
            return "Nomor KTP tidak valid";
          }
        }
      },
      controller: ctrl,
      onChanged: (v){
        controller.changeIdentityMove(true);
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

  FocusNode fPekerjaan = FocusNode();
  TextEditingController cPekerjaan = TextEditingController();
  FocusNode fNamaInstitusi = FocusNode();
  TextEditingController cNamaInstitusi = TextEditingController();
  FocusNode fJabatan = FocusNode();
  FocusNode fLamakerja = FocusNode();
  TextEditingController cJabatan = TextEditingController();

  FocusNode fNomorTeleponInstitusi = FocusNode();
  TextEditingController cNomorTeleponInstitusi = TextEditingController();
  FocusNode fAlamatInstitusi = FocusNode();
  TextEditingController cAlamatInstitusi = TextEditingController();
  FocusNode fCatatanPekerjaan = FocusNode();
  TextEditingController cCatatanPekerjaan = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initPekerjaan(widget.data!);
    controller.setEnableButtonKerjaan();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.namePipeline!, style: TextStyle(color: Colors.black, fontSize: 16,),),
                Text("#" + widget.lead_id.toString(), style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(()=>SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Data Pekerjaan",
                    style: TextStyle(
                      color: yd_Color_Primary_Grey,
                      fontSize: 12,
                    )),
              ),
              SizedBox(height: 10),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: fPekerjaan,
                label: "Pekerjaan",
                ctrl: controller.edtKerjaan,
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: fNamaInstitusi,
                label: "Nama Institusi",
                ctrl: controller.edtNamaInstitusi,
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: fJabatan,
                label: "Jabatan",
                ctrl: controller.edtJabatan,
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                  onChanged: (v)=>controller.setEnableButtonKerjaan(),
                  focusNode: fLamakerja,
                  label: "Lama Usaha/Bekerja(Tahun)",
                  ctrl: controller.edtLamaKerja,
                  type: TextInputType.number
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                  onChanged: (v)=>controller.setEnableButtonKerjaan(),
                  focusNode: fNomorTeleponInstitusi,
                  label: "Nomor Telepon Institusi",
                  ctrl: controller.edtTlpInstitusi,
                  type: TextInputType.phone
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: fAlamatInstitusi,
                label: "Alamat Institusi",
                ctrl: controller.edtAlamatInstitusi,
                type: TextInputType.multiline,
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: fCatatanPekerjaan,
                label: "Catatan Pekerjaan",
                ctrl: controller.edtCatatanKerja,
                type: TextInputType.multiline,
              ),
              SizedBox(height: yd_defauld_padding * 3),
              btnKirim(
                  backGround: controller.enableButtonInstitusi.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                  textColor: Colors.white,
                  text: 'Kirim',
                  onClick: (){
                    if(controller.enableButtonInstitusi.value){
                      controller.postPekerjaan(context: context, id: widget.lead_id.toString(),
                          onSuccess:(){
                            successPost();
                          }
                      );
                    }
                  }
              )
            ],
          ),
        ),
      )),
    );
  }

  successPost(){
    Get.bottomSheet(
      GlobalScreenNotif(
        title: "Berhasil",
        content: "Data Nasabah Berhasil dikirim",
        onTap: () {
          Get.back();
          Get.back();
          widget.onBack!();
        },
        textButton: "Selesai",
      ),
      isScrollControlled: true,
    );
  }

  btnKirim({
    required Color backGround,
    required Color textColor,
    required String text,
    Function? onClick
  }){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: yd_defauld_padding),
      child: InkWell(
        onTap: ()=>onClick!(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          width: Get.width,
          height: 45,
          decoration: BoxDecoration(
            color: backGround,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}