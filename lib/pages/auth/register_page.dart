import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/pages/auth/add_profile_page.dart';
import 'package:my_chat_app/pages/auth/login_page.dart';
import '../../utilities/constants.dart';
import '../../utilities/show_snack_bar.dart';
import '../../widgets/common/costume_text_form_field.dart';
import '../../widgets/common/default_button.dart';
import '../chat/chat_page.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = "";

  String _password = "";

  bool isLoading = false;

  var emailController = new TextEditingController();

  var passwordController = new TextEditingController();

  var confirmePasswordController = new TextEditingController();

  GlobalKey<FormState> _formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 350,
                            height: 140,
                          ),
                          Text(
                            "Create an account",
                            style: TextStyle(
                              color: ktextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
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
                    SizedBox(height: 20),
                    CostumeTextFormField(
                      hintText: "Enter your password",
                      lableText: "Password",
                      obscureText: true,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 20),
                    CostumeTextFormField(
                      hintText: "Enter your password again",
                      lableText: "Confirme Password",
                      obscureText: true,
                      isPassword: true,
                      isConfirmePassword: true,
                      controller: confirmePasswordController,
                    ),
                    SizedBox(height: 100),
                    defaultButtton(
                      childText: "Continue",
                      width: 167,
                      height: 25,
                      onPressed: _SignUp,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Already have an account",
                      style: TextStyle(
                        fontSize: 20,
                        color: ktextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, LoginPage.id),
                      child: Text(
                        "Login",
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

  _SignUp() async {
    if (_formkey.currentState!.validate()) {
      _email = emailController.text;
      _password = passwordController.text;
      isLoading = true;
      setState(() {});
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'email': _email,
          },
          SetOptions(merge: true),
        );
        showSnackBar(context, "Succeded to create a new account");
        Navigator.pushReplacementNamed(context, AddProfilePage.id,
            arguments: userCredential.user!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account for that email already exists.');
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      }
      isLoading = false;
      setState(() {});
    }
  }
}
