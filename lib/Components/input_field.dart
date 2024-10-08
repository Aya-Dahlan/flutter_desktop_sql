import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.icon});
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hint,
        ),
      ),
    );
  }
}
