import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/icons.dart';
import 'package:flutter/material.dart';

class ChattingInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final bool isWaiting;

  const ChattingInput({
    super.key,
    required this.onSend,
    required this.controller,
    this.isWaiting = false,
  });

  @override
  State<ChattingInput> createState() => _ChattingInputState();
}

class _ChattingInputState extends State<ChattingInput> {
  bool get canSend =>
      !widget.isWaiting && widget.controller.value.text.isNotEmpty;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTable.greyTransparent,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: widget.controller,
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                widget.onSend(value);
                focusNode.requestFocus();
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 30.0, right: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: canSend
                    ? () {
                        widget.onSend(widget.controller.value.text);
                      }
                    : null,
                child: Ink(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: canSend ? null : ColorTable.grey,
                    gradient: canSend ? ColorTable.purpleGradient45 : null,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const SvgIcon(
                    iconPath: IconPath.sendChat,
                    height: 24,
                    color: ColorTable.lightGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
