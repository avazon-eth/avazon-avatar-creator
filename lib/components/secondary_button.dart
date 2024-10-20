import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/bouncing_widget.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const SecondaryButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12 - 3),
        decoration: BoxDecoration(
          color: ColorTable.lightGreyTransparent.withOpacity(1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: ColorTable.lightGreyTransparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              height: 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
