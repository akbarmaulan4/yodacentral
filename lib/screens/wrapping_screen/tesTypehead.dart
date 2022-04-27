import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class User {
  final String name;
  final String imageUrl;

  const User({
    required this.name,
    required this.imageUrl,
  });
}

class UserData {
  static final List<User> users = [
    for (var i = 0; i < 20; i++) User(name: "indiria $i", imageUrl: "hfhfhh $i")
  ];

  static List<User> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}

class TesTypeHead extends StatefulWidget {
  const TesTypeHead({Key? key}) : super(key: key);

  @override
  _TesTypeHeadState createState() => _TesTypeHeadState();
}

class _TesTypeHeadState extends State<TesTypeHead> {
  Widget dropDownSearch() {
    return TypeAheadField<User?>(
      autoFlipDirection: false,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(
          maxHeight: 55 * 4,
        ),
      ),
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          hintText: 'Search Username',
          labelText: "Search Username",
        ),
      ),
      suggestionsCallback: UserData.getSuggestions,
      itemBuilder: (context, User? suggestion) {
        final user = suggestion!;

        return ListTile(
          leading: Container(
            width: 20,
            height: 20,
            child: Image.network(
              user.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(user.name),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 50,
        child: Center(
          child: Text(
            'No Users Found.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      onSuggestionSelected: (User? suggestion) {
        log(suggestion!.name);

        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => UserDetailPage(user: user),
        // ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: dropDownSearch(),
            ),
          ],
        ),
      ),
    );
  }
}
