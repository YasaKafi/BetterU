import 'package:better_u/data/api/auth/model/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/dimensions.dart';
import '../../../../../../common/theme.dart';
import '../widget/card_food_recommendation.dart';

class ListviewFoodRecommendation extends StatelessWidget {
  const ListviewFoodRecommendation({
    super.key,
    required this.foodRecommendation,
  });

  final Rx<Food> foodRecommendation;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      final foodRecommendationData = foodRecommendation.value;

      if (foodRecommendationData.data == null || foodRecommendationData.data!.isEmpty) {
        return SizedBox(
          width: screenWidth * 0.4,
          height: screenWidth * 0.2,
          child: const Center(
            child: Text(
              "Tidak ada rekomendasi makanan untukmu.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodRecommendationData.data!.length,
        itemBuilder: (context, index) {
          final item = foodRecommendationData.data![index];
          return Container(
            width: screenWidth * 0.4,
            height: screenWidth * 0.5,
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            child: CardFoodRecommendation(
              imageUrl: item.imageUrl ?? 'https://www.pallenz.co.nz/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
              textTitle: item.name ?? 'Nama Makanan Tidak Diketahui',
              textCalories: item.kalori.toString() ?? '0',
            ),
          );
        },
      );
    });
  }
}