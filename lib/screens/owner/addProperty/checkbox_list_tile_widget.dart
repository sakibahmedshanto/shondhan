import 'package:flutter/material.dart';

class CheckboxListTileInput extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;

  const CheckboxListTileInput({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
