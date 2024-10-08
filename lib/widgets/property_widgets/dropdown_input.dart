import 'package:flutter/material.dart';

class DropdownInput extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const DropdownInput({
    Key? key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
