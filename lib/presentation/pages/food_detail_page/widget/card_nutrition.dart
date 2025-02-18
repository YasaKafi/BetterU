import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/theme.dart';

class CardNutrition extends StatelessWidget {
  CardNutrition({
    super.key,
    required this.icon,
    required this.textTitle,
    required this.textNutrition,
  });

  String icon;
  String textTitle;
  String textNutrition;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: screenWidth * 0.09, height: screenWidth * 0.09),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(textTitle, style: txtSecondarySubTitle.copyWith(
                fontWeight: FontWeight.w500,
                color: blackColor,
              )),
              Text("$textNutrition gram", style: txtPrimarySubTitle.copyWith(
                fontWeight: FontWeight.w600,
                color: blackColor,
              )),
            ],
          ),
        ],
      ),
    );
  }
}