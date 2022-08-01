import 'package:flutter/material.dart';
import 'src/presentation/view/cards_list.dart';
import './src/core/util/constants.dart';

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
