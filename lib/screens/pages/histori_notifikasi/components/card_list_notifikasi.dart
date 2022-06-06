import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/models/model_dummy_pipeline/model_dummy_pipeline.dart';
import 'package:yodacentral/models/model_save_root.dart';
import 'package:yodacentral/save_root/save_root.dart';
import 'package:yodacentral/screens/chat/chat.dart';
import 'package:yodacentral/screens/detail_leads/detail_leads.dart';

class CardListNotifilasi extends StatefulWidget {
  const CardListNotifilasi({
    Key? key,
    this.name,
    this.date,
    this.content,
    this.seen,
    this.nama_unit,
    this.unit_id,
    this.lead_id,
    required this.category,
  }) : super(key: key);
  final String? name;
  final String? date;
  final String? content;
  final bool? seen;
  final String? nama_unit;
  final int? unit_id;
  final int? lead_id;
  final String category;

  @override
  _CardListNotifilasiState createState() => _CardListNotifilasiState();
}

class _CardListNotifilasiState extends State<CardListNotifilasi> {
  bool? seen = true;

  @override
  void initState() {
    super.initState();
    seen = widget.seen;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
      focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
      splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
      highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
      onTap: () async {
        if (widget.category == "chat") {
          ModelSaveRoot value = await SaveRoot.callSaveRoot();
          if(value.userData!.role == 'Marketing Officer' || value.userData!.role == 'Credit Officer' || value.userData!.role == 'Marketing Head'){
            Get.to(
                  () => Chat(
                nameCar: widget.nama_unit!,
                namePipeline: financing.where((element) => element.id == widget.lead_id!).isEmpty
                    ? '' //refinancing.where((element) => element.id == widget.lead_id!).first.title
                    : '', //financing.where((element) => element.id == widget.lead_id!).first.title,
                pipeline: widget.lead_id!,
                id_unit: widget.unit_id!,
                lead_id: widget.lead_id!,
              ),
            );
          }

        } else if (widget.category == "financing") {
          Get.to(
            () => DetailLeads(
              lead_id: widget.lead_id!,
              unitForSeller: widget.unit_id!,
              unit_id: widget.unit_id!,
              namePipeline: '', //financing.where((element) => element.id == widget.lead_id!).first.title,
              nameCar: widget.nama_unit!,
              isFinancing: true,
              idPipeline: widget.lead_id!,
              onBack: (){},
            ),
          );
        } else if (widget.category == "refinancing") {
          Get.to(
            () => DetailLeads(
              unitForSeller: widget.unit_id!,
              lead_id: widget.lead_id!,
              unit_id: widget.unit_id!,
              namePipeline: '', //refinancing.where((element) => element.id == widget.lead_id!).first.title,
              nameCar: widget.nama_unit!,
              isFinancing: false,
              idPipeline: widget.lead_id!,
              onBack: (){},
            ),
          );
        }

        log(widget.category.toString(), name: "ini kategori");
        // true == sudah dilihat
        if (seen!) {
          setState(() {
            seen = true;
          });
        } else {
          setState(() {
            seen = true;
          });
        }

        log("ini card notifilasi");
      },
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(yd_defauld_padding / 2),
        child: Container(
          padding: EdgeInsets.all(yd_defauld_padding / 2),
          width: Get.width,
          decoration: BoxDecoration(
            color: seen! ? Colors.transparent : yd_surface_barrier,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.name ?? "-"),
                  Text(widget.date!, style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(height: 8),
              Text(widget.nama_unit ?? "-", style: TextStyle(fontWeight: FontWeight.bold,)),
              SizedBox(height: 8),
              Text(widget.content!, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardListNotifilasi({
  String? name,
  String? date,
  String? content,
  bool? seen = false,
  int? lead,
  required int lead_id,
}) {
  return InkWell(
    hoverColor: yd_Color_Primary_Grey.withOpacity(0.3),
    focusColor: yd_Color_Primary_Grey.withOpacity(0.3),
    splashColor: yd_Color_Primary_Grey.withOpacity(0.3),
    highlightColor: yd_Color_Primary_Grey.withOpacity(0.3),
    onTap: () {
      log("ini card notifilasi");
      Get.to(
        () => DetailLeads(
          unitForSeller: lead_id,
          lead_id: lead_id,
          unit_id: lead!,
          namePipeline: "[Unit Listing]",
          nameCar: "Suzuki Cary",
          isFinancing: false,
          idPipeline: 1,
          onBack: (){},
        ),
      );
    },
    child: Container(
      width: Get.width,
      padding: EdgeInsets.all(yd_defauld_padding / 2),
      child: Container(
        padding: EdgeInsets.all(yd_defauld_padding / 2),
        width: Get.width,
        decoration: BoxDecoration(
          color: yd_surface_barrier,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Budi Gunadi"),
                Text(
                  date!,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Suzuki Carry Colt Fe 2019",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              content!,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}
