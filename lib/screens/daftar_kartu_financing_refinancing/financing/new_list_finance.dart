import 'package:flutter/material.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/utils/utils.dart';

class NewListFinance extends StatefulWidget {
  @override
  _NewListFinanceState createState() => _NewListFinanceState();
}

class _NewListFinanceState extends State<NewListFinance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Financing", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  searchFilter(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(yd_defauld_padding),
        border: Border.all(color: yd_Color_Primary_Grey),
      ),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
