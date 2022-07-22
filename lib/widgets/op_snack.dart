import 'package:flutter/material.dart';

void popSnack({
  required BuildContext context,
  required String text,
  Color? hue,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(color: hue ?? Colors.redAccent),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
    ),
  );
}
