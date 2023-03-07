import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class CostumeBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: fontSize + 18,
          width: fontSize + 18,
          decoration: BoxDecoration(
            color: kprimaryColor.withOpacity(0.30),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kprimaryColor,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          "Back",
          style: TextStyle(
            color: kprimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
