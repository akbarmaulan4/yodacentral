import 'package:flutter/material.dart';

class Kalkulator extends StatefulWidget {
  const Kalkulator({Key? key}) : super(key: key);

  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Kakulator"),
    );
  }
}
