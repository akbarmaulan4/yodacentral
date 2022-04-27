import 'package:flutter/material.dart';
import 'package:yodacentral/components/yd_colors.dart';

class ComponentsTextFieldLogin extends StatefulWidget {
  const ComponentsTextFieldLogin({
    Key? key,
    required this.label,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  @override
  _ComponentsTextFieldLoginState createState() =>
      _ComponentsTextFieldLoginState();
}

class _ComponentsTextFieldLoginState extends State<ComponentsTextFieldLogin> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.focusNode!.hasFocus
              ? yd_Color_Primary
              : yd_Color_Primary_Grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary_Grey, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: yd_Color_Primary, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      obscureText: widget.label == "Password" ? true : false,
    );
  }
}
