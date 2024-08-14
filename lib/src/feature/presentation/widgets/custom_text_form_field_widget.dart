import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  CustomTextFormFieldWidget(
      {super.key,
      required this.labelText,
      this.controller,
      this.validator,
      this.onChanged,
      this.initialValue,
      this.maxLines = 1});

  final String labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  int? maxLines;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black54,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 0.5,
          ),
        ),
        labelText: labelText,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}
