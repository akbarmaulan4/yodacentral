import 'package:flutter/material.dart';
import 'package:yodacentral/screens/detail_leads/components/tab_top_detail_leads.dart';

class FormNasabah extends StatefulWidget {
  const FormNasabah(
      {Key? key, required this.namePipeline, required this.id_unit})
      : super(key: key);
  final String namePipeline;
  final int id_unit;

  @override
  _FormNasabahState createState() => _FormNasabahState();
}

class _FormNasabahState extends State<FormNasabah> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.namePipeline,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "#" + widget.id_unit.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
        bottom: PreferredSize(
          child: TabTopDetailLeads(
            index: page,
            menu: [
              "Identitas",
              "Pekerjaan",
              "Dokumen",
            ],
            onClick: (i) {
              setState(() {
                page = i;
              });
            },
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
      ),
      body: PageView(
        children: [],
      ),
    );
  }
}
