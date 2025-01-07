import 'package:better_u/common/constant.dart';
import 'package:better_u/common/theme.dart';
import 'package:better_u/data/api/auth/model/daily_nutrition_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../common/dimensions.dart';
import '../../../../data/api/auth/model/current_combo_model.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/home_controller.dart';
import '../widget/add_activity.dart';
import '../widget/calorie_circle_progress.dart';
import '../widget/list_card_activity.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() {
                      return controller.isLoading.value
                          ? CircularProgressIndicator()
                          : controller.dataUser.value != null
                              ? RichText(
                                  text: TextSpan(
                                    text: '${controller.getGreeting()},',
                                    style: txtPrimaryTitle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: blackColor),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${controller.dataUser.value!.name}',
                                        style: txtPrimaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                )
                              : Text('No user data available',
                                  style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor));
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      icWavingHand,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
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
                      )
                      );
                    }

                    final dailyNutrition = nutritionInfo.dailyNutrition!;

                    final currentTotalNutrition =
                        controller.currentTotalNutrition.value;
                    final totalKaloriMakan =
                        currentTotalNutrition.totalKaloriMakan;
                    final totalKaloriAktivitas =
                        currentTotalNutrition.totalKaloriAktivitas;
                    final totalKaloriSekarang =
                        currentTotalNutrition.totalKaloriSekarang;
                    final totalLemak = currentTotalNutrition.totalLemak;
                    final totalProtein = currentTotalNutrition.totalProtein;
                    final totalKarbohidrat =
                        currentTotalNutrition.totalKarbohidrat;

                    int formatDoubleToRoundedInt(double value) {
                      // Periksa apakah desimalnya 0.5
                      if (value % 1 == 0.5) {
                        return value
                            .ceil(); // Bulatkan ke atas jika desimalnya 0.5
                      }
                      return value.toInt(); // Hapus desimal lainnya
                    }

                    // Nilai-nilai untuk progress bars
                    int currentLemak =
                        totalLemak ?? 0; // Contoh nilai saat ini
                    double progressLemak =
                        (currentLemak / dailyNutrition.lemak!).clamp(0.0, 1.0);

                    int currentProtein =
                        totalProtein ?? 0; // Contoh nilai saat ini
                    double progressProtein =
                        (currentProtein / dailyNutrition.protein!)
                            .clamp(0.0, 1.0);

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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  grey),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${totalLemak ?? 0} g / ${dailyNutrition.lemak} g',
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.yellow),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${totalProtein ?? 0} g / ${dailyNutrition.protein} g',
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  redMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${totalKarbohidrat ?? 0} g / ${dailyNutrition.karbohidrat} g',
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kegiatan Hari Ini',
                      style: txtPrimaryTitle.copyWith(
                          fontWeight: FontWeight.w600, color: blackColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => AddActivity()),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.add,
                            color: baseColor,
                          )),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(bottom: 80),
                    width: screenWidth,
                    // height: 400,
                    child: FoodListView(currentCombo: controller.currentCombo)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








