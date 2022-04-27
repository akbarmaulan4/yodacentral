import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';
import 'package:yodacentral/controller/controller_Lead_count/controller_lead_count.dart';
import 'package:yodacentral/screens/omnisearch/omnisearch.dart';

Widget cardTop(BuildContext context) {
  return GetBuilder<ControllerLeadCount>(builder: (val) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: yd_defauld_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: yd_defauld_padding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => Omisearch());
                  // Get.bottomSheet(
                  //   Omisearch(),
                  //   isScrollControlled: true,
                  //   ignoreSafeArea: true,
                  // );
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => Omisearch(),
                    isScrollControlled: true,
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: yd_defauld_padding * 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 21, horizontal: 24),
            width: Get.width,
            height: 135,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: yd_Color_Primary_Grey.withOpacity(0.5),
                    offset: Offset(0, -0.5),
                    blurRadius: 0.4,
                  ),
                  BoxShadow(
                    color: yd_Color_Primary_Grey.withOpacity(0.5),
                    offset: Offset(1, 2),
                    blurRadius: 0.4,
                  ),
                  BoxShadow(
                    color: yd_Color_Primary_Grey.withOpacity(0.5),
                    offset: Offset(-1, 0),
                    blurRadius: 0.4,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Open",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Unit dalam proses",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: yd_Color_Primary_Grey,
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          val.loadCount
                              ? "--"
                              : val.modelLeadCount!.count!.open.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          " Unit",
                          style: TextStyle(
                            fontSize: 10,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // SizedBox(
                //   height: yd_defauld_padding * 2,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Closed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Win & Loses",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: yd_Color_Primary_Grey,
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          val.loadCount
                              ? "--"
                              : val.modelLeadCount!.count!.close.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          " Unit",
                          style: TextStyle(
                            fontSize: 10,
                            color: yd_Color_Primary_Grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}
