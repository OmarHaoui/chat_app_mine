import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatPageFirst extends StatelessWidget {
  ChatPageFirst({super.key});
  String name = "Jhon Doe";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Pink background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink,
                    Colors.pink.withOpacity(0.1),
                    Colors.white
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                // Profile picture, name and search button.
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Empty space in the start
                    SizedBox(width: MediaQuery.of(context).size.width / 2.6),
                    // Profile picture and name
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 87, 86, 86),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(-0.5, 0),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 35, // radius of the circle
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Image.asset("assets/images/chat.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          name.length < 10 ? name : "${name.substring(0, 10)}.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        )
                      ],
                    ),
                    // Search button
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // white container
            Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      height: 100,
                      child: Row(children: []),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
