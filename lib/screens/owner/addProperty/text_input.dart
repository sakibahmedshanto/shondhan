// Updated TextInput widget
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final bool isNumber;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  TextInput({
    required this.label,
    required this.onChanged,
    this.isNumber = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      onChanged: onChanged,
      validator: validator,  // Using the passed validator
    );
  }
}
