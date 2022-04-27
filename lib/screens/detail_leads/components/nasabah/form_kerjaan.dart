import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:yodacentral/components/global_screen_notif.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:yodacentral/utils/utils.dart';


class FormPekerjaan extends StatefulWidget {
  // const FormPekerjaan({Key? key}) : super(key: key);
  Function? onSave;
  Function? onNext;
  bool? hasComplete;
  bool? allComplete;
  int? lead_id;

  FormPekerjaan({this.onSave, this.hasComplete, this.allComplete, this.lead_id, this.onNext});

  @override
  _FormPekerjaanState createState() => _FormPekerjaanState();
}

class _FormPekerjaanState extends State<FormPekerjaan>
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
    bool focused = false,
  }) {
    return TextFormField(
      maxLines: type == TextInputType.multiline ? 4 : 1,
      onTap: onTap,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        if (label == "Nomor KTP" || label == "Nomor KTP Pasangan")
          CreditCardFormatter(),
        if(label.contains('Lama'))
          LengthLimitingTextInputFormatter(3),
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
          if (v!.isNotEmpty && (v.length < 10 || v.length > 15)) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor KTP" || label == "Nomor KTP Pasangan") {
          if (v!.isNotEmpty && (v.length <= 0 || v.length > 19)) {
            return "Nomor KTP tidak valid";
          }
        }
      },
      controller: ctrl,
      onChanged: (v){
        controller.changeKerjaanMove(true);
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
        prefix: label == "Nomor Telepon" || label == "Nomor Telepon Institusi" ? Text("+62 ", style: TextStyle(color: yd_Color_Primary_Grey)) : null,
        suffixIcon: sufix,
        labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey),
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

  TextEditingController cPekerjaan = TextEditingController();
  TextEditingController cNamaInstitusi = TextEditingController();
  TextEditingController cJabatan = TextEditingController();
  TextEditingController cNomorTeleponInstitusi = TextEditingController();
  TextEditingController cAlamatInstitusi = TextEditingController();
  TextEditingController cCatatanPekerjaan = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initFocusPekerjaan();
    controller.setEnableButtonKerjaan();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
                focusNode: controller.focusPekerjaan,
                label: "Pekerjaan",
                ctrl: controller.edtKerjaan,
                focused: controller.focusedPekerjaan.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: controller.focusNamaInst,
                label: "Nama Institusi",
                ctrl: controller.edtNamaInstitusi,
                focused: controller.focusedNamaInst.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: controller.focusJabatan,
                label: "Jabatan",
                ctrl: controller.edtJabatan,
                focused: controller.focusedJabatan.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                  onChanged: (v)=>controller.setEnableButtonKerjaan(),
                  focusNode: controller.focusLama,
                  label: "Lama Usaha/Bekerja(Tahun)",
                  ctrl: controller.edtLamaKerja,
                  type: TextInputType.number,
                  focused: controller.focusedLama.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                  onChanged: (v)=>controller.setEnableButtonKerjaan(),
                  focusNode: controller.focusNoTlpInst,
                  label: "Nomor Telepon Institusi",
                  ctrl: controller.edtTlpInstitusi,
                  type: TextInputType.phone,
                  focused: controller.focusedNoTlpInst.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: controller.focusAlamatInst,
                label: "Alamat Institusi",
                ctrl: controller.edtAlamatInstitusi,
                type: TextInputType.multiline,
                focused: controller.focusedAlamatInst.value
              ),
              SizedBox(height: yd_defauld_padding),
              textFieldLogin(
                onChanged: (v)=>controller.setEnableButtonKerjaan(),
                focusNode: controller.focusNoteInst,
                label: "Catatan Pekerjaan",
                ctrl: controller.edtCatatanKerja,
                type: TextInputType.multiline,
                focused: controller.focusedNoteInst.value
              ),
              SizedBox(height: yd_defauld_padding * 3),
              btnKirim(
                  backGround: controller.enableButtonInstitusi.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                  textColor: Colors.white,
                  text: controller.enableButtonInstitusi.value && controller.allDOkNasabahComplete.value ? 'Kirim':"Lanjut",
                  onClick: (){
                    if(controller.enableButtonInstitusi.value){
                      controller.postPekerjaan(context: context, id: widget.lead_id.toString(),
                          onSuccess:(){
                            if(controller.enableButton.value){
                              controller.postIdentitas(context: context, id: widget.lead_id.toString(),
                                onSuccess: (){
                                  if(controller.enableButtonFoto.value){
                                    controller.postDokumentNasabah(
                                        context: context, id: widget.lead_id.toString(),
                                        path: controller.finalImage.value.path, docs:controller.listDoc,
                                        imageChange: [], imgDefault: [],
                                        onSuccess:(){
                                          successPost();
                                        }
                                    );
                                  }else{
                                    successPost();
                                  }
                                }
                              );
                            }else{
                              if(controller.enableButtonFoto.value){
                                controller.postDokumentNasabah(
                                    context: context, id: widget.lead_id.toString(),
                                    path: controller.finalImage.value.path, docs:controller.listDoc,
                                    imageChange: [], imgDefault: [],
                                    onSuccess:(){
                                      successPost();
                                    }
                                );
                              }else{
                                successPost();
                              }
                            }
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
          widget.onNext!();
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