import 'package:flutter/material.dart';
import 'package:pocket_piggy_bank/consts/app_text_styles/constructor_text_style.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final int maxLength = 20;

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
      style: FinanceTextStyle.output,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: FinanceTextStyle.input,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(width: 1.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey.withOpacity(0.25),
          ),
        ),
        counterText: '',
      ),
      textAlign: TextAlign.right,
      maxLength: maxLength,
    );
  }
}
