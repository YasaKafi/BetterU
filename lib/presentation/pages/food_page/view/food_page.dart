import 'package:better_u/presentation/global_components/custom_search_bar.dart';
import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../profile_page/widget/chatbot_ai.dart';
import '../controller/food_controller.dart';
import '../widget/listview_food_horizontal.dart';
import '../widget/listview_food_vertical.dart';

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
        flexibleSpace: Obx(() {
          if (controller.isLoadingMain.value) {
            return const Center(child: CircularProgressIndicator(color: grey2));
          } else {
            return CustomSearchBar(
              hintName: 'Cari makanan favoritmu',
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onSearch: (query) {
                if (query.isNotEmpty) {
                  controller.isLoadingMain.value = true;
                  controller.getAllFoodSearch();
                }
              },
              onClearSearch: () {
                controller.foodSearch.value.data?.clear();
                controller.isLoadingFoodSearch.value = true;
                controller.refresh();
              },
              searchController: controller.searchController,
            );
          }
        }),

      ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.refresh();
            },
            child: Obx(() {
              // ** Kondisi Search Food ** //
              if (controller.isLoadingFoodSearch.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );

              } else {
                // ** UI Search Food ** //
                if (controller.searchController.text.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20),
                          Text('Hasil dari "${controller.searchController.text}"', style: txtPrimaryTitle.copyWith(
                            color: blackColor,
                            fontWeight: FontWeight.w700,
                          )),
                          const SizedBox(height: 20),

                          ListviewFoodVertical(foodList: controller.foodSearch),
                        ],
                      ),
                    ),
                  );

                // ** UI Food Recommendation & Popular ** //
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ** Rekomendasi Makanan ** //
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
                            child: Obx(() {
                              if (controller.isLoadingFoodRecommendation.value) {
                                return ShimmerWidgets.shimmerHorizontalFoodCard(screenWidth: MediaQuery.of(context).size.width, screenHeight: MediaQuery.of(context).size.height);
                              } else {
                                return ListviewFoodHorizontal(foodList: controller.foodRecommendation);
                              }
                            }),
                          ),

                          // ** Makanan Populer ** //
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                            child: Text('Makanan Populer', style: txtPrimaryTitle.copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Obx(() {
                              if (controller.isLoadingFoodPopular.value) {
                                return ShimmerWidgets.shimmerVerticalFoodCard(screenWidth: MediaQuery.of(context).size.width, screenHeight: MediaQuery.of(context).size.height);
                              } else {
                                return ListviewFoodVertical(foodList: controller.foodPopular);
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
            }),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
                () => ChatbotAi(),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              betterAiLogo,
              width: 28,
              height: 28,
            ),
            Text(
              'Better AI',
              style: txtThirdSubTitle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontSize: 8
              ),
            ),
          ],
        ),
        backgroundColor: baseColor,

        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}