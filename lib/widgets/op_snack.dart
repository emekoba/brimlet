import 'package:flutter/material.dart';

void popSnack({
  required BuildContext context,
  required String text,
  Color? hue,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    // SnackBar(
    //   content: Text(
    //     text,
    //     textAlign: TextAlign.center,
    //     style: TextStyle(color: hue ?? Colors.redAccent),
    //   ),
    //   behavior: SnackBarBehavior.floating,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(24),
    //   ),
    //   margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 100,
    //     right: 20,
    //     left: 20,
    //   ),

    SnackBar(
      content: Text(
        text,
        style: TextStyle(color: hue ?? Colors.redAccent),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.white,
    ),
  );
}
