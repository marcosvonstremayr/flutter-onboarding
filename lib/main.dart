import 'package:flutter/material.dart';
import './src/ui/cards_list.dart';
import './utils/constants.dart';

void main() => runApp(const HearthstoneApp());

class HearthstoneApp extends StatelessWidget {
  const HearthstoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        fontFamily: Constants.appFont,
        scaffoldBackgroundColor: Constants.appBackgroundColor,
      ),
      home: const CardList(),
    );
  }
}
