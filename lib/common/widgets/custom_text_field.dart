import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int maxLines;

  const CustomTextField(
      {Key? key, this.hint, required this.controller, this.maxLines = 1,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value == '') {
          return 'Enter your $hint';
        }
        return null;
      },
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
    );
  }
}
