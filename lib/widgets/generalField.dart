import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType type;
  final int maxLines;
  final int maxLength;
  final bool isEnabled;

  GeneralField({
    this.label = "none",
    this.hint,
    this.type = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.isEnabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              controller: controller,
              enabled: isEnabled,
              maxLengthEnforced: true,
              maxLength: maxLength,
              maxLines: maxLines,
              minLines: 1,
              cursorColor: Colors.black,
              cursorWidth: 1,
              dragStartBehavior: DragStartBehavior.start,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
                hintText: hint,
              ),
              keyboardType: type,
            ),
          ),
        ),
      ]),
    );
  }
}
