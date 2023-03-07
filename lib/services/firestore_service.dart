import 'package:cloud_firestore/cloud_firestore.dart';

import '../utilities/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Get an image from the Firestore
  Future<String> getFirestoreImage(String uid) async {
    // Get the doocument's fields as a map of string dynamic
    DocumentSnapshot<Map<String, dynamic>> variable =
        await _firestore.collection('users').doc(uid).get();
    String imageUrl = variable[fireImage];
    return imageUrl;
  }

  // Add a new contact to a user's contacts subcollection
  Future<void> addContact(String userId, String contactId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .doc(contactId)
          .set({});
    } catch (e) {
      print('Error adding contact: $e');
    }
  }

  // Remove a contact from a user's contacts subcollection
  Future<void> removeContact(String userId, String contactId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .doc(contactId)
          .delete();
    } catch (e) {
      print('Error removing contact: $e');
    }
  }

  // Create a new chat document and add it to the chats collection
  Future<String?> createChat(List<String> participantIds) async {
    try {
      final docRef = await _firestore.collection('chats').add({
        'participants': participantIds,
        'lastMessage': null,
      });
      return docRef.id;
    } catch (e) {
      print('Error creating chat: $e');
      return null;
    }
  }

  // Send a message and add it to a chat's messages subcollection
  Future<void> sendMessage(
      String chatId, String senderId, String messageContent) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'sender': senderId,
        'content': messageContent,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': {
          'sender': senderId,
          'content': messageContent,
          'timestamp': FieldValue.serverTimestamp(),
        },
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
