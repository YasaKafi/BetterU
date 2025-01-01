import 'package:flutter/material.dart';

import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';

class CardFoodPopular extends StatelessWidget {
  CardFoodPopular({
    super.key,
    required this.imageUrl,
    required this.textTitle,
    required this.textCalories,
    required this.textTime,
  });

  String imageUrl;
  String textTitle;
  String textCalories;
  String textTime;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 7.5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textTitle, style: txtPrimarySubTitle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    )),

                    Text('$textCalories Kkal', style: txtThirdSubTitle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                    )),
                  ],
                ),

                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, color: blackColor, size: 20),

                    const SizedBox(width: 5),

                    Text('$textTime menit', style: txtThirdSubTitle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    )),
                  ],
                )
              ],
            )
          ],
        )
    );
  }
}