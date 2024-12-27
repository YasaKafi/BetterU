import 'package:flutter/material.dart';

import '../../../common/theme.dart';

class CustomTextFieldAuth extends StatelessWidget {
  final String title;
  final bool? readOnly;
  final BorderRadius? borderRadius;
  final BorderRadius? borderFocusRadius;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  const CustomTextFieldAuth(
      {super.key, required this.title, this.controller, this.borderRadius, this.borderFocusRadius, this.onChanged, this.onTap, this.readOnly});

  @override
  Widget build(BuildContext context) {
    // Create a ValueNotifier to manage the obscureText state
    final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(
      title == "Enter your password" || title == "Enter your confirm password",
    );

    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, _obscureText, child) {
        return TextField(
          controller: controller,
          style: txtSecondaryTitle.copyWith(
              fontWeight: FontWeight.w600, color: blackColor),
          obscureText: _obscureText,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w600, color: grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderFocusRadius ?? BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  width: 2, color: primaryColor, style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(20.0)),
              borderSide:
                  BorderSide(width: 2, color: grey, style: BorderStyle.solid),
            ),
            suffixIcon: (title == "Enter your password" ||
                    title == "Enter your confirm password")
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      _obscureTextNotifier.value = !_obscureTextNotifier.value;
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}
