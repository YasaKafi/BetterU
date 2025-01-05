import 'package:better_u/presentation/pages/food_detail_page/widget/card_nutrition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';

class NutritionFoodDetail extends StatelessWidget {
  NutritionFoodDetail({
    super.key,
    required this.textTitle,
    required this.textCalories,
    required this.textTime,
    required this.textProtein,
    required this.textKarbo,
    required this.textLemak,
    required this.textCatatan,
  });

  String textTitle;
  String textCalories;
  String textTime;
  String textProtein;
  String textKarbo;
  String textLemak;
  String textCatatan;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(textTitle, style: txtPrimaryTitle.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                  )),

                  Text('$textCalories Kkal / Porsi', style: txtSecondarySubTitle.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  )),
                ],
              ),

              Row(
                children: [
                  const Icon(Icons.access_time_rounded, color: blackColor, size: Dimensions.iconSizeMedium),

                  const SizedBox(width: 5),

                  Text('$textTime menit', style: txtSecondarySubTitle.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              )
            ],
          ),

          const SizedBox(height: 25),
          const Divider(color: grey, thickness: 1, height: 5),
          const SizedBox(height: 25),

          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            childAspectRatio: 1.85,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CardNutrition(icon: icProtein, textTitle: 'Protein', textNutrition: textProtein),
              CardNutrition(icon: icLemak, textTitle: "Lemak", textNutrition: textLemak),
              CardNutrition(icon: icKarbo, textTitle: "Karbohidrat", textNutrition: textKarbo),
              CardNutrition(icon: icKalori, textTitle: "Kalori", textNutrition: textCalories),
            ],
          ),

          const SizedBox(height: 25),
          const Divider(color: grey, thickness: 1, height: 5),
          const SizedBox(height: 25),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Catatan", style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: blackColor,
                ),
              ),

              const SizedBox(height: 3),

              Text(textCatatan, style: txtPrimarySubTitle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: blackColor80,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}