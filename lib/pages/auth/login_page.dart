import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/auth/register_page.dart';
import 'package:my_chat_app/pages/chat/chat_list_page.dart';
import 'package:my_chat_app/utilities/show_snack_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../utilities/constants.dart';
import '../../widgets/common/costume_text_form_field.dart';
import '../../widgets/common/default_button.dart';
import '../chat/chat_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";

  String _password = "";

  bool isLoading = false;

  var emailController = new TextEditingController();

  var passwordController = new TextEditingController();

  GlobalKey<FormState> _formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kwhiteColor,
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 350,
                            height: 140,
                          ),
                          Text(
                            "Sign in to continue ...",
                            style: TextStyle(
                                color: ktextColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80),
                    CostumeTextFormField(
                      hintText: "Enter your email address",
                      lableText: "Email",
                      isPassword: false,
                      controller: emailController,
                    ),
                    SizedBox(height: 30),
                    CostumeTextFormField(
                      hintText: "Enter your password",
                      lableText: "Password",
                      obscureText: true,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    Container(
                      width: size(context).width - 60,
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          //TODO: make the reset password function
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: ktextColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 150),
                    defaultButtton(
                      childText: "Let's chat!",
                      width: 162,
                      height: 25,
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _email = emailController.text;
                          _password = passwordController.text;
                          isLoading = true;
                          setState(() {});
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email, password: _password);
                            showSnackBar(context, 'Successfully signed in');
                            Navigator.pushReplacementNamed(
                                context, ChatListPage.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,
                                  'Wrong password provided for that user.');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Don't have an account",
                      style: TextStyle(
                        fontSize: 20,
                        color: ktextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterPage.id);
                      },
                      child: Text(
                        "Sign up here",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
