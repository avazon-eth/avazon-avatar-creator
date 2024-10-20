import 'package:avarium_avatar_creator/components/bouncing_widget.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double fontSize;
  final double borderRadius;
  final double blurRadius;
  final Widget? icon;
  final EdgeInsets padding;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize = 16.0,
    this.borderRadius = 12.0,
    this.blurRadius = 12.0,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    var button = BouncingWidget(
      onPressed: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: ColorTable.purpleGradient30,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon!,
                ),
              Text(
                text,
                style: TextStyle(
                  color: ColorTable.white,
                  fontSize: fontSize,
                  height: 1.25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (blurRadius <= 0) {
      return button;
    }
    return GlowContainer(
      blurRadius: blurRadius,
      glowColor: ColorTable.purpleGradient2,
      offset: const Offset(2, 2),
      child: GlowContainer(
        blurRadius: blurRadius,
        glowColor: ColorTable.purpleGradient1,
        offset: const Offset(-2, -2),
        child: button,
      ),
    );
  }
}

class GidSecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double borderRadius;
  final double fontSize;
  const GidSecondaryButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize = 16.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12 - 3),
          decoration: BoxDecoration(
            color: ColorTable.lightGreyTransparent.withOpacity(1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: ColorTable.lightGreyTransparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
