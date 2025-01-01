import 'package:flutter/material.dart';

import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';

class CardFoodRecommendation extends StatelessWidget {
  CardFoodRecommendation({
    super.key,
    required this.imageUrl,
    required this.textTitle,
    required this.textCalories,
  });

  String imageUrl;
  String textTitle;
  String textCalories;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: screenWidth * 0.4,
        height: screenWidth * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Color.fromRGBO(34, 34, 34, 0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(textTitle, style: txtPrimarySubTitle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                      Text('$textCalories Kkal', style: txtThirdSubTitle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                    ],
                  )
              )
            ]
        )
    );
  }
}