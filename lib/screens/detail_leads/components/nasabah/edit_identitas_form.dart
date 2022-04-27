import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/nasabah/nasabah_controller.dart';
import 'package:yodacentral/models/model_detail_nasabah.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/utils/utils.dart';


class EditFormIdentitas extends StatefulWidget {
  int? id_unit;
  int? lead_id;
  String? namePipeline;
  bool? domisili;
  ModelDetailNasabah? data;
  Function? onBack;
  EditFormIdentitas({this.lead_id, this.id_unit, this.namePipeline, this.domisili = false, this.data, this.onBack});
  @override
  _EditFormIdentitasState createState() => _EditFormIdentitasState();
}

class _EditFormIdentitasState extends State<EditFormIdentitas> {

  NasabahController controller = NasabahController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.init();
    controller.initFocusIdentitas();
    controller.initDomisili(widget.data!);
    controller.initEditIdentitas(widget.data!);
    // if(widget.domisili!){
    //   controller.initDomisili(widget.data!);
    // }else{
    //   controller.initEditIdentitas(widget.data!);
    // }
  }

  popBack(){
    Get.back(result: controller.dataInfoHide);
    // controller.dataInfoHide.clear();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> popBack(),
      child: Scaffold(
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
        body: Obx(()=>Container(
          padding: EdgeInsets.all(yd_defauld_padding),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Text(widget.domisili! ? 'Edit Domisili':"Edit Identitas", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center)),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft, child: Text("Data diri", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,))),
                SizedBox(height: 10,),
                Column(
                  children: [
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusName,
                      label: "Nama Lengkap Sesuai KTP",
                      ctrl: controller.edtNamaLengkap,
                      focused: controller.focusedName.value,
                    ),
                    SizedBox(height: yd_defauld_padding),
                    ttt(
                      ctrl: controller.edtGender,
                      label: 'Jenis Kelamin',
                      value: controller.strGender.value,
                      items: controller.jenisKelamin.value,
                      focusNode: controller.focusGender,
                      focused: controller.focusedGender.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusNoKTP,
                      label: "Nomor KTP",
                      ctrl: controller.edtNoKTP,
                      type: TextInputType.number,
                      focused: controller.focusedNoKTP.value
                    ),
                    controller.tglTerbitKTPActive.value ? Column(
                      children: [
                        SizedBox(height: yd_defauld_padding,),
                        textFieldLogin(
                            onTap: ()=>controller.openDatePicker(context, controller.edtTglTerbitKTP),
                            onChanged: (v)=>controller.setEnableButtonIdentitas(),
                            focusNode: controller.focusTglTerbitKTP,
                            label: "Tanggal Terbit KTP",
                            ctrl: controller.edtTglTerbitKTP,
                            readOnly: true,
                            sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,),
                            focused: controller.focusedTglTerbitKTP.value
                        ),
                      ],
                    ):SizedBox(),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                        onTap: ()=>controller.openDatePicker(context, controller.edtTglLahir),
                        onChanged: (v)=>controller.setEnableButtonIdentitas(),
                        focusNode: controller.focusTglLahir,
                        label: "Tanggal Lahir",
                        ctrl: controller.edtTglLahir,
                        readOnly: true,
                        sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,),
                        focused: controller.focusedTglLahir.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                      onTap: () {},
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusTmptLahir,
                      label: "Tempat Lahir",
                      ctrl: controller.edtTmptLahir,
                      focused: controller.focusedTmptLahir.value
                      // readOnly: true,
                      // sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,)
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    ttt(
                        ctrl: controller.edtEducation,
                        label: 'Pendidikan Terakhir',
                        value: controller.strEducation.value,
                        items: controller.pendidikan.value,
                        focusNode: controller.focusEducation,
                        focused: controller.focusedEducation.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusNamaIbu,
                      label: "Nama Gadis Ibu Kandung",
                      ctrl: controller.edtNamaIbu,
                      focused: controller.focusedNamaIbu.value
                    ),
                    SizedBox(height: yd_defauld_padding),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focustNoHP,
                      label: "Nomor Handphone",
                      ctrl: controller.edtNoHP,
                      type: TextInputType.phone,
                      focused: controller.focusedNoHP.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusNoNPWP,
                      label: "Nomor NPWP",
                      ctrl: controller.edtNoNPWP,
                      type: TextInputType.number,
                      focused: controller.focusedNoNPWP.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    ttt(
                        ctrl: controller.edtMarital,
                        label: 'Status Pernikahan',
                        value: controller.strMarital.value,
                        items: controller.statusPerkawinan.value,
                        focusNode: controller.focusMarital,
                        focused: controller.focusedMarital.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusCatatan,
                      label: "Catatan Data Diri",
                      ctrl: controller.edtCatatan,
                      type: TextInputType.multiline,
                      focused: controller.focusedCatatan.value
                    ),
                    controller.isMerried.value ? Column(
                      children: [
                        SizedBox(height: 30,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Data pasangan", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
                        ),
                        SizedBox(height: 10),
                        textFieldLogin(
                          onChanged: (v)=>controller.setEnableButtonIdentitas(),
                          focusNode: controller.focusNamaPasangan,
                          label: "Nama Lengkap Pasangan",
                          ctrl: controller.edtNamaPasangan,
                          focused: controller.focusedNamaPasangan.value
                        ),
                        SizedBox(height: yd_defauld_padding),
                        textFieldLogin(
                          onChanged: (v)=>controller.setEnableButtonIdentitas(),
                          focusNode: controller.focusKTPPasangan,
                          label: "Nomor KTP Pasangan",
                          ctrl: controller.edtKTPPasangan,
                          type: TextInputType.number,
                          focused: controller.focusedKTPPasangan.value
                        ),
                        SizedBox(height: yd_defauld_padding),
                        textFieldLogin(
                            onTap: ()=>controller.openDatePicker(context, controller.edtTglLahirPasangan),
                            onChanged: (v)=>controller.setEnableButtonIdentitas(),
                            focusNode: controller.focusTglLahirPasangan,
                            label: "Tanggal Lahir Pasangan",
                            ctrl: controller.edtTglLahirPasangan,
                            readOnly: true,
                            sufix: Icon(Icons.arrow_drop_down_rounded, color: yd_Color_Primary_Grey,),
                            focused: controller.focusedTglLahirPasangan.value
                        ),
                        SizedBox(height: yd_defauld_padding,),
                        textFieldLogin(
                          onChanged: (v)=>controller.setEnableButtonIdentitas(),
                          focusNode: controller.focusNoHPPasangan,
                          label: "Nomor Handphone Pasangan",
                          ctrl: controller.edtNoHPPasangan,
                          type: TextInputType.phone,
                          focused: controller.focusedNoHPPasangan.value
                        ),
                      ],
                    ):SizedBox(),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Domisili nasabah",
                          style: TextStyle(
                            color: yd_Color_Primary_Grey,
                            fontSize: 12,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusAlamat,
                      label: "Alamat Sesuai KTP",
                      ctrl: controller.edtAlamat,
                      focused: controller.focusedAlamat.value
                      // type: TextInputType.phone,
                      // type: TextInputType.number,
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    fieldFree(
                      label: controller.provLoad.value ? "Memuat..." : "Provinsi",
                      value: controller.selectedProv.value,
                      ctrl: controller.edtProvinsi,
                      items: controller.provLoad.value ? []: controller.modelProv.value.data,
                      focusNode: controller.focusProvinsi,
                      focused: controller.focusedProvinsi.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    fieldFree(
                      label: controller.kotaLoad.value ? "Memuat..." : "Kota/Kabupaten",
                      value: controller.selectedKota.value,
                      ctrl: controller.edtKota,
                      items: controller.kotaLoad.value? []: controller.modelKota.value.data,
                      focusNode: controller.focusKota,
                      focused: controller.focusedKota.value
                    ),
                    SizedBox(height: yd_defauld_padding,),
                    fieldFree(
                      label: controller.kecLoad.value ? "Memuat..." : "Kecamatan",
                      value: controller.selectedKec.value,
                      ctrl: controller.edtKecamatan,
                      items: controller.kecLoad.value? []: controller.modelKec.value.data,
                      focusNode: controller.focusKecamatan,
                      focused: controller.focusedKecamatan.value
                    ),
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusKelurahan,
                      label: "Kelurahan",
                      ctrl: controller.edtKelurahan,
                      focused: controller.focusedKelurahan.value
                      // type: TextInputType.phone,
                      // type: TextInputType.number,
                    ),
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusKodePOS,
                      label: "Kode Pos",
                      ctrl: controller.edtKodePOS,
                      // type: TextInputType.phone,
                      type: TextInputType.number,
                      focused: controller.focusedKodePOS.value
                    ),
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    controller.tlpRumahActive.value ? Column(
                      children: [
                        textFieldLogin(
                          onChanged: (v)=>controller.setEnableButtonDomisili(),
                          label: "Nomor Telepon Rumah",
                          ctrl: controller.edtNoTlpRUmah,
                          type: TextInputType.phone,
                          focusNode: controller.focusNoTlpRUmah,
                          focused: controller.focusedNoTlpRUmah.value
                        ),
                        SizedBox(
                          height: yd_defauld_padding,
                        ),
                      ],
                    ):SizedBox(),

                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusRT,
                      label: "RT",
                      ctrl: controller.edtRT,
                      type: TextInputType.number,
                      focused: controller.focusedRT.value
                    ),
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusRW,
                      label: "RW",
                      ctrl: controller.edtRW,
                      type: TextInputType.number,
                      focused: controller.focusedRW.value
                    ),
                    SizedBox(height: yd_defauld_padding),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonDomisili(),
                      focusNode: controller.focusDomisili,
                      label: "Catatan Domisili",
                      ctrl: controller.edtDomisili,
                      type: TextInputType.multiline,
                      focused: controller.focusDedomisili.value
                    ),
                  ],
                ),
                SizedBox(height: 30),
                controller.namaPenjaminActive.value || controller.ktpPenjaminActive.value || controller.hubunganPenjaminActive.value? Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Data Penjamin", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
                ):SizedBox(),
                controller.namaPenjaminActive.value ? Column(
                  children: [
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusNamaPenjamin,
                      label: "Nama Penjamin",
                      ctrl: controller.edtNamaPenjamin,
                      focused: controller.focusedNamaPenjamin.value
                    ),
                  ],
                ):SizedBox(),
                controller.ktpPenjaminActive.value ? Column(
                  children: [
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusKTPPenjamin,
                      label: "Nomor KTP Penjamin",
                      ctrl: controller.edtKTPPenjamin,
                      type: TextInputType.number,
                      focused: controller.focusedKTPPenjamin.value
                    ),
                  ],
                ):SizedBox(),
                controller.hubunganPenjaminActive.value ? Column(
                  children: [
                    SizedBox(
                      height: yd_defauld_padding,
                    ),
                    textFieldLogin(
                      onChanged: (v)=>controller.setEnableButtonIdentitas(),
                      focusNode: controller.focusHubunganPenjamin,
                      label: "Hubungan dengan pemohon",
                      ctrl: controller.edtHubunganPenjamin,
                      focused: controller.focusedHubunganPenjamin.value
                    ),
                  ],
                ):SizedBox(),
                SizedBox(height: yd_defauld_padding * 2,),
                InkWell(
                    onTap: ()=>bottomSheetAddInfo(),
                    child: Text("Munculkan / sembunyikan informasi tambahan",
                        style: TextStyle(color: yd_Color_Primary, fontWeight: FontWeight.bold))
                ),
                SizedBox(height: yd_defauld_padding * 3),
                btnKirim(
                    backGround: controller.enableButton.value ? yd_Color_Primary:yd_Color_Primary_Grey,
                    textColor: Colors.white,
                    text: 'Kirim',
                    onClick: (){
                      if(controller.enableButton.value){
                        controller.newUpdateIdentitas(context, widget.lead_id.toString(), true, (data)=>widget.onBack!(data));
                        // if(widget.domisili!){
                        //   controller.updateDomisili(context, widget.lead_id.toString(), true, (data)=>widget.onBack!(data));
                        // }else{
                        //   controller.updateIdentitas(context, widget.lead_id.toString(), true, (data)=>widget.onBack!(data));
                        // }
                      }
                    }
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  validasiNPWP(String param){
    var strNPWP = '';
    if(param != ''){

    }

  }

  bottomSheetAddInfo(){
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        width: Get.width,
        height: Get.height - (yd_defauld_padding * 2.5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: ()=>Get.back(),
                child: Icon(Icons.arrow_back_rounded)
            ),
            SizedBox(height: yd_defauld_padding * 5),
            Center(child: Text('Informasi Tambahan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Data Diri", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
                SizedBox(height: 10),
                Row(
                  children: [
                    itemAddInfo('Tanggal Terbit KTP', controller.ktpActive)
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: yd_defauld_padding * 2),
                Text("Domisili", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
                SizedBox(height: 10),
                Row(
                  children: [
                    itemAddInfo('Nomor Telepon Rumah', controller.tlpRUmah)
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: yd_defauld_padding * 2),
                Text("Data Penjamin", style: TextStyle(color: yd_Color_Primary_Grey, fontSize: 12,)),
                SizedBox(height: 10),
                Wrap(
                  children: [
                    itemAddInfoPenjamin('Nama Penjamin', controller.namaPenjamin),
                    itemAddInfoPenjamin('Nomor KTP Penjamin', controller.ktpPenjamin),
                    itemAddInfoPenjamin('Hubungan dengan pemohon', controller.hubPenjamin)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  itemAddInfo(String label, bool isActive){
    return InkWell(
      onTap: (){
        controller.changeAddInfo(label, isActive);
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: isActive ? null : Border.all(width: 1, color: Colors.black87),
            color: isActive ? Color(0xFFD9EDE9) : Colors.grey.shade300
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),),
        ),
      ),
    );
  }

  itemAddInfoPenjamin(String label, bool isActive){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        controller.changeAddInfo(label, isActive);
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: isActive ? null : Border.all(width: 1, color: Colors.black87),
            color: isActive ? Color(0xFFD9EDE9) : Colors.grey.shade200
        ),
        width: size.width * 0.4,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),),
        ),
      ),
    );
  }

  bool invalid = false;
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
    bool focused = false
  }) {
    return TextFormField(
      maxLines: type == TextInputType.multiline ? 4 : 1,
      onTap: onTap,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        if (label.contains('Nomor KTP'))
          CreditCardFormatter(),
        if(label.contains('NPWP'))
          controller.npwpFormat,
        if(label == 'RT' || label == 'RW')
          LengthLimitingTextInputFormatter(3),
        if(label == 'Kode Pos')
          LengthLimitingTextInputFormatter(6)
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
        } else if (label == "Nomor Handphone" || label == "Nomor Handphone Pasangan") {
          if (v!.length < 10 || v.length > 15) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor Telepon Rumah") {
          if (v!.removeAllWhitespace.length < 8 || v.removeAllWhitespace.length > 15) {
            return "Nomor Telepon Rumah tidak valid";
          } else {
            return null;
          }
        } else if (label == "Nomor KTP" || label == "Nomor KTP Pasangan" || label == "Nomor KTP Penjamin") {
          if (v!.length < 19 || v.length > 19) {
            return "Nomor KTP tidak valid";
          }
        }
      },
      controller: ctrl,
      onChanged: (v) => onChanged(v),
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: label == "Catatan Data Diri" || label == "Catatan Domisili" ? EdgeInsets.symmetric(horizontal: 15, vertical: 15) : EdgeInsets.symmetric(horizontal: 15),
        errorText: messageApi == null ? null : messageApi,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        labelText: label,
        prefix: label.contains('Handphone') || label.contains('Telepon') ? Text("+62 ", style: TextStyle(color: yd_Color_Primary_Grey)): null,
        suffixIcon: sufix,
        labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
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

  Widget ttt({
    List<String>? items,
    String? value,
    TextInputType? type,
    required String label,
    required TextEditingController ctrl,
    required FocusNode focusNode,
    bool focused = false,
  }) {
    return TypeAheadField<String?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      hideOnError: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: ctrl,
        focusNode: focusNode,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.arrow_drop_down_rounded,
              color: yd_Color_Primary_Grey,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            // hintText: label,
            labelText: label,
            labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
        ),
      ),
      suggestionsCallback: (search) {
        return items!.where((element) => element.toLowerCase().contains(search.toLowerCase())).toList();
      },
      itemBuilder: (context, String? datum) {
        return ListTile(title: Text(datum!),);
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text('tidak ditemukan', style: TextStyle(fontSize: 12),),
        ),
      ),
      onSuggestionSelected: (String? data) {
        if(label.contains('Nama Lengkap')){

        } else if(label == 'Jenis Kelamin'){
          controller.setField('gender', data != null ? data : '');
        }else if(label == 'Pendidikan Terakhir'){
          controller.setField('education', data != null ? data : '');
        }else if(label == 'Status Pernikahan'){
          controller.setField('marital', data != null ? data : '');
        }
        if(widget.domisili!){
          controller.setEnableButtonDomisili();
        }else{
          controller.setEnableButtonIdentitas();
        }
      },
    );
  }

  Widget fieldFree({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController ctrl,
    required FocusNode focusNode,
    bool focused = false
  }) {
    return TypeAheadField<Datum?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      hideOnError: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: ctrl,
        focusNode: focusNode,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.arrow_drop_down_rounded,
              color: yd_Color_Primary_Grey,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yd_Color_Primary, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            // hintText: label,
            labelText: label,
            labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
        ),
        onChanged: (val){
          if(val == ''){
            if (label == "Provinsi") {
              controller.changeProvinsi();
            } else if (label == "Kota/Kabupaten") {
              controller.changeKota();
            } else if (label == "Kecamatan") {
              controller.changeKecamatan();
            }
            // if(widget.domisili!){
            //   controller.setEnableButtonDomisili();
            // }else{
            //   controller.setEnableButtonIdentitas();
            // }
          }

        },
      ),
      suggestionsCallback: (search) {
        return items!.where((element) => element.name!.toLowerCase().contains(search.toLowerCase())).toList();
      },
      itemBuilder: (context, Datum? datum) {
        return ListTile(title: Text(datum!.name!),);
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text('tidak ditemukan', style: TextStyle(fontSize: 12),),
        ),
      ),
      onSuggestionSelected: (Datum? data) {
        if (label == "Provinsi") {
          controller.setProvinsi(data!);
        } else if (label == "Kota/Kabupaten") {
          controller.setKota(data!);
        } else if (label == "Kecamatan") {
          controller.setKecamatan(data!);
        }
        if(widget.domisili!){
          controller.setEnableButtonDomisili();
        }else{
          controller.setEnableButtonIdentitas();
        }
      },
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
}
