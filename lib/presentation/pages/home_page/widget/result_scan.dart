import 'dart:io';

import 'package:better_u/presentation/global_components/common_button.dart';
import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:better_u/presentation/pages/home_page/widget/show_recommendation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/auth/model/nutrition_information.dart';
import '../../../../route/app_pages.dart';

class ResultScan extends StatelessWidget {
  ResultScan({super.key, required this.item, this.imagePath});

  final NutritionInformationFromAI item;
  final String? imagePath;

  HomeController homeController = Get.find();




  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
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
                    'Hasil Scan',
                    style: txtSecondaryHeader.copyWith(
                        fontWeight: FontWeight.w700, color: blackColor),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: 30),

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
                            )
                          ),
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

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_outline, size: 24, color: primaryColor,
                              ),
                              SizedBox(width: 10,),
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'Bukan makananmu? Anda bisa mencari makanan yang relevan dengan foto mu',
                                    style: txtPrimarySubTitle.copyWith(
                                        fontWeight: FontWeight.w400, color: primaryColor),
                                    children: [
                                      TextSpan(
                                        text: ' Disini',
                                        style: txtPrimarySubTitle.copyWith(
                                            fontWeight: FontWeight.w700, color: primaryColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                          await homeController.postImageToURL(context);
                                          await homeController.postRecommendationFood(context);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],

                          ),
                        ),

                        const SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.name}",
                              style: txtPrimaryTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${item.kalori} kkal",
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: blackColor80,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        icProtein,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Protein",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${item.protein ?? 0} gram",
                                            style: txtPrimaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        icKarbo,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Karbohidrat",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${item.karbohidrat ?? 0} gram",
                                            style: txtPrimaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        icLemak,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Lemak",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${item.lemak ?? 0} gram",
                                            style: txtPrimaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        icKalori,
                                        width: 46,
                                        height: 46,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Kalori",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${item.kalori ?? 0} kkal",
                                            style: txtPrimaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Catatan",
                              style: txtPrimaryTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${item.catatan}",
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: blackColor80,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 150),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: CommonButton(
          text: 'Saya Makan ini',
          onPressed: () async {
           await homeController.postDailyActivity(
             category: 'Makan',
             name: item.name,
             kalori: item.kalori.toString(),
              protein: item.protein.toString(),
              karbohidrat: item.karbohidrat.toString(),
              lemak: item.lemak.toString(),
              note: item.catatan,
             isFromResultScan: true

           );
           await Get.offNamedUntil(Routes.BOTTOM_NAVBAR, ModalRoute.withName(Routes.BOTTOM_NAVBAR));
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
