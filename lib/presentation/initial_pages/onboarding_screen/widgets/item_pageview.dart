import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../common/constant.dart';
import '../../../../../common/dimensions.dart';
import '../../../../../common/theme.dart';

class ItemOnBoarding extends StatelessWidget {
  final String imgBoarding;
  final String titleBoarding;
  final String subtitleBoarding;
  final double screenWidth;
  final int index;

  const ItemOnBoarding({
    super.key,
    required this.imgBoarding,
    required this.titleBoarding,
    required this.subtitleBoarding,
    required this.screenWidth,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Column(
            children: [
              Center(child: Image.asset(imgBoarding)),
              SizedBox(height: Dimensions.marginSizeLarge),
              Container(
                width: screenWidth,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: _buildTitleWithHighlight(titleBoarding, index),
                    style: txtPrimaryHeader.copyWith(
                      fontWeight: FontWeight.w600,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.marginSizeSmall),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    subtitleBoarding,
                    style: txtPrimarySubTitle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildTitleWithHighlight(String text, int index) {
    // Highlight logic based on index
    if (index == 0) {
      return _highlightWord(text, "Makananmu");
    } else if (index == 1) {
      return _highlightWord(text, "Makanan Sehat");
    } else if (index == 2) {
      return _highlightWord(text, "Kegiatanmu");
    } else {
      return [TextSpan(text: text)];
    }
  }

  List<TextSpan> _highlightWord(String text, String wordToHighlight) {
    final parts = text.split(wordToHighlight);
    return [
      TextSpan(text: parts[0]), // Teks sebelum kata yang di-highlight
      TextSpan(
        text: wordToHighlight,
        style: TextStyle(color: primaryColor), // Warna khusus
      ),
      if (parts.length > 1) TextSpan(text: parts[1]), // Teks setelah kata yang di-highlight
    ];
  }
}
