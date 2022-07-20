import 'package:flutter/material.dart';

enum OpTextFieldTypes {
  name,
  email,
  password,
}

class OpTextfield extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final OpTextFieldTypes type;
  final String? hintText;
  final String? placeholder;
  final TextStyle? hintStyle;
  final Function onChange;
  final IconData? icon;
  final bool? useIcon;

  const OpTextfield({
    Key? key,
    this.height,
    this.width,
    this.padding,
    this.placeholder,
    this.controller,
    required this.type,
    this.hintText,
    this.hintStyle,
    required this.onChange,
    this.icon,
    this.useIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData resolveTextFieldIcon() {
      if (icon == null) {
        switch (type) {
          case OpTextFieldTypes.email:
            return Icons.email;

          case OpTextFieldTypes.password:
            return Icons.lock;

          case OpTextFieldTypes.name:
            return Icons.person;

          default:
            return Icons.error;
        }
      } else {
        return icon ?? Icons.error;
      }
    }

    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      padding: padding ?? const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(231, 238, 241, 0.938),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          useIcon == true
              ? Icon(
                  resolveTextFieldIcon(),
                )
              : Container(),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: type == OpTextFieldTypes.email
                  ? TextInputType.emailAddress
                  : null,
              enableSuggestions:
                  type == OpTextFieldTypes.password ? false : true,
              autocorrect: type == OpTextFieldTypes.password ? false : true,
              obscureText: type == OpTextFieldTypes.password ? true : false,
              onChanged: (String value) => onChange(value),
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
              decoration: InputDecoration(
                hintText: hintText ?? "",
                hintStyle: hintStyle ??
                    Theme.of(context).textTheme.headline6?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
