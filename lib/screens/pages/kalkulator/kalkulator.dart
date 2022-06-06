import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/screens/pages/kalkulator/otr_default_screen.dart';
import 'package:yodacentral/screens/pages/kalkulator/otr_entry_screen.dart';

class Kalkulator extends StatefulWidget {
  const Kalkulator({Key? key}) : super(key: key);

  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.08),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Text(
                  "Kalkulator Kredit Financing & Refinancing",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Icon(Icons.calculate_rounded, size: 150,),
              ),
            ),
            btnKirim(
              backGround: yd_Color_Primary,
              textColor: Colors.white,
              text: 'OTR Default',
              onClick: ()=>Get.to(()=>OTRDetaultScreen())
            ),
            SizedBox(height: 20),
            btnKirim(
                backGround: yd_Color_Primary,
                textColor: Colors.white,
                text: 'OTR Entry',
                onClick: ()=>Get.to(()=>OTREntryScreen())
            ),
            SizedBox(height: size.height * 0.20),
          ],
        ),
      ),
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
}
