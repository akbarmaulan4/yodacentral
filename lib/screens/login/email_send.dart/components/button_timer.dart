// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:yodacentral/components/yd_colors.dart';
// import 'package:intl/intl.dart';

// // Widget buttonTimer(
// //     {required Color backGround,
// //     required Color textColor,
// //     required String text}) {
// //   return Container(
// //     margin: EdgeInsets.symmetric(horizontal: 50),
// //     padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
// //     width: Get.width,
// //     decoration: BoxDecoration(
// //       color: backGround,
// //       borderRadius: BorderRadius.circular(30),
// //     ),
// //     child: Center(
// //       child: Text(
// //         text,
// //         style: TextStyle(
// //           fontWeight: FontWeight.bold,
// //           color: textColor,
// //         ),
// //       ),
// //     ),
// //   );
// // }

// class ButtonTimer extends StatefulWidget {
//   const ButtonTimer({Key? key}) : super(key: key);

//   @override
//   _ButtonTimerState createState() => _ButtonTimerState();
// }

// class _ButtonTimerState extends State<ButtonTimer> {
//   Timer? _timer;
//   int _start = 120;

//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 50),
//       padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
//       width: Get.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(
//           color: _start == 0
//               ? yd_Color_Primary
//               : yd_Color_Primary_Grey.withOpacity(0.5),
//         ),
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             _start == 0
//                 ? GestureDetector(
//                     onTap: () {
//                       // setState(() {
//                       //   _start = 120;
//                       //   startTimer();
//                       // });
//                     },
//                     child: Text(
//                       "Kirim ulang",

//                       // "",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: yd_Color_Primary,
//                       ),
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: () {
//                       // setState(() {
//                       //   _start = 120;
//                       //   startTimer();
//                       // });
//                     },
//                     child: Text(
//                       "Kirim ulang " +
//                           " " +
//                           DateFormat('(mm:ss)').format(DateTime(
//                             0,
//                             0,
//                             0,
//                             0,
//                             0,
//                             _start,
//                           )),
//                       // "",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: yd_Color_Primary_Grey.withOpacity(0.5),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
