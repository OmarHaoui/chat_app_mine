import 'package:flutter/material.dart';
import 'package:my_chat_app/widgets/chat/search_stream_builder.dart';

import '../../utilities/constants.dart';
import '../../widgets/common/costume_Back_button.dart';
import 'chat_list_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  static String id = 'search';
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
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
            "Search",
            style: TextStyle(
              fontSize: 30,
              color: ktextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: size(context).width - 50,
              height: 70,
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  // Update the search term when the user types in the text field
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: kgreyColor,
                  ),
                  fillColor: kgreyColor.withOpacity(0.1),
                  filled: true,
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.only(left: 20, right: 2, top: 30, bottom: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(textFieldsBorderRadius),
                  ),
                ),
              ),
            ),
            searchStreamBuilder(searchQuery: searchQuery)
          ],
        ),
      ),
    );
  }
}
