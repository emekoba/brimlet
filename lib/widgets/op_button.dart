import 'package:flutter/material.dart';

class OpButton extends StatelessWidget {
  final double height;
  final double width;
  final String label;
  final Function onPressed;

  const OpButton({
    Key? key,
    this.height = 40,
    this.width = double.infinity,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
      ),

      // TextButton.styleFrom(
      //   primary: Colors.white,
      //   backgroundColor: const Color(0xff05afff),
      //   onSurface: Colors.grey,
      //   minimumSize: Size(width, height),
      // ),
      child: Text(label),
    );
  }
}
