import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/message.dart';
import '../models/user.dart' as mine;
import '../utilities/constants.dart';

// generate messages wit faker package
List<Message> generateMessages() {
  final faker = Faker();
  final messages = <Message>[];

  for (var i = 0; i < Random().nextInt(100); i++) {
    final text = faker.lorem.sentence();
    final createdAt = faker.date.dateTimeBetween(
      DateTime.now().subtract(Duration(days: 30)),
      DateTime.now(),
    );
    final message = Message(text: text, createdAt: createdAt);
    messages.add(message);
  }

  return messages;
}

// generate users wit faker package
List<mine.User> generateUsers() {
  var faker = Faker();
  final users = <mine.User>[];

  for (var i = 0; i < 100; i++) {
    final username = faker.internet.userName();
    final bio = faker.lorem.sentences(2).join(' ');
    final email = "omarhaoui$i@gmail.com";
    final image =
        "https://firebasestorage.googleapis.com/v0/b/chat-app-6e847.appspot.com/o/camera-g5e0ebd293_1280.png?alt=media&token=c7f3d2a4-63d0-4958-8f02-f1fbf0dd23d2";
    final status = ['Online', 'Away', 'Busy'].elementAt(Random().nextInt(3));
    final messages = generateMessages();
    final password = "123456789";
    final user = mine.User(
      username: username,
      bio: bio,
      email: email,
      image: image,
      status: status,
      messages: messages,
      password: password,
    );
    users.add(user);
  }

  return users;
}

// upload the created users to firebase
Future<void> signUpAndUploadUsersDataToFirestore(List<mine.User> users) async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();
  UserCredential? userCredential;
  final users = generateUsers();
  for (mine.User user in users) {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } catch (e) {
      print("${e.toString()}");
    }
    final userRef =
        firestore.collection('users').doc(userCredential!.user!.uid);
    batch.set(userRef, {
      'username': user.username,
      'bio': user.bio,
      'email': user.email,
      'image': user.image,
      'status': user.status,
      'messages': user.messages
          .map((message) => {
                'text': message.text,
                'createdAt': message.createdAt.toIso8601String(),
              })
          .toList(),
    });
  }

  await batch.commit();
}

final FirebaseAuth auth = FirebaseAuth.instance;

// delete all users in condition of having their passwords
// if you don't have their emils use cli firebase to get them with uids
Future<void> signInThenDeleteAllUsers() async {
  for (String email in emails) {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: "123456789",
      );
      print("Signed in user with email: ${email}");
      await auth.currentUser!.delete();
      print("Deleted user with email: ${email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("User with email $email not found");
      } else if (e.code == 'wrong-password') {
        print("Incorrect password for user with email $email");
      } else {
        print("Error signing in user with UID $email: ${e.message}");
      }
    } catch (e) {
      print("Error signing in user with UID $email: $e");
    }
  }
}

List<String> emails = [
  "omarhaoui41@gmail.com",
  "omarhaoui9@gmail.com",
  "omarhaoui87@gmail.com",
  "omarhaoui51@gmail.com",
  "omarhaoui20@gmail.com",
  "omarhaoui18@gmail.com",
  "omarhaoui30@gmail.com",
  "omarhaoui63@gmail.com",
  "omarhaoui22@gmail.com",
  "omarhaoui42@gmail.com",
  "omarhaoui92@gmail.com",
  "omarhaoui57@gmail.com",
  "omarhaoui91@gmail.com",
  "omarhaoui97@gmail.com",
  "omarhaoui47@gmail.com",
  "omarhaoui81@gmail.com",
  "omarhaoui44@gmail.com",
  "omarhaoui38@gmail.com",
  "omarhaoui89@gmail.com",
  "omarhaoui60@gmail.com",
  "omarhaoui85@gmail.com",
  "omarhaoui56@gmail.com",
  "omarhaoui24@gmail.com",
  "omarhaoui12@gmail.com",
  "omarhaoui4@gmail.com",
  "omarhaoui77@gmail.com",
  "omarhaoui71@gmail.com",
  "omarhaoui75@gmail.com",
  "omarhaoui62@gmail.com",
  "omarhaoui6@gmail.com",
  "omarhaoui1@gmail.com",
  "omarhaoui45@gmail.com",
  "omarhaoui55@gmail.com",
  "omarhaoui5@gmail.com",
  "omarhaoui73@gmail.com",
  "omarhaoui29@gmail.com",
  "omarhaoui10@gmail.com",
  "omarhaoui46@gmail.com",
  "omarhaoui36@gmail.com",
  "omarhaoui40@gmail.com",
  "omarhaoui82@gmail.com",
  "omarhaoui3@gmail.com",
  "omarhaoui72@gmail.com",
  "omarhaoui88@gmail.com",
  "omarhaoui59@gmail.com",
  "omarhaoui43@gmail.com",
  "omarhaoui11@gmail.com",
  "omarhaoui76@gmail.com",
  "omarhaoui96@gmail.com",
  "omarhaoui28@gmail.com",
  "omarhaoui68@gmail.com",
  "omarhaoui37@gmail.com",
  "omarhaoui2@gmail.com",
  "omarhaoui69@gmail.com",
  "omarhaoui66@gmail.com",
  "omarhaoui79@gmail.com",
  "omarhaoui0@gmail.com",
  "omarhaoui19@gmail.com",
  "omarhaoui99@gmail.com",
  "omarhaoui49@gmail.com",
  "omarhaoui64@gmail.com",
  "omarhaoui25@gmail.com",
  "omarhaoui39@gmail.com",
  "omarhaoui80@gmail.com",
  "omarhaoui70@gmail.com",
  "omarhaoui32@gmail.com",
  "omarhaoui26@gmail.com",
  "omarhaoui31@gmail.com",
  "omarhaoui90@gmail.com",
  "omarhaoui16@gmail.com",
  "omarhaoui61@gmail.com",
  "omarhaoui74@gmail.com",
  "omarhaoui27@gmail.com",
  "omarhaoui13@gmail.com",
  "omarhaoui84@gmail.com",
  "omarhaoui78@gmail.com",
  "omarhaoui94@gmail.com",
  "omarhaoui98@gmail.com",
  "omarhaoui58@gmail.com",
  "omarhaoui95@gmail.com",
  "omarhaoui67@gmail.com",
  "omarhaoui65@gmail.com",
  "omarhaoui93@gmail.com",
  "omarhaoui53@gmail.com",
  "omarhaoui33@gmail.com",
  "omarhaoui21@gmail.com",
  "omarhaoui83@gmail.com",
  "omarhaoui48@gmail.com",
  "omarhaoui8@gmail.com",
  "omarhaoui14@gmail.com",
  "omarhaoui17@gmail.com",
  "omarhaoui7@gmail.com",
  "omarhaoui86@gmail.com",
  "omarhaoui35@gmail.com",
  "omarhaoui15@gmail.com",
  "omarhaoui34@gmail.com",
  "omarhaoui54@gmail.com",
  "omarhaoui23@gmail.com",
  "omarhaoui50@gmail.com",
  "omarhaoui52@gmail.com",
];

// Future<void> getMapUidEmail() async {
//   final firestore = FirebaseFirestore.instance
//   for (var email in emails) {
//     final docSnapshot = await firestore.collection('users').doc(uid).get();
//     if (docSnapshot.exists) {
//       final data = docSnapshot.data();
//       // Update the map value with Firestore data
//       emails[] = data![fireEmail];
//     }
//   }
//   print(emails); // Print the updated map
// }
