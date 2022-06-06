import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.items,
    this.index = 0,
    required this.onTap,
    required this.onTapFloat,
    required this.isActiveAdd
  }) : super(key: key);
  final int index;

  final List<BottomNavItem> items;
  final ValueChanged<int> onTap;
  final Function() onTapFloat;
  final int isActiveAdd;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 8,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 30,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              // width: Get.width,
              color: Color(0XFF78BFB1),
              child: Row(children: [
                for (var i = 0; i < widget.items.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.onTap(i);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      width: Get.width / 8,
                      height: Get.width / 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.index == i
                            ? Color(0XFFD9EDE9)
                            : Colors.transparent,
                      ),
                      // child: Icon(widget.items[i].icon, color: widget.index == i ? Color(0XFF78BFB1) : Colors.white),
                      child: Center(
                        child: Stack(
                          children: [
                            Icon(widget.items[i].icon, color: widget.index == i ? Color(0XFF78BFB1) : Colors.white, size: 30,),
                            widget.items[i].showNotif! ? Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                // child: Center(
                                //   child: Text(
                                //     '1',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 8,
                                //     ),
                                //     textAlign: TextAlign.center,
                                //   ),
                                // ),
                              ),
                            ):SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
          widget.isActiveAdd == 2 ? Positioned(
            top: 0,
            right: 15,
            child: Container(
              padding: EdgeInsets.all(10),
              width: Get.width / 5,
              height: Get.width / 5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                backgroundColor: Color(0XFF213555),
                onPressed: widget.onTapFloat,
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ):SizedBox(),
        ],
      ),
    );
  }
}

class BottomNavItem {
  BottomNavItem({required this.icon, this.label, this.showNotif});
  String? label;
  IconData icon;
  bool? showNotif;
}
