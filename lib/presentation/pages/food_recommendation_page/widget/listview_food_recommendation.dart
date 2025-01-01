import 'package:better_u/presentation/pages/food_recommendation_page/widget/card_food_recommendation.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/dimensions.dart';
import '../../../../../../common/theme.dart';

class ListviewFoodRecommendation extends StatelessWidget {
  const ListviewFoodRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: screenWidth * 0.4,
          height: screenWidth * 0.5,
          margin: EdgeInsets.only(left: screenWidth * 0.05),
          child: CardFoodRecommendation(
            imageUrl: 'https://assets.unileversolutions.com/recipes-v2/242794.jpg',
            textTitle: 'Nasi Goreng',
            textCalories: '220',
          ),
        );
      },
    );
  }
}