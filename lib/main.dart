import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat_app/pages/register_page.dart';
import 'firebase_options.dart';
import 'pages/chat_page.dart';
import 'pages/header_page.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger',
      theme: ThemeData(
        fontFamily: "Lato",
        primarySwatch: Colors.amber,
      ),
      initialRoute: HeaderPage.id,
      routes: {
        HeaderPage.id: (context) => HeaderPage(),
        LoginPage.id: (context) => LoginPage(),
        ChatPage.id: (context) => ChatPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
    );
  }
}
