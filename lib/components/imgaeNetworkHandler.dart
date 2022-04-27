import 'package:flutter/material.dart';
import 'package:yodacentral/components/yd_colors.dart';

//https://picsum.photos/200

Widget imageNetworkHandler({String? urlImage, String? nama}) {
  // print(urlImage!);
  return Image.network(
    urlImage!,
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Center(
          child: Icon(
        Icons.image_not_supported_rounded,
      ));
    },
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return Center(
        child: CircularProgressIndicator(
          // color: yd_Color_Primary,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    fit: BoxFit.cover,
  );
}
