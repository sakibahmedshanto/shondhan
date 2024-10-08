import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool isNumber;

  const TextInput({
    Key? key,
    required this.label,
    required this.onChanged,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
