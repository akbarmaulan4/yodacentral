import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

class TabTop extends StatefulWidget {
  const TabTop({Key? key, required this.onClick, required this.index})
      : super(key: key);
  final ValueChanged<int> onClick;
  final int index;

  @override
  _TabTopState createState() => _TabTopState();
}

class _TabTopState extends State<TabTop> {
  int page = 0;

  change({int? i}) {
    setState(() {
      widget.onClick(i!);
      page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(yd_defauld_padding, 10, yd_defauld_padding, 12),
      constraints: const BoxConstraints(maxHeight: 150.0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: yd_Color_Primary_Grey.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: page == 0 ? 0 : null,
            right: page == 1 ? 0 : null,
            duration: Duration(
              milliseconds: 100,
            ),
            child: Container(
              width: Get.width / 2 - yd_defauld_padding,
              decoration: BoxDecoration(
                  color: Color(0xFFD9EDE9),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: yd_Color_Primary_Grey.withOpacity(0.5),
                      offset: Offset(0, 0.5),
                      blurRadius: 0.4,
                    ),
                  ]),
              height: 40,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  change(i: 0);
                },
                child: Container(
                  color: Colors.green.withOpacity(0.0),
                  width: Get.width / 2 - yd_defauld_padding - 5,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Financing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  change(i: 1);
                },
                child: Container(
                  color: Colors.green.withOpacity(0.0),
                  width: Get.width / 2 - yd_defauld_padding - 5,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Refinancing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
