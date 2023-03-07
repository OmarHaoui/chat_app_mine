import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:my_chat_app/pages/chat/search_page.dart';
import 'package:my_chat_app/utilities/constants.dart';

import '../../widgets/chat/friends_stream_builder.dart';
import '../../widgets/common/costume_buttons.dart';
import '../../widgets/chat/search_stream_builder.dart';
import '../../services/firestore_service.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});
  static String id = "chatList";

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  bool isSearchBarVisible = false;

  String searchQuery = "";

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    //current user id
    final _userID = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedAvatar(
                    image: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                    size: 70,
                    // TODO:make the status color changes according to the user status
                    statusColor: Colors.green,
                    statusSize: 22,
                    statusAngle: 130,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.id);
                    },
                    icon: Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            CostumeButtons(
              leftButtonOnPressed: () {
                //TODO Chow the chat list
              },
              rightButtonOnPressed: () {
                //TODO Chow the call list
              },
            ),
            //FriendsStreamBuilder(searchQuery: searchQuery)
          ],
        ),
      ),
    );
  }
}
