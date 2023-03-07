import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'pages/auth/add_profile_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/profile_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/chat/chat_list_page.dart';
import 'pages/chat/chat_page.dart';
import 'pages/chat/search_page.dart';
import 'pages/home/header_page.dart';
import 'pages/home/splash_page.dart';
import 'services/munipulating_dummy_data_service.dart';
import 'utilities/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger',
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch),
        canvasColor: kwhiteColor,
      ),
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => SplashPage(),
        HeaderPage.id: (context) => HeaderPage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        AddProfilePage.id: (context) => AddProfilePage(),
        ChatListPage.id: (context) => ChatListPage(),
        SearchPage.id: (context) => SearchPage(),
        ProfilePage.id: (context) => ProfilePage(),
        ChatPage.id: (context) => ChatPage(),
        Uploader.id: (context) => Uploader(),
      },
    );
  }
}
