import 'package:flutter/material.dart';

import '../../../common/theme.dart';

import 'package:flutter/services.dart'; // Untuk inputFormatters

class CustomTextFieldAuth extends StatelessWidget {
  final String title;
  final bool? readOnly;
  final BorderRadius? borderRadius;
  final BorderRadius? borderFocusRadius;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool isNumeric;
  final int? maxDigits;
  final int? maxLines;
  final BorderSide? borderSide;

  const CustomTextFieldAuth({
    super.key,
    required this.title,
    this.controller,
    this.borderRadius,
    this.borderFocusRadius,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.isNumeric = false,
    this.maxDigits,
    this.maxLines = 1,
    this.borderSide,
  });



  @override
  Widget build(BuildContext context) {

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
          onChanged: onChanged,
          onTap: onTap,
          obscureText: _obscureText,
          readOnly: readOnly ?? false,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumeric
              ? [
            FilteringTextInputFormatter.digitsOnly,
            if (maxDigits != null)
              LengthLimitingTextInputFormatter(maxDigits),
          ]
              : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w600, color: grey),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              borderFocusRadius ?? BorderRadius.all(Radius.circular(20.0)),
              borderSide: borderSide ?? BorderSide(
                  width: 2, color: primaryColor, style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(
              borderRadius:
              borderRadius ?? BorderRadius.all(Radius.circular(20.0)),
              borderSide: borderSide ??
                  BorderSide(width: 2, color: grey, style: BorderStyle.solid),
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

