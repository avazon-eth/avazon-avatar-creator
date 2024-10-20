import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;

  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    var inner = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(color: ColorTable.grey),
      errorWidget: (context, url, error) => Column(
        children: [
          const Icon(Icons.error),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              'Error loading image: $error',
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: inner,
      );
    }
    return inner;
  }
}
