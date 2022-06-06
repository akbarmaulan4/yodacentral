import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';

class ResultOTRDefaultScreen extends StatefulWidget {
  const ResultOTRDefaultScreen({Key? key}) : super(key: key);

  @override
  _ResultOTRDefaultScreenState createState() => _ResultOTRDefaultScreenState();
}

class _ResultOTRDefaultScreenState extends State<ResultOTRDefaultScreen> {
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
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 3,
              color: yd_Color_Primary_opacity,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text('Hasil Kalkulator OTR Default', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            ),
            Expanded(child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                    childLabel(),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  childLabel(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Text('No Kartu(Optional)'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text('No Kartu(Optional)'),
            ),
          ),
        ],
      ),
    );
  }
}
