import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yodacentral/components/yd_colors.dart';
import 'package:yodacentral/components/yd_size.dart';

class TabTopDetailLeads extends StatefulWidget {
  const TabTopDetailLeads(
      {
        Key? key,
        required this.onClick,
        required this.index,
        this.menu
      })
      : super(key: key);
  final ValueChanged<int> onClick;
  final int index;
  final List<String>? menu;

  @override
  _TabTopDetailLeadsState createState() => _TabTopDetailLeadsState();
}

class _TabTopDetailLeadsState extends State<TabTopDetailLeads> {
  // int page = 0;
  change({int? i}) {
    setState(() {
      widget.onClick(i!);
      // page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(yd_defauld_padding, 10, yd_defauld_padding, 12),
      constraints: const BoxConstraints(maxHeight: 150.0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(color: yd_Color_Primary_Grey.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          widget.menu == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        change(i: 0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.index == 0 ? Color(0xFFD9EDE9) : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              widget.index == 0
                                  ? BoxShadow(
                                      color: yd_Color_Primary_Grey.withOpacity(0.5),
                                      offset: Offset(0, 0.5),
                                      blurRadius: 0.4,
                                    )
                                  : BoxShadow(color: yd_Color_Primary_Grey.withOpacity(0.0),),
                            ]),
                        width: Get.width / 3 - yd_defauld_padding - 5,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Unit",
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
                        decoration: BoxDecoration(
                            color: widget.index == 1 ? Color(0xFFD9EDE9) : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              widget.index == 1
                                  ? BoxShadow(
                                      color: yd_Color_Primary_Grey
                                          .withOpacity(0.5),
                                      offset: Offset(0, 0.5),
                                      blurRadius: 0.4,
                                    )
                                  : BoxShadow(
                                      color: yd_Color_Primary_Grey
                                          .withOpacity(0.0),
                                    ),
                            ]),
                        width: Get.width / 3 - yd_defauld_padding - 5,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Nasabah",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        change(i: 2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.index == 2 ? Color(0xFFD9EDE9) : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              widget.index == 2
                                  ? BoxShadow(
                                      color: yd_Color_Primary_Grey
                                          .withOpacity(0.5),
                                      offset: Offset(0, 0.5),
                                      blurRadius: 0.4,
                                    )
                                  : BoxShadow(
                                      color: yd_Color_Primary_Grey
                                          .withOpacity(0.0),
                                    ),
                            ]),
                        width: Get.width / 3 - yd_defauld_padding - 5,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Kredit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < widget.menu!.length; i++)
                      GestureDetector(
                        onTap: () {
                          change(i: i);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: widget.index == i ? Color(0xFFD9EDE9) : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                widget.index == i ? BoxShadow(color: yd_Color_Primary_Grey.withOpacity(0.5), offset: Offset(0, 0.5), blurRadius: 0.4,)
                                    : BoxShadow(color: yd_Color_Primary_Grey.withOpacity(0.0)),
                              ]
                          ),
                          width: widget.menu!.length > 1 ? (Get.width / widget.menu!.length - yd_defauld_padding - 5):(Get.width / widget.menu!.length - yd_defauld_padding - 18),
                          height: 40,
                          child: Center(
                            child: Text(widget.menu![i], style: TextStyle(fontWeight: FontWeight.bold,),),
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

class TabTopRefinanExternal extends StatefulWidget {
  const TabTopRefinanExternal(
      {Key? key, required this.onClick, required this.index})
      : super(key: key);
  final ValueChanged<int> onClick;
  final int index;

  @override
  _TabTopRefinanExternalState createState() => _TabTopRefinanExternalState();
}

class _TabTopRefinanExternalState extends State<TabTopRefinanExternal> {
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
                      "Unit",
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
                      "Nasabah",
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
