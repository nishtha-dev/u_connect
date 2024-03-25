import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool isObscured;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final int maxLine;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.isObscured = false,
      this.onChanged,
      this.validator,
      this.maxLine = 1,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      initialValue: initialValue,
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).nextFocus();
      },
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
