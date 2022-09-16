import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/constants.dart';
import '../../core/util/dimensions_constants.dart';

Widget error(String errorMsg) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetsConstants.errorScreen,
          height: DimensionsConstants.errorImageHeight,
        ),
        Text(
          errorMsg,
          style: const TextStyle(
            color: Constants.errorMessageTextColor,
            fontSize: DimensionsConstants.errorMessageFontSize,
          ),
        ),
      ],
    ),
  );
}
