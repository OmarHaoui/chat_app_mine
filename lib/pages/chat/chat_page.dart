import 'package:flutter/material.dart';
import '../../utilities/constants.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../../widgets/common/costume_Back_button.dart';
import 'chat_list_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  static String id = "chatPage";
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messageController = new TextEditingController();
  List<String> messages = [
    "Hi, how are you?",
    "I'm good, thanks for asking!",
    "Did you get the report I sent you?",
    "Yes, I did. It looks great!",
    "Awesome, glad you liked it!",
    "Can you send me the updated version by tomorrow?",
    "Of course, I'll have it to you by the end of the day.",
    "Thanks, you're a lifesaver!",
    "No problem, happy to help.",
    "Did you see the email from the boss about the new project?",
    "Yes, I did. It sounds really interesting.",
    "We should schedule a meeting to discuss it.",
    "Agreed, how about Wednesday afternoon?",
    "Wednesday works for me. What time?",
    "How about 2 pm?",
    "Perfect, I'll put it on our calendars.",
    "Great, see you then!",
    "Bye for now!",
    "Goodbye!",
    "Have a great day!",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CostumeBackButton(),
                Container(
                  margin: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AdvancedAvatar(
                  image: AssetImage("assets/images/chat.png"),
                  size: 70,
                  name: name,
                  // TODO:make the status color changes according to the user status
                  statusColor: Colors.green,
                  statusAngle: 150,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Flexible(
                    child: Column(
                      crossAxisAlignment: index % 2 == 1
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: index % 2 == 1 ? 100 : 30,
                            right: index % 2 == 1 ? 30 : 100,
                            top: 15,
                            bottom: 15,
                          ),
                          decoration: BoxDecoration(
                            color: index % 2 == 1
                                ? kprimaryColor
                                : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              messages[index],
                              style: TextStyle(
                                  color: kblackColor, fontSize: fontSize),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${DateTime.now().hour}:${DateTime.now().minute}",
                              style: TextStyle(
                                fontSize: fontSize - 5,
                                color: kgreyColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, bottom: 30, top: 20, right: 0),
                    child: TextField(
                      controller: messageController,
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => setState(() {
                            if (messageController.text.isNotEmpty) {
                              messages.add(messageController.text);
                              messageController.clear();
                            }
                          }),
                        ),
                        contentPadding: EdgeInsets.all(25),
                        hintText: "Massage",
                        hintStyle: TextStyle(fontSize: fontSize),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    elevation: 0.5,
                    onPressed: () {
                      // TODO:sending picures and other file formats
                    },
                    child:
                        SizedBox(height: 40, width: 40, child: Icon(Icons.add)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
