import 'package:better_u/common/dimensions.dart';
import 'package:better_u/presentation/global_components/custom_search_bar.dart';
import 'package:better_u/presentation/pages/food_page/controller/food_controller.dart';
import 'package:better_u/presentation/pages/sport_page/controller/sport_controller.dart';
import 'package:better_u/presentation/pages/sport_page/widget/card_sport_vertical.dart';
import 'package:better_u/presentation/pages/sport_page/widget/listview_sport_horizontal.dart';
import 'package:better_u/presentation/pages/sport_page/widget/listview_sport_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';

class SportPage extends GetView<SportController> {
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.currentTypePage.value == "CATEGORY") {
                return InkWell(
                  onTap: () {
                    controller.currentTypePage.value = "BASE";
                    controller.refresh();
                  },
                  child: SafeArea(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back, color: blackColor, size: screenWidth * 0.07),
                              SizedBox(width: screenWidth * 0.02),
                              Text(controller.currentCategory.value, style: txtPrimaryTitle.copyWith(
                                color: blackColor,
                                fontWeight: FontWeight.w700,
                              )),
                            ],
                          )
                      ),
                    ),
                  ),
                );
              } else {
                return CustomSearchBar(
                  hintName: 'Cari olahraga favoritmu',
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  onSearch: (query) {
                    if (query.isNotEmpty) {
                      controller.getAllSportSearch();
                    }
                  },
                  onClearSearch: () {
                    controller.sportSearch.value.data?.clear();
                    controller.isLoadingSportSearch.value = true;
                    controller.refresh();
                  },
                  searchController: controller.searchController,
                );
              }
            }
          }),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.refresh();
            },
            child: Obx(() {
              if (controller.isLoadingMain.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {

                // ** UI Olahraga Base ** //
                if (controller.currentTypePage.value == "BASE") {
                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ** Kategori Olahraga ** //
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                            child: Text('Kategori', style: txtPrimaryTitle.copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            width: screenWidth,
                            height: screenWidth * 0.3,
                            child: Obx(() {
                              if (controller.isLoadingSportCategory.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListviewSportHorizontal(
                                  sportCategory: controller.sportCategory,
                                  onTap: (categoryName) {
                                    controller.isLoadingSportByCategory.value = true;
                                    controller.currentCategory.value = categoryName;
                                    controller.getAllSportByCategory(category: categoryName);
                                  },
                                );
                              }
                            }),
                          ),

                          // ** Rekomendasi Olahraga ** //
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                            child: Text('Olahraga untukmu', style: txtPrimaryTitle.copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Obx(() {
                              if (controller.isLoadingSportRecommendation.value) {
                                return SizedBox(
                                  width: screenWidth,
                                  height: screenWidth * 0.5,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return ListviewSportVertical(sport: controller.sportRecommendation,);
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                }

                // ** UI Olahraga Berdasarkan Pencarian ** //
                else if (controller.currentTypePage.value == "SEARCH") {
                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ** Hasil Pencarian ** //
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 15),
                            child: Text('Hasil dari "${controller.searchController.text}"', style: txtPrimaryTitle.copyWith(
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Obx(() {
                              if (controller.isLoadingSportSearch.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListviewSportVertical(sport: controller.sportSearch);
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // ** UI Olahraga Berdasarkan Kategori ** //
                else if (controller.currentTypePage.value == "CATEGORY") {
                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ** Olahraga Berdasarkan Kategori ** //
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            child: Obx(() {
                              if (controller.isLoadingSportByCategory.value) {
                                return SizedBox(
                                  width: screenWidth,
                                  height: screenWidth * 0.5,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return ListviewSportVertical(sport: controller.sportByCategory);
                              }
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(controller.currentTypePage.value),
                  );
                }

              }
            }),
          ),
        )
    );
  }
}