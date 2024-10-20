import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Shined extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  const Shined({
    required this.child,
    this.backgroundColor,
    this.borderWidth = 1.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 10.0,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: GradientBoxBorder(
          gradient: ColorTable.shinyGradient,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
