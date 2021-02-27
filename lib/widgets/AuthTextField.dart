import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String lableText;
  final String hintText;
  final IconData iconData;
  final TextInputType textInputType;
  final bool isPassword;
  final TextEditingController textEditingController;
  const AuthTextField({
    Key key,
    this.lableText,
    this.iconData,
    this.textInputType,
    this.isPassword = false,
    this.textEditingController,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: lableText,
        labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
        icon: Icon(iconData),
      ),
      style: TextStyle(
        fontSize: 14.0,
      ),
    );
  }
}
