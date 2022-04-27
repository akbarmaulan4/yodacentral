import 'package:flutter/material.dart';
import 'package:yodacentral/screens/add_new_lead/add_new_lead_financing/components/info_seller_mobil/seller_search.dart';

class InfoSellerMobil extends StatefulWidget {
  const InfoSellerMobil({Key? key, required this.isFinancing})
      : super(key: key);
  final bool isFinancing;

  @override
  _InfoSellerMobilState createState() => _InfoSellerMobilState();
}

class _InfoSellerMobilState extends State<InfoSellerMobil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   ele
      // ),
      body: PageView(
        children: [
          SellerSearch(
            isFinancing: widget.isFinancing,
          ),
        ],
      ),
    );
  }
}
