import 'package:flutter/material.dart';
import 'package:my_chat_app/utilities/constants.dart';

class CostumeTextFormField extends StatefulWidget {
  CostumeTextFormField({
    required this.hintText,
    required this.lableText,
    required this.controller,
    required this.isPassword,
    this.obscureText = false,
    this.isConfirmePassword = false,
  });
  String hintText;
  String lableText;
  bool isPassword;
  bool obscureText;
  bool isConfirmePassword;
  TextEditingController controller;

  @override
  State<CostumeTextFormField> createState() => _CostumeTextFormFieldState();
}

class _CostumeTextFormFieldState extends State<CostumeTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (value) {
          if (widget.isPassword && !widget.isConfirmePassword) {
            currentPassword = value;
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 22),
          contentPadding: EdgeInsets.symmetric(vertical: 27, horizontal: 20),
          //label: Text(widget.lableText, style: TextStyle(fontSize: 20)),
          alignLabelWithHint: true,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: Icon(
                    widget.obscureText
                        ? Icons.circle_rounded
                        : Icons.circle_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                )
              : null,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: kprimaryColor),
            borderRadius: BorderRadius.circular(textFieldsBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kgreyColor),
            borderRadius: BorderRadius.circular(textFieldsBorderRadius),
          ),
        ),
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: TextStyle(fontSize: 22),
        validator: (value) {
          if (widget.isPassword) {
            if (widget.isConfirmePassword) {
              return validateConfirmePassword(value, currentPassword);
            } else {
              return validatePassword(value);
            }
          } else {
            return validateEmail(value);
          }
        });
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }

    final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format.';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    return null;
  }

  String? validateConfirmePassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password again.';
    }
    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
}
