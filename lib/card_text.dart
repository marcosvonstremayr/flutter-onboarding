import 'package:flutter/material.dart';
import 'package:hearthstone_cards/utils/constants.dart';

class CardText extends StatelessWidget {
  final String text;

  const CardText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.cardTextPadding),
      child: Text(
        text,
        style: const TextStyle(
          color: Constants.cardTextColor,
          fontSize: Constants.cardTextFontSize,
        ),
      ),
    );
  }
}
