import 'package:better_u/presentation/pages/food_recommendation_page/widget/card_food_popular.dart';
import 'package:better_u/presentation/pages/food_recommendation_page/widget/card_food_recommendation.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/dimensions.dart';
import '../../../../../../common/theme.dart';

class ListviewFoodPopular extends StatelessWidget {
  const ListviewFoodPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 15),
          child: CardFoodPopular(
            imageUrl: 'https://assets.unileversolutions.com/recipes-v2/242794.jpg',
            textTitle: 'Nasi Goreng',
            textCalories: '220',
            textTime: '30',
          ),
        );
      },
    );
  }
}