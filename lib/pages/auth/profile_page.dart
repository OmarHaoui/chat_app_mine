import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/utilities/constants.dart';
import '../../services/firestore_service.dart';
import '../../widgets/common/costume_Back_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';
  @override
  Widget build(BuildContext context) {
    String userId = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: kwhiteColor,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: CostumeBackButton(),
          ),
          leadingWidth: 150,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 30,
              color: ktextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder<String>(
          future: FirestoreService().getFirestoreImage(userId),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ModalProgressHUD(
                inAsyncCall: true,
                child: Container(color: kwhiteColor),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String imageUrl = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    AdvancedAvatar(
                      image: NetworkImage(imageUrl),
                      size: 250,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Jhon Doe",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: ktextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Online",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: kblackColor.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "I am a flutter developer",
                      style: TextStyle(
                        fontFamily: "Lato",
                        color: kblackColor.withOpacity(0.6),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
