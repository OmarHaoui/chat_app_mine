import 'package:flutter/material.dart';

// Create a primary color to put on the primary swatch
final Color primaryColor = Color(0xFF377DFF);
MaterialColor primarySwatch = MaterialColor(primaryColor.value, <int, Color>{
  50: Color(0xFFE3F0FF),
  100: Color(0xFFB8D4FF),
  200: Color(0xFF8AB8FF),
  300: Color(0xFF5C9CFF),
  400: Color(0xFF3B8BFF),
  500: primaryColor,
  600: Color(0xFF2767FF),
  700: Color(0xFF215CFF),
  800: Color(0xFF1B51FF),
  900: Color(0xFF1240FF),
});

var kprimaryColor = primarySwatch;
var kwhiteColor = Colors.white;
var ktextColor = Color.fromARGB(255, 13, 30, 44);
var kblackColor = Colors.black;
var kgreyColor = Colors.grey;
var khintColor = Colors.grey.shade600;

String currentPassword = "";
String name = "Annette Black";
String logo = "Chatty";

double fontSize = 25;
double textFieldsBorderRadius = 10;
Size size(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return size;
}

String fireUsers = "users";
String fireName = "name";
String fireEmail = "email";
String fireImage = "image";
String fireBio = "bio";
String fireMessages = "messages";
String fireCreatedAt = "createdAt";
String fireText = "text";
String fireLatestChatTime = "latestChatTime";
