import 'package:flutter/material.dart';

class MyTexxtField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final Function(String?)? onchange;
  final String? Function(String?)? validator;
  final String? initialValue;
  const MyTexxtField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obscureText,
      this.validator,
      this.initialValue,
      this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      onChanged: onchange,
    );
  }
}
