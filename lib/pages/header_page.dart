import 'package:flutter/material.dart';
import '../themes.dart';
import '../widgets/default_button.dart';
import 'login_page.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});
  static String id = "header";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log into your account",
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Chat with ease, wherever you are.",
                    style: TextStyle(fontSize: 40, color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/login.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Spacer(flex: 2),
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Colors.grey,
            ),
          ),
          Spacer(flex: 3),
          defaultButtton(
            childText: "Next",
            width: 200,
            height: 20,
            onPressed: () => Navigator.pushNamed(context, LoginPage.id),
          ),
          Spacer(),
          Text(
            "Terms & Conditions.",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Spacer(flex: 3)
        ],
      ),
    ));
  }
}
