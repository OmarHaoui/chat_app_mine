import 'message.dart';

class User {
  final String username;
  final String bio;
  final String email;
  final String password;
  final String image;
  final String status;
  final List<Message> messages;

  User({
    required this.username,
    required this.bio,
    required this.email,
    required this.password,
    required this.image,
    required this.status,
    required this.messages,
  });
}
