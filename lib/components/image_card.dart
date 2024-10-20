import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/cached_image.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String? imageUrl;

  const ImageCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CachedImage(
              url: imageUrl!,
              borderRadius: 16.0,
            )
          : Container(
              decoration: const BoxDecoration(
                color: ColorTable.grey,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
            ),
    );
  }
}
