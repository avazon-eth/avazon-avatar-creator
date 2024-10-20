import 'package:flutter/material.dart';

/// [[label(optional)]image] button
/// position of label is bottom left
class ImageButton extends StatelessWidget {
  final ImageProvider imageProvider;
  final double borderRadius;
  final String? label;
  final void Function()? onPressed;
  final bool isSelected; // if unselected, opacity is 0.5

  const ImageButton({
    super.key,
    required this.imageProvider,
    this.borderRadius = 12.0,
    this.label,
    this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          if (!isSelected)
            const Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: ColoredBox(color: Colors.black),
              ),
            ),
          if (label != null)
            Positioned(
              bottom: 10,
              left: 14,
              child: Text(
                label!,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
