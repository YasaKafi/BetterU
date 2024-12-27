import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../controller/register_controller.dart';

Widget buildActivityInputPage(double screenWidth, double screenHeight, RegisterController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              int actualIndex = index + 4; // Indeks bar (4-7)
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value >= actualIndex
                        ? primaryColor
                        : primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }),
          );
        }),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Hai, Nares', style: txtPrimaryTitle.copyWith(fontWeight: FontWeight.w700, color: blackColor),),
                SizedBox(width: 5,),
                SvgPicture.asset(
                  icWavingHand,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text('Selanjutnya, bagaimana dengan aktivitas keseharianmu?', style: txtPrimarySubTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor),)
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Obx(() {
              return CommonButton(
                text: 'Sangat Jarang Beraktivitas',
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: controller.selectedActivity.value == 'Sangat Jarang Beraktivitas'
                      ? primaryColor
                      : blackColor,
                ),
                onPressed: () => controller.selectedActivity('Sangat Jarang Beraktivitas'),
                height: 60,
                borderRadius: 10,
                width: screenWidth,
                border: BorderSide(
                  color: controller.selectedActivity.value == 'Sangat Jarang Beraktivitas'
                      ? primaryColor
                      : grey2,
                  width: 2,
                ),
                backgroundColor: controller.selectedActivity.value == 'Sangat Jarang Beraktivitas'
                    ? baseColor
                    : grey2,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return CommonButton(
                text: 'Jarang Beraktivitas',
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: controller.selectedActivity.value == 'Jarang Beraktivitas'
                      ? primaryColor
                      : blackColor,
                ),
                onPressed: () => controller.selectedActivity('Jarang Beraktivitas'),
                height: 60,
                borderRadius: 10,
                width: screenWidth,
                border: BorderSide(
                  color: controller.selectedActivity.value == 'Jarang Beraktivitas'
                      ? primaryColor
                      : grey2,
                  width: 2,
                ),
                backgroundColor: controller.selectedActivity.value == 'Jarang Beraktivitas'
                    ? baseColor
                    : grey2,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return CommonButton(
                text: 'Cukup Beraktivitas',
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: controller.selectedActivity.value == 'Cukup Beraktivitas'
                      ? primaryColor
                      : blackColor,
                ),
                border: BorderSide(
                  color: controller.selectedActivity.value == 'Cukup Beraktivitas'
                      ? primaryColor
                      : grey2,
                  width: 2,
                ),
                onPressed: () => controller.selectedActivity('Cukup Beraktivitas'),
                height: 60,
                borderRadius: 10,
                width: screenWidth,
                backgroundColor: controller.selectedActivity.value == 'Cukup Beraktivitas'
                    ? baseColor
                    : grey2,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return CommonButton(
                text: 'Sering Beraktivitas',
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: controller.selectedActivity.value == 'Sering Beraktivitas'
                      ? primaryColor
                      : blackColor,
                ),
                border: BorderSide(
                  color: controller.selectedActivity.value == 'Sering Beraktivitas'
                      ? primaryColor
                      : grey2,
                  width: 2,
                ),
                onPressed: () => controller.selectedActivity('Sering Beraktivitas'),
                height: 60,
                borderRadius: 10,
                width: screenWidth,
                backgroundColor: controller.selectedActivity.value == 'Sering Beraktivitas'
                    ? baseColor
                    : grey2,
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return CommonButton(
                text: 'Sangat Sering Beraktivitas',
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: controller.selectedActivity.value == 'Sangat Sering Beraktivitas'
                      ? primaryColor
                      : blackColor,
                ),
                border: BorderSide(
                  color: controller.selectedActivity.value == 'Sangat Sering Beraktivitas'
                      ? primaryColor
                      : grey2,
                  width: 2,
                ),
                onPressed: () => controller.selectedActivity('Sangat Sering Beraktivitas'),
                height: 60,
                borderRadius: 10,
                width: screenWidth,
                backgroundColor: controller.selectedActivity.value == 'Sangat Sering Beraktivitas'
                    ? baseColor
                    : grey2,
              );
            }),
          ],
        ),

        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: primaryColor.withOpacity(0.2),
                child: IconButton(
                  onPressed: controller.previousPage,
                  icon: Icon(
                    Icons.chevron_left,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 25,),
              Expanded(
                child: CommonButton(
                  text: 'Selanjutnya',
                  onPressed: controller.nextPage,
                  height: 60,
                  borderRadius: 80,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}