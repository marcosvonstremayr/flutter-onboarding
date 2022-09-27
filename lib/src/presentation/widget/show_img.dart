import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';

Widget showImgIfExists(String? img, double height) {
  if (img != null) {
    return CachedNetworkImage(
      imageUrl: img,
      progressIndicatorBuilder: (
        context,
        url,
        downloadProgress,
      ) =>
          Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (
        context,
        url,
        error,
      ) =>
          Image.asset(
        AssetsConstants.backCardImage,
        height: height,
      ),
      height: height,
    );
  } else {
    return Image.asset(
      AssetsConstants.backCardImage,
      height: height,
    );
  }
}
