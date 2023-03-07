import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/utilities/constants.dart';

import 'package:my_chat_app/widgets/common/default_button.dart';

import 'generate_data_service.dart';

class Uploader extends StatefulWidget {
  const Uploader({super.key});
  static String id = 'uploaded';
  @override
  State<Uploader> createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload page"),
        ),
        body: Center(
          child: defaultButtton(
            onPressed: () async {
              isLoading = true;
              setState(() {});
              // Uncomment the following to upload the 100 user
              // await signUpAndUploadUsersDataToFirestore(users);

              // Uncomment the following to delete all the users
              await signInThenDeleteAllUsers();
              isLoading = false;
              setState(() {});
            },
            childText: "uplaod",
            width: 200,
            height: 100,
          ),
        ),
      ),
    );
  }
}
