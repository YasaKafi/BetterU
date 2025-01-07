import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../common/theme.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.style,
    this.borderRadius,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.icon,
    this.padding,
    this.border,
    this.textAlign,
  });

  String text;
  double? width;
  double? height;
  double? fontSize;
  VoidCallback? onPressed;
  TextStyle? style;
  double? borderRadius;
  Color? backgroundColor;
  Color? textColor;
  FontWeight? fontWeight;
  Widget? icon;
  EdgeInsets? padding;
  BorderSide? border;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed ?? null,

        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor ?? primaryColor,
          fixedSize: Size(width ?? double.nan, height ?? 0),
          shape: RoundedRectangleBorder(
            side: border ?? BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 15),
          ),

        ),
        child: icon ?? Text(
          textAlign: textAlign,
          text,
          style: style ?? txtButton.copyWith(
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? baseColor,
            fontSize: fontSize ?? 16,

          ),
        )

    );
  }
}