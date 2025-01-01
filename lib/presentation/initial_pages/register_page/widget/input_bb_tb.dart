import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/register_controller.dart';

Widget buildBbTbInputPage(double screenWidth, double screenHeight, RegisterController controller) {
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
            Text('Yuk, satu pertanyaan lagi!', style: txtPrimaryTitle.copyWith(fontWeight: FontWeight.w700, color: blackColor),),
            SizedBox(height: 5,),
            Text('Tidak apa hanya jika perkiraan, kamu bisa memperbaruinya lagi nanti', style: txtPrimarySubTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor),)
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Berapa Berat Badanmu?",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldAuth(
                    title: "Enter your weight body",
                    controller: controller.weightController,
                    isNumeric: true,
                    maxDigits: 3,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderFocusRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                    child: Text(
                      'KG',
                      style: txtSecondaryTitle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: primaryColor
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Text(
              "Berapa Tinggi Badanmu?",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldAuth(
                    title: "Enter your height body",
                    controller: controller.heightController,
                    isNumeric: true,
                    maxDigits: 3,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderFocusRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                    child: Text(
                      'CM',
                      style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: primaryColor
                      ),
                    ),
                  ),
                )
              ],
            ),



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
                child:CommonButton(
                  text: 'Selesai',
                  // onPressed: () async {
                  //   try {
                  //     await controller.postRegister();
                  //     await controller.postCalculateNutrition();
                  //   } catch (e) {
                  //     print('Error: $e');
                  //   }
                  // },
                  onPressed: () => controller.postRegister(),
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