import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String hintText;
  final bool obscureText;

  const CustomTextfieldWidget({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<CustomTextfieldWidget> createState() => _CustomTextfieldWidgetState();
}

class _CustomTextfieldWidgetState extends State<CustomTextfieldWidget> {
  Color _hintColor = lineColor;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() => _hintColor = hasFocus ? ancientColor : lineColor);
      },
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.hintText,
          hintText: 'Введите ${widget.hintText.toLowerCase()}',
          prefixIcon: widget.prefixIcon,
          hintStyle: TextStyle(color: _hintColor),
        ),
      ),
    );
  }
}
