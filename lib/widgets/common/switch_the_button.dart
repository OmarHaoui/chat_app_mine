import 'package:flutter/material.dart';
import 'package:my_chat_app/utilities/constants.dart';

class ElevationControlButton extends StatefulWidget {
  ElevationControlButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.changableColor,
    required this.isElevated,
    required this.changableTextColor,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onPressed;
  Color changableColor;
  bool isElevated;
  Color changableTextColor;

  @override
  _ElevationControlButtonState createState() => _ElevationControlButtonState();
}

class _ElevationControlButtonState extends State<ElevationControlButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 75,
      minWidth: 220,
      onPressed: widget.onPressed,
      child: widget.child,
      elevation: widget.isElevated ? 8.0 : 0.0,
      color: widget.changableColor,
      textColor: widget.changableTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(textFieldsBorderRadius),
      ),
    );
  }
}
