import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
import '../../core/util/dimensions_constants.dart';

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
      padding: const EdgeInsets.all(DimensionsConstants.cardTextPadding),
      child: Text(
        text,
        style: TextStyle(
          color: Constants.cardTextColor,
          fontSize: DimensionsConstants.cardTextFontSize,
          fontWeight: isTitle == true ? FontWeight.bold : FontWeight.normal,
          overflow: TextOverflow.ellipsis,
        ),
        textAlign: isTitle == true ? TextAlign.start : TextAlign.end,
        maxLines: DimensionsConstants.cardTextMaxLines,
      ),
    );
  }
}
