import 'package:flutter/material.dart';

class SwitchInput extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const SwitchInput({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.purple,
          activeTrackColor: Colors.purple.shade200,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}
