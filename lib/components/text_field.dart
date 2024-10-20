import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/shined.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Shined(
      padding: EdgeInsets.zero,
      backgroundColor: ColorTable.greyTransparent,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          height: 1.25,
        ),
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12.0),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 16.0,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}
