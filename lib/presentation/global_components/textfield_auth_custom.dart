import 'package:flutter/material.dart';

import '../../../common/theme.dart';

class CustomTextFieldAuth extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  const CustomTextFieldAuth({super.key, required this.title, this.controller});

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
          style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w600, color: blackColor),
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w600, color: grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(width: 2, color: primaryColor, style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(width: 2, color: grey, style: BorderStyle.solid),
            ),
            suffixIcon: (title == "Enter your password" || title == "Enter your confirm password")
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
