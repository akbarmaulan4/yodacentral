import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

Widget cardPipeline(
    {int? totalAmount,
    String? section,
    String? position,
    bool? isClose = false}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2, top: 2),
    padding: EdgeInsets.all(yd_defauld_padding),
    color: Colors.transparent,
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isClose!
                ? yd_Color_Primary_Grey.withOpacity(0.5)
                : yd_Color_Primary_opacity,
          ),
          child: Center(
            child: Text(
              totalAmount.toString(),
              style: TextStyle(
                fontSize: 16,
                color: isClose ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: yd_defauld_padding,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section ?? "-",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              position ?? "-",
              style: TextStyle(
                fontSize: 14,
                color: yd_Color_Primary_Grey,
              ),
            )
          ],
        )
      ],
    ),
  );
}
