import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../pages/chat/chat_page.dart';
import '../../utilities/constants.dart';
import '../../utilities/time_passed.dart';

//TODO: In the end of the project hundle the case where there is no internet
class FriendsStreamBuilder extends StatelessWidget {
  const FriendsStreamBuilder({
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
              .orderBy('username')
              .orderBy('LatestChatTime', descending: true)
              .snapshots(),
          //TODO Update the createdAt of the friend in the chat page and remove myself from the friends list
          // check if the new field Latest is null
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
                    return chatFriend(document);
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  Container chatFriend(DocumentSnapshot<Object?> document) {
    final latestChat = getLatestChat(document);
    final latestTime = latestChat?["latestTime"];
    String timeString = "";
    timeString = timePassed(latestTime, timeString);
    final latestMessage = latestChat?["latestMessage"] ?? "";

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          AdvancedAvatar(
            image: NetworkImage(document[fireImage]),
            size: 70,
          ),

          Expanded(
            child: ListTile(
              title: Text(
                document[fireName],
                style: TextStyle(
                    fontSize: fontSize - 5, fontWeight: FontWeight.bold),
              ),
              //TODO: Replace bio with the latest message
              //and order friends by last date
              subtitle: Text(
                latestMessage,
                style: TextStyle(fontSize: fontSize - 5),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // TODO: Replace manual time with latest time
          Container(
            padding: EdgeInsets.all(20),
            height: 80,
            child: Text(timeString),
          ),
          IconButton(
              onPressed: () {
                //TODO: Go to the chat page of that guy
              },
              icon: Icon(Icons.arrow_forward_ios_rounded))
        ],
      ),
    );
  }

  Color ditermineStatus(String status) {
    switch (status) {
      case "Online":
        return Colors.green;
      case "Busy":
        return Colors.yellow;
      case "Away":
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  Future<void> firestoreMergeLatestChatTime(docs) async {
    for (final document in docs) {
      await FirebaseFirestore.instance.collection('users').doc(document.id).set(
        {
          fireLatestChatTime: getLatestChat(document)?["latestTime"] ?? null,
        },
        SetOptions(merge: true),
      );
    }
  }

  // Future<void> firestoreMergeLatestChatTimeTemp() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       doc.reference.update({'latestChatTime': null});
  //     });
  //   });
  // }

  Map<String, dynamic>? getLatestChat(document) {
    Map<String, dynamic> latest = {
      "latestMessage": "",
      "latestTime": null,
    };
    if (document[fireMessages].isEmpty) return null;
    latest["latestTime"] =
        DateTime.parse(document[fireMessages][0][fireCreatedAt]);
    latest["latestMessage"] = document[fireMessages][0][fireText];
    for (int i = 1; i < document[fireMessages].length; i++) {
      DateTime messageTime =
          DateTime.parse(document[fireMessages][i][fireCreatedAt]);
      if (messageTime.isAfter(latest["latestTime"])) {
        latest["latestTime"] = messageTime;
        latest["latestMessage"] = document[fireMessages][i][fireText];
      }
    }
    return latest;
  }
}
