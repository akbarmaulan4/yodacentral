import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yodacentral/api_url/api_url.dart';
import 'package:yodacentral/components/customDialog.dart';
import 'package:yodacentral/components/maskeddd.dart';
import 'package:yodacentral/components/modal_Load.dart';
// import 'package:yodacentral/components/modal_Load.dart';

import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_add_lead_financing/controller_add_lead_financing.dart';

import 'package:yodacentral/models/model_wilayah.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/login/components/button_default_login.dart';
import 'package:http/http.dart' as http;
import 'package:yodacentral/screens/wrapping_screen/wrapping_screen.dart';

class AddSellerBaru extends StatefulWidget {
  const AddSellerBaru(
      {Key? key,
      required this.isFinancing,
      required this.nama,
      this.isEdit = false})
      : super(key: key);
  final String nama;
  final bool isFinancing;
  final bool? isEdit;

  @override
  _AddSellerBaruState createState() => _AddSellerBaruState();
}

class _AddSellerBaruState extends State<AddSellerBaru> {
  FocusNode fName = new FocusNode();
  FocusNode fPhone = new FocusNode();
  TextEditingController catatan = TextEditingController();
  FocusNode fCatatan = new FocusNode();
  TextEditingController name = TextEditingController();
  TextEditingController phone = MaskedTextController(mask: '000 0000 00000');
  ControllerAddLeadFinancing addLeadFinancing =
      Get.put(ControllerAddLeadFinancing());

  String? finalNumberTelp;
  @override
  void initState() {
    super.initState();
    getProv();
    name.text = widget.nama;
    na = true;
    log(widget.isEdit.toString());
  }

  File? finalImage;
  final ImagePicker _picker = ImagePicker();
  getImageGallery({int? index}) async {
    Get.back();
    XFile? xFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (index == null) {
      if (xFile == null) {
        log("null");
      } else {
        setState(() {
          finalImage = File(xFile.path);
        });
      }
    } else {
      setState(() {
        // finalImage = File(xFile.path);
        Get.back();
      });
    }
  }

  getImageCamera({int? index}) async {
    Get.back();
    XFile? xFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    if (index == null) {
      if (xFile == null) {
        log("null");
      } else {
        setState(() {
          finalImage = File(xFile.path);

          // Get.back();
        });
      }
    } else {
      setState(() {
        Get.back();
      });
    }
  }

  Widget di({required bool shadow}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: Get.width,
      height: Get.width / 2.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(16),
          boxShadow: [
            shadow
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5,
                  )
                : BoxShadow(
                    color: Colors.black.withOpacity(0.0),
                    blurRadius: 0,
                  )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageCamera();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Colors.black),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     getImageCamera();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          //     child: Row(
          //       children: [
          //         Icon(Icons.camera_alt_rounded),
          //         SizedBox(
          //           width: yd_defauld_padding,
          //         ),
          //         Text(
          //           "Camera",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: "RR",
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageGallery();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(Icons.photo_library_rounded, color: Colors.black),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Album foto",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     getImageGallery();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          //     child: Row(
          //       children: [
          //         Icon(Icons.photo_library_rounded),
          //         SizedBox(
          //           width: yd_defauld_padding,
          //         ),
          //         Text(
          //           "Album foto",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: "RR",
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          TextButton(
            style: TextButton.styleFrom(
              primary: yd_Color_Primary,
            ),
            onPressed: () {
              getImageGallery();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.folder_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: yd_defauld_padding,
                  ),
                  Text(
                    "Dokumen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "RR",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     getImageGallery();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
          //     child: Row(
          //       children: [
          //         Icon(Icons.folder_rounded),
          //         SizedBox(
          //           width: yd_defauld_padding,
          //         ),
          //         Text(
          //           "Dokumen",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: "RR",
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget dialogImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: di(
          shadow: false,
        ),
      ),
    );
  }

  bool na = false;
  bool pho = false;

  Widget textFieldLogin({
    required Function(String) onChanged,
    required FocusNode focusNode,
    required String label,
    required TextEditingController controller,
    TextInputType? type,
    bool? autoFoc = false,
    String? message,
  }) {
    return TextFormField(
      autofocus: autoFoc!,
      autovalidateMode: label == "Nama Seller"
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: label == "Alamat" ? 4 : 1,
      onChanged: (v) {
        setState(() {});
        if (label == "Nama Seller") {
          setState(() {
            cekNa = true;
          });
          if (v.isEmpty || v.length <= 2 || v.length > 254) {
            setState(() {
              na = false;
            });
          } else {
            setState(() {
              na = true;
            });
          }
        } else if (label == "Nomor Telepon") {
          log("ini nomor tlp");
          setState(() {
            cekNo = true;
          });

          if (v.length < 10 || v.length > 15) {
            setState(() {
              pho = false;
            });
          } else {
            setState(() {
              pho = true;
            });
          }
        }

        // string.substring(1, string.length()-1);
      },
      validator: (v) {
        if (label == "Nama Seller") {
          if (v!.isEmpty || v.length > 254) {
            return "Masukkan nama yang benar";
          } else {
            return null;
          }
        } else if (label == "Nomor Telepon") {
          if (v!.length < 10 || v.length > 15) {
            return "Nomor telepon tidak valid";
          } else {
            return null;
          }
        }
      },
      focusNode: focusNode,
      keyboardType: type,
      decoration: InputDecoration(
        errorText: message ?? null,
        prefix: label == "Nomor Telepon" ? Text("+62 ", style: TextStyle(color: yd_Color_Primary_Grey),) : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: label == "Alamat" ? 8 : 0),
        labelText: label,
        labelStyle: TextStyle( color: focusNode.hasFocus ? yd_Color_Primary : yd_Color_Primary_Grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Datum? seledtedProv;
  TextEditingController cprov = TextEditingController();
  Datum? seledtedKotaKab;
  TextEditingController ckab = TextEditingController();
  Datum? seledtedKec;
  TextEditingController ckec = TextEditingController();

  Widget ttt({
    List<Datum>? items,
    Datum? value,
    required String label,
    required TextEditingController controller,
  }) {
    return TypeAheadField<Datum?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
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
            labelStyle: TextStyle(
              color: yd_Color_Primary_Grey,
            )),
      ),
      suggestionsCallback: (search) {
        return items!
            .where((element) =>
                element.name!.toLowerCase().contains(search.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, Datum? datum) {
        return ListTile(
          title: Text(datum!.name!),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text(
            'tidak ditemukan',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      onSuggestionSelected: (Datum? data) {
        // if (label == "Merek") {
        //   setState(() {
        //     controller.text = data!.name!;
        //     selectedmerek = data;
        //   });
        // }

        if (items!.length <= 0 || items.isEmpty) {
          // log("disable");
        } else {
          if (label == "Provinsi") {
            clearKotKec();

            setState(() {
              seledtedKotaKab = null;
              seledtedKec = null;
            });
            getKota(id: (data)!.id!);
          } else if (label == "Kota/Kabupaten") {
            clearKec();
            setState(() {
              seledtedKec = null;
              ckab.clear();
            });
            getKec(id: (data)!.id!);
          }
        }
        if (label == "Provinsi") {
          setState(() {
            controller.text = data!.name!;
            seledtedProv = data;
            ckab.clear();
            ckec.clear();
          });
        } else if (label == "Kota/Kabupaten") {
          setState(() {
            ckec.clear();
            controller.text = data!.name!;
            seledtedKotaKab = data;
          });
        } else if (label == "Kecamatan") {
          setState(() {
            controller.text = data!.name!;
            seledtedKec = data;
          });
        }
      },
    );
  }

  ModelWilayah? prov;
  ModelWilayah? kota;
  ModelWilayah? kec;

  bool loadProv = false;
  bool loadKota = false;
  bool loadKec = false;

  clearKotKec() {
    setState(() {
      kec = null;
      kota = null;
    });
  }

  clearKec() {
    setState(() {
      kec = null;
    });
  }

  getProv() async {
    setState(() {
      loadProv = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = '${ApiUrl.domain.toString()}${ApiUrl.prov.toString()}';
      var res = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadProv = false;
          prov = modelProvinsiFromMap(res.body);

          log(res.body);
        });
      } else {
        setState(() {
          loadProv = false;
          log(res.body);
        });
      }
    });
  }

  getKota({required int id}) async {
    setState(() {
      loadKota = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = Uri.tryParse(
        ApiUrl.domain.toString() + ApiUrl.kotaKab.toString() + id.toString(),
      );
      // var url = '${ApiUrl.domain.toString()}/api/lead/search/Refinancing?search=${search.toString()}';
      var res = await http.get(url!, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadKota = false;
          kota = modelProvinsiFromMap(res.body);
          log(res.body);
        });
      } else {
        setState(() {
          loadKota = false;
          log(res.body);
        });
      }
    });
  }

  getKec({required int id}) async {
    setState(() {
      loadKec = true;
    });
    SaveRoot.callSaveRoot().then((value) async {
      var url = Uri.tryParse(
        ApiUrl.domain.toString() + ApiUrl.kec.toString() + id.toString(),
      );
      var res = await http.get(url!, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });

      if (res.statusCode == 200) {
        setState(() {
          loadKec = false;
          kec = modelProvinsiFromMap(res.body);
          log(res.body);
        });
      } else {
        setState(() {
          loadKec = false;
          log(res.body);
        });
      }
    });
  }

  bool cekNo = true;
  bool cekNa = true;
  String? cekNoo;
  String? cekNaa;

  bool loadi = false;

  cekNomerTlp() async {
    modalLoad();
    SaveRoot.callSaveRoot().then((value) async {
      // var url = Uri.tryParse(ApiUrl.domain.toString() + "/api/admin/penjual/cek-telpon");
      var url = '${ApiUrl.domain.toString()}/api/penjual/cek-telpon';
      print('URL ${url}');
      var body = {
      'telp': phone.text.replaceAll(' ', '')
      };
      var res = await http.post(Uri.parse(url.trim()), body: body, headers: {
        'Authorization': 'Bearer ' + value.token.toString(),
      });
      print('Body : ${jsonEncode(body)}');
      print('Response : ${jsonEncode(res.body)}');
      if (res.statusCode == 200) {
        if (Get.isBottomSheetOpen == true) Get.back();
        log(res.body);
        addLeadFinancing.inputSellerBaru(
          namaSellerA: name.text,
          nomorSellerA: phone.text,
          provinsiSellerA: seledtedProv!,
          kotaKabupatenSellerA: seledtedKotaKab!,
          kecamatanSellerA: seledtedKec!,
          fotoSellerA: finalImage!,
          alamatA: catatan.text,
        );
      } else {
        if (Get.isBottomSheetOpen == true) Get.back();
        log(res.body, name: "ini cek nomer tlp");
        setState(() {
          cekNoo = "Nomor telepon sudah terdaftar";
          // cekNo = false;
          // loadi = false;
        });
      }
    });
  }

  click() {
    // modalLoad();
    cekNomerTlp();
    // cekNama();

    // cekNama();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fName.unfocus();
          fPhone.unfocus();
          fCatatan.unfocus();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          title: widget.isFinancing
              ? Text(
                  "Tambah Lead Financing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : Text(
                  "Tambah Lead Refinancing",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => CustomDialog(backI: () {
                          Get.offAll(() => Wraping());
                        }),
                    barrierColor: Colors.black.withOpacity(0.7));
              },
              child: Text(
                "Batalkan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: yd_Color_Primary,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                color: yd_Color_Primary.withOpacity(0.3),
                height: 5,
                width: Get.width,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      color: yd_Color_Primary,
                      height: 5,
                      width: Get.width * 0.75,
                    )
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(5),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Center(
                child: Text(
                  "Informasi Seller Mobil",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Focus(
              onFocusChange: (f) {
                setState(() {
                  // !v
                  //     ? phone.text = phone.text.replaceFirst(RegExp(r'^0+'), "")
                  //     : log("sedang aktif");
                  cekNa = true;

                  // 'XPT OXXS FXBA C';
                  // x.substring(0, 4) + " " + x.substring(4, 8) + " " + x.substring(8, x.length)
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: textFieldLogin(
                  message: cekNaa,
                  autoFoc: true,
                  controller: name,
                  focusNode: fName,
                  label: "Nama Seller",
                  type: TextInputType.text,
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: yd_defauld_padding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                ttt(
                  controller: cprov,
                  items: loadProv
                      ? []
                      : prov == null
                          ? []
                          : prov!.data!,
                  value: seledtedProv,
                  label: loadProv ? "Memuat..." : "Provinsi",
                ),
                SizedBox(
                  height: yd_defauld_padding,
                ),
                ttt(
                  controller: ckab,
                  items: loadKota
                      ? []
                      : kota == null
                          ? []
                          : kota!.data!,
                  value: seledtedKotaKab,
                  label: loadKota ? "Memuat..." : "Kota/Kabupaten",
                ),
                SizedBox(
                  height: yd_defauld_padding,
                ),
                ttt(
                  controller: ckec,
                  items: loadKec
                      ? []
                      : kec == null
                          ? []
                          : kec!.data!,
                  value: seledtedKec,
                  label: loadKec ? "Memuat..." : "Kecamatan",
                ),
                SizedBox(
                  height: yd_defauld_padding,
                ),
                textFieldLogin(
                  label: "Alamat",
                  focusNode: fCatatan,
                  controller: catatan,
                  type: TextInputType.multiline,
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: yd_defauld_padding,
                ),
              ]),
            ),
            Focus(
              onFocusChange: (v) {
                setState(() {
                  !v ? phone.text = phone.text.replaceFirst(RegExp(r'^0+'), "") : log("sedang aktif");
                  cekNo = true;

                  // 'XPT OXXS FXBA C';
                  // x.substring(0, 4) + " " + x.substring(4, 8) + " " + x.substring(8, x.length)
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: textFieldLogin(
                  message: cekNoo,
                  controller: phone,
                  focusNode: fPhone,
                  label: "Nomor Telepon",
                  type: TextInputType.phone,
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    fCatatan.unfocus();
                    fPhone.unfocus();
                  });
                  showDialog(
                    context: context,
                    builder: (context) => dialogImage(),
                  );
                },
                child: DottedBorder(
                  radius: Radius.circular(8),
                  color: yd_Color_Primary_Grey.withOpacity(0.1),
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  dashPattern: [10, 1],
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foto Seller",
                          style: TextStyle(
                            fontSize: 12,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: Get.width - 30,
                          child: finalImage == null
                              ? Icon(Icons.camera_alt, size: Get.width / 5)
                              : Image.file(
                                  finalImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: yd_defauld_padding * 2,
            ),
          ]),
        ),
        bottomNavigationBar: na == false ||
                pho == false ||
                finalImage == null ||
                seledtedProv == null ||
                seledtedKotaKab == null ||
                seledtedKec == null ||
                catatan.text.length == 0 ||
                cekNo == false ||
                cekNa == false
            ? GestureDetector(
                onTap: () {
                  log(na.toString(), name: "ini nama");
                  log(pho.toString(), name: "ini phone");
                },
                child: buttonDefaulLogin(
                  backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                  textColor: Colors.white,
                  text: "Selanjutnya",
                ),
              )
            : loadi
                ? GestureDetector(
                    onTap: () {
                      log(na.toString(), name: "ini nama");
                      log(pho.toString(), name: "ini phone");
                    },
                    child: buttonDefaulLogin(
                      backGround: yd_Color_Primary_Grey.withOpacity(0.3),
                      textColor: Colors.white,
                      text: "Menunggu",
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      click();
                      // Future.delayed(Duration(seconds: 4), () {
                      //   log("hmmm");
                      //   log(loadi.toString(), name: "ini loadi");
                      //   log(cekNa.toString(), name: "ini cekna");
                      //   log(cekNo.toString(), name: "ini cekno");

                      // if (loadi == false && cekNa == true && cekNo == true) {

                      // }
                    },
                    child: buttonDefaulLogin(
                      backGround:
                          !loadi ? yd_Color_Primary : yd_Color_Primary_Grey,
                      textColor: Colors.white,
                      text: !loadi ? "Selanjutnya" : "Menunggu..",
                    ),
                  ),
      ),
    );
  }
}
