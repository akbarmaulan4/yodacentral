import 'package:flutter/material.dart';

Widget textNotif({String? text, bool? isNotEvent}) {
  return Padding(
    padding: EdgeInsets.only(top: isNotEvent! ? 15 : 2.5, bottom: 2.5),
    child: Center(
      child: Text(
        text ?? "-",
        style: TextStyle(
          color: Color(0xFF6F7977),
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget chipDate({String? date}) {
  return Padding(
    padding: const EdgeInsets.all(7.5),
    child: Chip(
      label: Text(date ?? "-",
          style: TextStyle(
            color: Color(0xFF6F7977),
          )),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: Color(0xFFE0E3E3),
      ),
    ),
  );
}
