import 'dart:io';

import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:better_u/presentation/pages/home_page/widget/manual_input_from_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/auth/model/data_recommendation_food.dart';
import '../../../../data/api/auth/model/nutrition_information.dart';
import '../../../global_components/common_button.dart';

class ShowRecommendation extends StatelessWidget {
  ShowRecommendation({
    super.key,
    this.imagePath,
    required this.recommendationContent,
  });

  final String? imagePath;
  final RecommendationContent recommendationContent;
  HomeController controller = Get.find();


  String capitalize(String input) {
    return input.split(' ').map((word) {
      return toBeginningOfSentenceCase(word.toLowerCase()) ?? word;
    }).join(' ');
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor2,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Tambah Makanan',
                      style: txtSecondaryHeader.copyWith(
                          fontWeight: FontWeight.w700, color: blackColor),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Result Scan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: baseColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          imagePath != null
                              ? Container(
                            width: screenWidth,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.cover,
                                )),
                          )
                              : Container(
                            width: screenWidth,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                imgExFood,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Beberapa makanan yang relevan dengan foto kamu',
                            style: txtPrimaryTitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: blackColor),
                          ),

                          const SizedBox(height: 30),

                          // Display Recommendation Food
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        return CommonButton(
                                          text: capitalize(recommendationContent.makananOne ?? "Food 1") ,
                                          style: txtButton.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedFood.value == recommendationContent.makananOne
                                                ? primaryColor
                                                : blackColor,
                                          ),
                                          onPressed: () => controller.selectedFood(recommendationContent.makananOne ?? "Food 1"),
                                          height: 60,
                                          borderRadius: 10,
                                          width: screenWidth,
                                          border: BorderSide(
                                            color: controller.selectedFood.value == recommendationContent.makananOne
                                                ? primaryColor
                                                : grey2,
                                            width: 2,
                                          ),
                                          backgroundColor: controller.selectedFood.value == recommendationContent.makananOne
                                              ? baseColor
                                              : grey2,
                                        );
                                      }),
                                      SizedBox(height: 20),
                                      Obx(() {
                                        return CommonButton(
                                          text: capitalize(recommendationContent.makananTwo ?? "Food 2") ,
                                          style: txtButton.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedFood.value == recommendationContent.makananTwo
                                                ? primaryColor
                                                : blackColor,
                                          ),
                                          onPressed: () => controller.selectFood(recommendationContent.makananTwo ?? "Food 2"),
                                          height: 60,
                                          borderRadius: 10,
                                          width: screenWidth,
                                          border: BorderSide(
                                            color: controller.selectedFood.value == recommendationContent.makananTwo
                                                ? primaryColor
                                                : grey2,
                                            width: 2,
                                          ),
                                          backgroundColor: controller.selectedFood.value == recommendationContent.makananTwo
                                              ? baseColor
                                              : grey2,
                                        );
                                      }),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 40),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Obx(() {
                                        return CommonButton(
                                          text: capitalize(recommendationContent.makananThree ?? "Food 3") ,
                                          style: txtButton.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedFood.value == recommendationContent.makananThree
                                                ? primaryColor
                                                : blackColor,
                                          ),
                                          onPressed: () => controller.selectedFood(recommendationContent.makananThree ?? "Food 3"),
                                          height: 60,
                                          borderRadius: 10,
                                          width: screenWidth,
                                          border: BorderSide(
                                            color: controller.selectedFood.value == recommendationContent.makananThree
                                                ? primaryColor
                                                : grey2,
                                            width: 2,
                                          ),
                                          backgroundColor: controller.selectedFood.value == recommendationContent.makananThree
                                              ? baseColor
                                              : grey2,
                                        );
                                      }),
                                      SizedBox(height: 20),
                                      Obx(() {
                                        return CommonButton(
                                          text: capitalize(recommendationContent.makananFour ?? "Food 4") ,
                                          style: txtButton.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedFood.value == recommendationContent.makananFour
                                                ? primaryColor
                                                : blackColor,
                                          ),
                                          onPressed: () => controller.selectFood(recommendationContent.makananFour ?? "Food 4"),
                                          height: 60,
                                          borderRadius: 10,
                                          width: screenWidth,
                                          border: BorderSide(
                                            color: controller.selectedFood.value == recommendationContent.makananFour
                                                ? primaryColor
                                                : grey2,
                                            width: 2,
                                          ),
                                          backgroundColor: controller.selectedFood.value == recommendationContent.makananFour
                                              ? baseColor
                                              : grey2,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Merasa kurang puas dengan hasilnya? yuk coba analisis makananmu',
                              style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w400, color: blackColor),
                              children: [
                                TextSpan(
                                  text: ' Disini',
                                  style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w700, color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = ()  {
                                    Get.to(() => ManualInputFromScanner());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: CommonButton(
          text: 'Ya, Saya Makan ini',
          onPressed: () {
            controller.postChatModelAnalisisFood(context, isFromRecommendation: true);
          },
          width: screenWidth,
          height: 60,
          borderRadius: 10,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

