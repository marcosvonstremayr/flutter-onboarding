import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
import 'card_text.dart';

Widget showPropertyIfExists(String? cardParam, [String? text]) {
  if (cardParam != null) {
    return CardText(
      text: text ?? cardParam,
      isTitle: text != null ? Constants.titleIsTrue : !Constants.titleIsTrue,
    );
  } else {
    return const SizedBox.shrink();
  }
}
