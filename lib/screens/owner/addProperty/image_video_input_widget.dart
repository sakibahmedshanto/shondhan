// File: lib/widgets/property_widgets/image_video_input_widget.dart

import 'package:flutter/material.dart';

class ImageVideoInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onAdd;
  final String label;
  final List<String> items;
  final String? Function(String?)? validator;

  const ImageVideoInputWidget({
    Key? key,
    required this.controller,
    required this.onAdd,
    required this.label,
    required this.items,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: onAdd,
            ),
          ),
          validator: validator,
        ),
        Wrap(
          children: items
              .map((item) => Chip(
                    label: Text(item),
                    onDeleted: () => items.remove(item),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
