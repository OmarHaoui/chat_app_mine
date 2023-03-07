import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../pages/auth/profile_page.dart';
import '../../pages/chat/chat_page.dart';
import '../../utilities/constants.dart';
import '../../utilities/time_passed.dart';
import '../common/costume_ListTile.dart';

//TODO: In the end of the project hundle the case where there is no internet
class searchStreamBuilder extends StatelessWidget {
  const searchStreamBuilder({
    super.key,
    required this.searchQuery,
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(fireUsers)
              .where(fireName, isGreaterThanOrEqualTo: searchQuery)
              .where(fireName, isLessThan: searchQuery + 'z')
              .snapshots(),
          //TODO: remove myself from the friends list
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return ModalProgressHUD(
                  inAsyncCall: true,
                  color: Colors.transparent,
                  child: SizedBox.shrink(),
                );
              default:
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    // Build a widget fors each search result
                    return chatFriend(document, context);
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  Widget chatFriend(DocumentSnapshot<Object?> document, BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ProfilePage.id,
                arguments: document.id);
          },
          leading: AdvancedAvatar(
            child: Image.network(document[fireImage]),
            size: 56,
          ),
          title: Text(
            document[fireName],
            style: TextStyle(
              fontSize: fontSize - 5,
              fontWeight: FontWeight.bold,
              fontFamily: "Lato",
            ),
          ),
          subtitle: Text(
            document[fireBio],
            style: TextStyle(
              fontSize: fontSize - 5,
              fontFamily: "Lato",
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          dense: false,
          splashColor: kgreyColor,
          focusColor: kgreyColor,
          hoverColor: kgreyColor,
        ),
        Divider(indent: 30, endIndent: 30)
      ],
    );
  }
}
