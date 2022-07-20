import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class CardText extends StatelessWidget {
  final String text;
  final bool isTitle;

  const CardText({
    Key? key,
    required this.text,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.cardTextPadding),
      child: Text(
        text,
        style: TextStyle(
          color: Constants.cardTextColor,
          fontSize: Constants.cardTextFontSize,
          fontWeight: isTitle == true ? FontWeight.bold : FontWeight.normal,
          overflow: Constants.cardTextOverflow,
        ),
        maxLines: Constants.cardTextMaxLines,
      ),
    );
  }
}
