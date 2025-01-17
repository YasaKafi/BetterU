import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../global_components/shimmer_widget.dart';
import '../controller/home_controller.dart';
import 'calorie_circle_progress.dart';

class CardCurrentNutrition extends StatelessWidget {
  const CardCurrentNutrition({
    super.key,
    required this.controller,
    required this.screenWidth,
  });

  final HomeController controller;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? ShimmerWidgets.boxNutrition(screenWidth)
          : Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // linear
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              linearBegin,
              linearEnd,
            ],
            stops: [0.65, 1],
          ),
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: screenWidth,
        child: Obx(() {
          final nutritionInfo = controller.nutritionInformation.value;
          if (nutritionInfo.dailyNutrition == null ||
              controller.currentTotalNutrition.value == null) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ));
          }

          final dailyNutrition = nutritionInfo.dailyNutrition!;

          final currentTotalNutrition =
              controller.currentTotalNutrition.value;
          final totalKaloriMakan = currentTotalNutrition.totalKaloriMakan;
          final totalKaloriAktivitas =
              currentTotalNutrition.totalKaloriAktivitas;
          final totalKaloriSekarang =
              currentTotalNutrition.totalKaloriSekarang;
          final totalLemak = currentTotalNutrition.totalLemak;
          final totalProtein = currentTotalNutrition.totalProtein;
          final totalKarbohidrat = currentTotalNutrition.totalKarbohidrat;


          int formatDoubleToRoundedInt(double value) {
            // Periksa apakah desimalnya 0.5
            if (value % 1 == 0.5) {
              return value.ceil(); // Bulatkan ke atas jika desimalnya 0.5
            }
            return value.toInt(); // Hapus desimal lainnya
          }

          // Fungsi untuk mendapatkan warna progress
          Color getProgressColor(double progress) {
            if (progress >= 0.97) {
              return Colors.red; // Merah jika lebih dari atau sama dengan 97%
            } else if (progress >= 0.40) {
              return Colors
                  .yellow; // Kuning jika lebih dari atau sama dengan 40%
            } else {
              return grey; // Default warna grey
            }
          }

          // Nilai-nilai untuk progress bars
          int currentLemak = totalLemak ?? 0; // Contoh nilai saat ini
          double progressLemak =
          (currentLemak / dailyNutrition.lemak!).clamp(0.0, 1.0);

          int currentProtein = totalProtein ?? 0; // Contoh nilai saat ini
          double progressProtein =
          (currentProtein / dailyNutrition.protein!).clamp(0.0, 1.0);

          int currentKarbo =
              totalKarbohidrat ?? 0; // Contoh nilai saat ini
          double progressKarbo =
          (currentKarbo / dailyNutrition.karbohidrat!)
              .clamp(0.0, 1.0);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Text(
                          '${totalKaloriMakan} Kkal',
                          style: txtPrimarySubTitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: baseColor,
                          ),
                        ),
                        Text(
                          'Dimakan',
                          style: txtPrimarySubTitle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: baseColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CalorieProgressWidget(
                      currentCalories:
                      totalKaloriSekarang?.toDouble() ?? 0,
                      totalCalories: dailyNutrition.totalKalori!,
                      size: 150.0),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Column(
                      children: [
                        Text(
                          '${totalKaloriAktivitas} Kkal',
                          style: txtPrimarySubTitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: baseColor,
                          ),
                        ),
                        Text(
                          'Terbakar',
                          style: txtPrimarySubTitle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: baseColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Text(
                              'Lemak',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 75,
                              child: LinearProgressIndicator(
                                value: progressLemak,
                                // Replace with your dynamic value
                                backgroundColor:
                                Colors.white.withOpacity(0.2),
                                minHeight: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getProgressColor(progressLemak),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalLemak ?? 0} g / ${dailyNutrition
                                  .lemak} g',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Text(
                              'Protein',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 75,
                              child: LinearProgressIndicator(
                                value: progressProtein,
                                // Replace with your dynamic value
                                backgroundColor:
                                Colors.white.withOpacity(0.2),
                                minHeight: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getProgressColor(progressProtein),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalProtein ?? 0} g / ${dailyNutrition
                                  .protein} g',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Text(
                              'Karbo',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 75,
                              child: LinearProgressIndicator(
                                value: progressKarbo,
                                // Replace with your dynamic value
                                backgroundColor:
                                Colors.white.withOpacity(0.2),
                                minHeight: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getProgressColor(progressKarbo),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalKarbohidrat ?? 0} g / ${dailyNutrition
                                  .karbohidrat} g',
                              style: txtPrimarySubTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: baseColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        }),
      );
    });
  }
}