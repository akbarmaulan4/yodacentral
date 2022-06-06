import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/kalkulator/kalkulator_controller.dart';
import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/screens/pages/kalkulator/result_otr_default_screen.dart';
import 'package:yodacentral/screens/pages/kalkulator/result_otr_entry_screen.dart';

class OTRDetaultScreen extends StatefulWidget {
  const OTRDetaultScreen({Key? key}) : super(key: key);

  @override
  _OTRDetaultScreenState createState() => _OTRDetaultScreenState();
}

class _OTRDetaultScreenState extends State<OTRDetaultScreen> {
  KalkulatorController controller = KalkulatorController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNewProv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Kalkulator Kredit'),
        leading: InkWell(
          onTap: ()=>Get.back(),
          child: Icon(Icons.arrow_back_rounded, color: Colors.black87,)
        ),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 18, right: 15),
            child: Text('Batalkan', style: TextStyle(fontWeight: FontWeight.w600, color: yd_Color_Primary),)
          )
        ],
      ),
      body: Obx(()=>Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 3,
              color: yd_Color_Primary_opacity,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text('OTR Default', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(yd_defauld_padding),
                    child: Column(
                      children: [
                        autoText(
                          label: controller.provLoad.value ? "Memuat..." : "Lokasi Mobil",
                          ctrl: controller.edtProv,
                          focusNode: controller.focusLokasi,
                          focused: controller.lokasiFocus.value,
                          value: controller.selectedProv.value,
                          items: controller.modelProv.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.kondisiLoad.value ? "Memuat..." : "Kondisi Mobil",
                          ctrl: controller.edtKondisi,
                          focusNode: controller.focusKondisi,
                          focused: controller.KondisiMobilFocus.value,
                          value: controller.selectedKondisi.value,
                          items: controller.modelKondisi.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.merkLoad.value ? "Memuat..." : "Merek",
                          ctrl: controller.edtMerk,
                          focusNode: controller.focusMerek,
                          focused: controller.merekFocus.value,
                          value: controller.selectedMerk.value,
                          items: controller.modelMerk.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.modelLoad.value ? "Memuat..." : "Model",
                          ctrl: controller.edtModel,
                          focusNode: controller.focusModel,
                          focused: controller.modelFocus.value,
                          value: controller.selectedModel.value,
                          items: controller.modelModel.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.varianLoad.value ? "Memuat..." : "Varian",
                          ctrl: controller.edtVarian,
                          focusNode: controller.focusVarian,
                          focused: controller.varianFocus.value,
                          value: controller.selectedVarian.value,
                          items: controller.modelVarian.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.kategoriLoad.value ? "Memuat..." : "Kategori",
                          ctrl: controller.edtKategori,
                          focusNode: controller.focusKategory,
                          focused: controller.kategoryFocus.value,
                          value: controller.selectedKategori.value,
                          items: controller.modelKategori.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: "Tahun Mobil",
                          ctrl: controller.edtTahun,
                          focusNode: controller.focusTahun,
                          focused: controller.tahunFocus.value,
                          value: controller.selectedTahun.value,
                          items: controller.listTahun,
                        ),
                        SizedBox(height: 10),
                        standartField(label: "DP (%)",
                            controller: controller.edtDP,
                            type: TextInputType.number,
                            node: controller.focusDP,
                            onChange: (val){
                              // controller.setEnableKontrak();
                              if(val != ''){
                                if(int.parse(val) > 100){
                                  val = '100';
                                  controller.edtDP.text = val;
                                  controller.edtDP.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                                }
                              }
                            },
                        focused: controller.dpFocus.value),
                        controller.showOTR.value ? Column(
                          children: [
                            SizedBox(height: 10),
                            standartField(label: "OTR Default",
                                controller: controller.edtOTRDefault,
                                type: TextInputType.number,
                                node: controller.focusOTRDefault,
                                enable: false,
                                focused: controller.otrDefaultFocus.value),
                          ],
                        ):Column(
                          children: [
                            SizedBox(height: 10),
                            standartField(label: "OTR Entry",
                                controller: controller.edtOTREntry,
                                type: TextInputType.number,
                                node: controller.focusOTREntry,
                                focused: controller.otrEntryFocus.value),
                          ],
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.statusAsuransiLoad.value ? "Memuat..." : "Status Asuransi",
                          ctrl: controller.edtStatusAsuransi,
                          focusNode: controller.focusStatusAsuransi,
                          focused: controller.statusAsuransiFocus.value,
                          value: controller.selectedStatusAsuransi.value,
                          items: controller.modelStatusAsuransi.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.loanTypeLoad.value ? "Memuat..." : "Loan Type",
                          ctrl: controller.edtLoanType,
                          focusNode: controller.focusLoanType,
                          focused: controller.loanTypeFocus.value,
                          value: controller.selectedLoanType.value,
                          items: controller.modelLoanType.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.tenorLoad.value ? "Memuat..." : "Tenor",
                          ctrl: controller.edtTenor,
                          focusNode: controller.focusTenor,
                          focused: controller.tenorFocus.value,
                          value: controller.selectedTenor.value,
                          items: controller.modelTenor.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.kategoriMobilLoad.value ? "Memuat..." : "Kategori Mobil",
                          ctrl: controller.edtKategoriMobil,
                          focusNode: controller.focusKategoryMobil,
                          focused: controller.kategoryMobilFocus.value,
                          value: controller.selectedKategoriMobil.value,
                          items: controller.modelKategoriMobil.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.tipeAsuransiLoad.value ? "Memuat..." : "Tipe Asuransi",
                          ctrl: controller.edtTipeAsuransi,
                          focusNode: controller.focusTipeAsuransi,
                          focused: controller.tipeAsuransiFocus.value,
                          value: controller.selectedTipeAsuransi.value,
                          items: controller.modelTipeAsuransi.value.data,
                        ),
                        SizedBox(height: 10),
                        autoText(
                          label: controller.tujuanPenggunaanLoad.value ? "Memuat..." : "Tujuan Penggunaan",
                          ctrl: controller.edtTujuanPenggunaan,
                          focusNode: controller.focusTujuanPenggunaan,
                          focused: controller.tujuanPenggunaanFocus.value,
                          value: controller.selectedTujuanPenggunaan.value,
                          items: controller.modelTujuanPenggunaan.value.data,
                        ),
                        SizedBox(height: 10),
                        standartField(label: "Sprate Rate",
                            controller: controller.edtSprateRate,
                            type: TextInputType.number,
                            node: controller.focusSprateRate,
                            onChange: (val){
                              // controller.setEnableKontrak();
                              if(val != ''){
                                if(int.parse(val) > 100){
                                  val = '100';
                                  controller.edtSprateRate.text = val;
                                  controller.edtSprateRate.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                                }
                              }
                            },
                            focused: controller.sprateRateFocus.value),
                        SizedBox(height: 10),
                        standartField(label: "Sprate Admin",
                            controller: controller.edtSprateAdmin,
                            type: TextInputType.number,
                            node: controller.focusSprateAdmin,
                            onChange: (val){
                              // controller.setEnableKontrak();
                              if(val != ''){
                                if(int.parse(val) > 100){
                                  val = '100';
                                  controller.edtSprateAdmin.text = val;
                                  controller.edtSprateAdmin.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                                }
                              }
                            },
                            focused: controller.sprateAdminFocus.value),
                        SizedBox(height: 10),
                        standartField(label: "Provisi",
                            controller: controller.edtProvisi,
                            type: TextInputType.number,
                            node: controller.focusProvisi,
                            onChange: (val){
                              // controller.setEnableKontrak();
                              if(val != ''){
                                if(int.parse(val) > 100){
                                  val = '100';
                                  controller.edtProvisi.text = val;
                                  controller.edtProvisi.selection = TextSelection.fromPosition(TextPosition(offset: val.length));
                                }
                              }
                            },
                            focused: controller.provisiFocus.value),
                        SizedBox(height: 25),
                        btnKirim(
                          backGround: yd_Color_Primary,
                          textColor: Colors.white,
                          text: 'Hitung Kredit',
                          onClick: ()=>controller.calculateOTRDefault(
                            context: context,
                            otrDefault: controller.edtOTRDefault.text,
                            onSuccess: (data)=>Get.to(()=>ResultOTREntryScreen(data: data))
                          )
                          // onClick: ()=>Get.to(()=>ResultOTRDefaultScreen())
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  btnKirim({
    required Color backGround,
    required Color textColor,
    required String text,
    Function? onClick
  }){
    return InkWell(
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
    );
  }

  autoText({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController ctrl,
    required FocusNode focusNode,
    bool focused = false,
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
        if (label == "Lokasi Mobil") {
          controller.setProvinsi(data!);
          controller.validationOTRDefault();
        } else if (label == "Kondisi Mobil") {
          controller.setKondisiMobil(data!);
          controller.validationOTRDefault();
        } else if (label == "Merek") {
          controller.setMerk(data!);
          controller.validationOTRDefault();
        } else if (label == "Model") {
          controller.setModel(data!);
          controller.validationOTRDefault();
        } else if (label == "Varian") {
          controller.setVarian(data!);
          controller.validationOTRDefault();
        }else if (label == "Kategori") {
          controller.setKategori(data!);
          controller.validationOTRDefault();
        } else if (label == "Tahun Mobil") {
          controller.setTahun(data!);
          controller.validationOTRDefault();
        } else if (label == "Status Asuransi") {
          controller.setStatusAsuransi(data!);
        } else if (label == "Loan Type") {
          controller.setLoanType(data!);
        } else if (label == "Tenor") {
          controller.setTenor(data!);
        } else if (label == "Kategori Mobil") {
          controller.setKategoriMobil(data!);
        } else if (label == "Tipe Asuransi") {
          controller.setTipeAsuransi(data!);
        } else if (label == "Tujuan Penggunaan") {
          controller.setTujuanPenggunaan(data!);
        }
        // controller.setEnableKontrak();
      },
    );
  }

  standartField({
    String? label,
    TextEditingController? controller,
    TextInputType? type,
    Function? onChange,
    FocusNode? node,
    bool focused = false,
    String? errorMessag,
    bool? enable = true
  }){
    return  Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextField(
          focusNode: node,
          inputFormatters:(label!.contains('DP') || label.contains('Sprate') || label.contains('Provisi')) ? [
          LengthLimitingTextInputFormatter(3),
          ]:[],
          controller: controller,
          keyboardType: type,
          enabled: enable,
          onChanged: (val) => onChange!(val),
        decoration: InputDecoration(
            border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1)),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: yd_Color_Primary, width: 2)),
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          errorText: errorMessag != '' ? errorMessag : null,
          fillColor: Colors.white,
          hintText: label,
          labelText: label,
          labelStyle: TextStyle(color: focused ? yd_Color_Primary : yd_Color_Primary_Grey,),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          suffix: (label.contains('DP') || label.contains('Sprate') || label.contains('Provisi')) ? Text('%'):null
        ),
      ),
    );
  }
}
