import 'package:better_u/presentation/global_components/custom_search_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme.dart';
import '../controller/food_controller.dart';
import '../widget/listview_food_recommendation.dart';
import '../widget/listview_food_popular.dart';

class FoodPage extends GetView<FoodController> {
  const FoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: grey2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: grey2,
        flexibleSpace: CustomSearchBar(
          hintName: 'Cari makanan favoritmu',
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          // onSearch: controller.onSearch,
          // onClearSearch: controller.onClearSearch,
          // searchController: controller.searchController,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                  child: Text('Rekomendasi Makanan', style: txtPrimaryTitle.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                  )),
                ),

                Container(
                    width: screenWidth,
                    height: screenWidth * 0.5,
                    child: ListviewFoodRecommendation(foodRecommendation: controller.foodRecommendation,)
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                  child: Text('Makanan Populer', style: txtPrimaryTitle.copyWith(
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                  )),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: ListviewFoodPopular(),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}