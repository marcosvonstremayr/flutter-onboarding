import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../core/util/constants.dart';
import '../../core/util/dimensions_constants.dart';

Widget gridCardText(text) {
  if (text != null) {
    return AutoSizeText(
      text,
      style: const TextStyle(
        fontSize: DimensionsConstants.gridTextFontSize,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        color: Constants.gridTextColor,
      ),
      textAlign: TextAlign.center,
      maxLines: DimensionsConstants.gridTextMaxLines,
    );
  } else {
    return const SizedBox.shrink();
  }
}
