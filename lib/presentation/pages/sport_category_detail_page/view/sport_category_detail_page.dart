import 'package:better_u/presentation/global_components/custom_search_bar.dart';
import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:better_u/presentation/pages/sport_category_detail_page/controller/sport_category_detail_controller.dart';
import 'package:better_u/presentation/pages/sport_page/widget/listview_sport_horizontal.dart';
import 'package:better_u/presentation/pages/sport_page/widget/listview_sport_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';

class SportCategoryDetailPage extends GetView<SportCategoryDetailController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: grey2,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: grey2,
          automaticallyImplyLeading: false,
          flexibleSpace: Obx(() {
            if (controller.isLoadingMain.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return InkWell(
                onTap: () {
                  Get.back();
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
              }
            }),
          ),
        )
    );
  }
}