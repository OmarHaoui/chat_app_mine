import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/login_page.dart';
import '../themes.dart';
import '../utilities/show_snack_bar.dart';
import '../widgets/costume_text_form_field.dart';
import '../widgets/default_button.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'register';
  String _email = "";
  String _password = "";
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var confirmePasswordController = new TextEditingController();
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
                        "Hi, kindly fill in the form to continue...",
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
                SizedBox(height: 5),
                CostumeTextFormField(
                  hintText: "Enter your password again",
                  lableText: "Confirme Password",
                  obscureText: true,
                  isPassword: true,
                  isConfirmePassword: true,
                  controller: confirmePasswordController,
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
                  "Already have an account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, LoginPage.id),
                  child: Text(
                    "Login",
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
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        showSnackBar(context, "Succeded to create a new account");
        Navigator.pushNamed(context, ChatPage.id);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account for that email already exists.');
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
