import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/util/assets_constants.dart';

Widget showImgIfExists(String? img, double height) {
  if (img != null) {
    return CachedNetworkImage(
      imageUrl: img,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (
        context,
        url,
        error,
      ) =>
          const Icon(Icons.error),
      height: height,
    );
  } else {
    return Image.asset(
      AssetsConstants.backCardImage,
      height: height,
    );
  }
}
