import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    required this.labelText,
    this.controller,
  });

  final String? Function(String?)? validator;
  final String labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: labelText,
      ),
      validator: validator ??
          (value) {
            if (value?.isEmpty ?? true) {
              return "This field is required";
            } else {}
            return null;
          },
    );
  }
}
