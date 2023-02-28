import 'package:flutter/material.dart';

import '../themes.dart';

class defaultButtton extends StatelessWidget {
  defaultButtton({
    required this.onPressed,
    required this.childText,
    required this.width,
    required this.height,
  });
  dynamic Function() onPressed;
  String childText;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        //backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        foregroundColor: MaterialStateProperty.all<Color>(kBlackColor),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Lato",
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: width, vertical: height),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(childText),
    );
  }
}
