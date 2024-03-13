import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  const InputWidget({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 1.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey.withOpacity(0.25),
          ),
        ),
      ),
      textAlign: TextAlign.right,
    );
  }
}
