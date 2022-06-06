import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_text_style.dart';
import 'package:yodacentral/controller/kalkulator/kalkulator_controller.dart';
import 'package:yodacentral/models/kalkulator/otr_entry_model.dart';

class ResultOTREntryScreen extends StatefulWidget {
  ModelOTREntry? data;
  ResultOTREntryScreen({
    this.data
  });

  @override
  _ResultOTREntryScreenState createState() => _ResultOTREntryScreenState();
}

class _ResultOTREntryScreenState extends State<ResultOTREntryScreen> {
  KalkulatorController controller = KalkulatorController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initResultOTREntry(widget.data!);
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
              child: Row(
                children: [
                  Icon(Icons.download, color: yd_Color_Primary),
                  SizedBox(width: 8),
                  Text('Unduh', style: TextStyle(fontWeight: FontWeight.w600, color: yd_Color_Primary),),
                ],
              )
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
              child: Text('Hasil Kalkulator OTR Entry', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Expanded(child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    childLabel('DP', 'Rp. ${numberFor.format(double.parse(widget.data!.dp_value))} (${widget.data!.dp_percent}%)'),
                    childLabel('PH', 'Rp. ${numberFor.format(double.parse(widget.data!.ph_value))} (${widget.data!.ph_percent}%)'),
                    childLabel('Premi Asuransi', 'Rp. ${numberFor.format(double.parse(widget.data!.premi_insurance))}'),
                    childLabel('Bunga', 'Rp. ${numberFor.format(double.parse(widget.data!.anuity_value))} (${widget.data!.anuity_percent.substring(0, 4)}%)'),
                    childLabel('Pokok + Bunga', 'Rp. ${numberFor.format(double.parse(widget.data!.total_payment))}'),
                    childLabel('Jangka Waktu', 'Rp. ${widget.data!.duration_year} Tahun (${widget.data!.duration_month} Bulan)'),
                    childLabel('Angsuran', 'Rp. ${numberFor.format(double.parse(widget.data!.termin_value))}'),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Text('Biaya-biaya', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),)
                    ),
                    childLabel('Administrasi', 'Rp. ${ numberFor.format(double.parse(widget.data!.administration))}'),
                    childLabel('Angsuran 1', 'Rp. ${numberFor.format(double.parse(widget.data!.termin_one))}'),
                    childLabel('Provisi', 'Rp. ${numberFor.format(double.parse(widget.data!.provisi))}'),
                    childLabel('Total Potongan', 'Rp. ${numberFor.format(double.parse(widget.data!.total_add_expense))}'),
                    childLabel('Total Dana Cair', 'Rp. ${numberFor.format(double.parse(widget.data!.total_income))}'),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Text('Insentif', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),)
                    ),
                    refundFlat(controller.strRefundFlatPercent.value, controller.strRefundFlatValue.value),
                    SizedBox(height: 15),
                    refundAdm(controller.strRefundAdmPercent.value, controller.strRefundAdmValue.value),
                    SizedBox(height: 20),
                    childLabel('Total Refund', 'Rp. ${controller.strTotalRefund.value}'),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }

  childLabel(String label, String value){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(label),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(value, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  refundFlat(String percent, String value){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refund Flat (%)', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('${percent} %', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            InkWell(
                                onTap:()=>controller.addRefundFlatPercent(context, widget.data!, controller.strRefundFlatPercent.value),
                                child: Icon(Icons.arrow_drop_up_rounded, size: 40)
                            ),
                            InkWell(
                                onTap:()=>controller.decRefundFlatPercent(context, widget.data!, controller.strRefundFlatPercent.value),
                                child: Icon(Icons.arrow_drop_down_rounded, size: 40)
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refund Flat (Rp)', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Rp. ${value}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.arrow_drop_up_rounded, size: 40, color: Colors.transparent,),
                            Icon(Icons.arrow_drop_down_rounded, size: 40, color: Colors.transparent)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  refundAdm(String percent, String value){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refund Adm (%)', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('${percent} %', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            InkWell(
                                onTap:()=>controller.addRefundAdmPercent(context, widget.data!,controller.strRefundAdmPercent.value),
                                child: Icon(Icons.arrow_drop_up_rounded, size: 40)
                            ),
                            InkWell(
                                onTap:()=>controller.decRefundAdmPercent(context, widget.data!, controller.strRefundAdmPercent.value),
                                child: Icon(Icons.arrow_drop_down_rounded, size: 40)
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refund Adm (Rp)', style: TextStyle(fontSize: 13, color: Colors.grey.shade500),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Rp. ${value}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.arrow_drop_up_rounded, size: 40, color: Colors.transparent,),
                            Icon(Icons.arrow_drop_down_rounded, size: 40, color: Colors.transparent)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
