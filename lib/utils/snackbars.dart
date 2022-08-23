import 'package:flutter/material.dart';

openIconSnackBar(context, String text, Widget icon, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Row(
      children: [
        icon,
        const SizedBox(
          width: 5,
        ),
        Text(text)
      ],
    ),
    duration: const Duration(milliseconds: 2500),
  ));
}
