import 'package:flutter/material.dart';

class NewDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        child: Divider(
          height: 1.0,
          color: Colors.lightGreen.withOpacity(0.5),
          thickness: 1.0,
        ),
      ),
    );
  }
}
