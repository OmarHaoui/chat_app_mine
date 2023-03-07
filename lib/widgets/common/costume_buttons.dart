import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utilities/constants.dart';
import 'switch_the_button.dart';

class CostumeButtons extends StatefulWidget {
  CostumeButtons({
    required this.leftButtonOnPressed,
    required this.rightButtonOnPressed,
  });
  VoidCallback rightButtonOnPressed;
  VoidCallback leftButtonOnPressed;
  @override
  State<CostumeButtons> createState() => _CostumeButtonsState();
}

class _CostumeButtonsState extends State<CostumeButtons> {
  Color leftButtonBackground = Colors.white;
  Color rightButtonBackground = Colors.transparent;
  Color leftButtonForeground = Colors.black;
  Color rightButtonForeground = Colors.grey;
  bool isLeftButtonElevated = true;
  bool isRightButtonElevated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 470,
      decoration: BoxDecoration(
          color: kgreyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(textFieldsBorderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevationControlButton(
              child: Text(
                "Chat",
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                setState(() {
                  leftButtonBackground = Colors.white;
                  leftButtonForeground = Colors.black;
                  isLeftButtonElevated = true;
                  isRightButtonElevated = false;
                  rightButtonBackground = Colors.transparent;
                  rightButtonForeground = Colors.grey;
                });
                widget.leftButtonOnPressed();
              },
              changableColor: leftButtonBackground,
              changableTextColor: leftButtonForeground,
              isElevated: isLeftButtonElevated,
            ),
            ElevationControlButton(
              child: Text(
                "Call",
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                setState(() {
                  rightButtonBackground = Colors.white;
                  rightButtonForeground = Colors.black;
                  isRightButtonElevated = true;
                  isLeftButtonElevated = false;
                  leftButtonBackground = Colors.transparent;
                  leftButtonForeground = Colors.grey;
                });
                widget.rightButtonOnPressed();
              },
              changableColor: rightButtonBackground,
              changableTextColor: rightButtonForeground,
              isElevated: isRightButtonElevated,
            )
          ],
        ),
      ),
    );
  }
}
