import 'package:better_u/presentation/pages/food_detail_page/widget/image_food_detail.dart';
import 'package:better_u/presentation/pages/food_detail_page/widget/nutrition_food_detail.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme.dart';
import '../controller/food_detail_controller.dart';

class FoodDetailPage extends GetView<FoodDetailController> {
  const FoodDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: grey2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageFoodDetail(imageUrl: 'https://img.kurio.network/ewrCJ9eRNpljU-80vrqWDQkN7o4=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/20/10/10/a7e9eaa0-1c22-42b0-a11f-0a5ad1d30126.jpeg'),

                NutritionFoodDetail(textTitle: 'Nasi Goreng', textCalories: '150', textTime: '30', textProtein: '100', textKarbo: '200', textLemak: '300', textCatatan: 'Jangan Makan Banyak Banyak')
              ],
            ),
          ),
        ),
      ),
    );
  }
}