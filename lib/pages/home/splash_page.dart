import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_chat_app/pages/home/header_page.dart';

import '../../utilities/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String id = "splash";
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 5),
      () => Navigator.pushReplacementNamed(context, HeaderPage.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/splashedLogo.png",
          width: size(context).width - 80,
        ),
      ),
    );
  }
}
