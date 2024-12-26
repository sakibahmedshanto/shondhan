import 'package:flutter/material.dart';

class DropdownInput extends StatelessWidget {
  final String label;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownInput({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border:const OutlineInputBorder(),
      ),
      items: items.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          )).toList(),
      onChanged: onChanged,
    );
  }
}
