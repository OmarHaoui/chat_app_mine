import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/register_page.dart';
import 'package:my_chat_app/utilities/show_snack_bar.dart';

import '../themes.dart';
import '../widgets/costume_text_form_field.dart';
import '../widgets/default_button.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  static String id = 'login';
  String _email = "";
  String _password = "";
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  GlobalKey<FormState> _formkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Hi, kindly login to continue...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                CostumeTextFormField(
                  hintText: "Enter your email address",
                  lableText: "Email",
                  isPassword: false,
                  controller: emailController,
                ),
                SizedBox(height: 5),
                CostumeTextFormField(
                  hintText: "Enter your password",
                  lableText: "Password",
                  obscureText: true,
                  isPassword: true,
                  controller: passwordController,
                ),
                SizedBox(height: 50),
                defaultButtton(
                  childText: "Let's chat!",
                  width: 100,
                  height: 15,
                  onPressed: () => submitForm(context),
                ),
                SizedBox(height: 20),
                Text(
                  "Don't have an account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      _email = emailController.text;
      _password = passwordController.text;
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        showSnackBar(context, 'Successfully signed in');
        Navigator.pushNamed(context, ChatPage.id);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, 'Wrong password provided for that user.');
        }
      }
    }
  }
}
