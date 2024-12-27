import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/register_controller.dart';

Widget buildBiodataInputPage(double screenWidth, double screenHeight, RegisterController controller, Function()? onPressed) {
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
            Text('Berikan kami sedikit info tentang anda', style: txtPrimaryTitle.copyWith(fontWeight: FontWeight.w700, color: blackColor),),
            SizedBox(height: 5,),
            Text('Kami ingin mengenalmu lebih dekat', style: txtPrimarySubTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor),)
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
              "Nama Panggilan",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            CustomTextFieldAuth(
              title: "Enter your name",
              controller: controller.usernameController,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderFocusRadius: BorderRadius.all(Radius.circular(12)),
            ),
            SizedBox(height: 15),
            Text(
              "Tanggal Lahir",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            CustomTextFieldAuth(
              title: "Enter your birthdate",
              controller: controller.birthDateController,
              onTap: onPressed,
              readOnly: true,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderFocusRadius: BorderRadius.all(Radius.circular(12)),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return CommonButton(
                    backgroundColor: controller.selectedGender.value == 'Laki-Laki'
                        ? primaryColor
                        : baseColor,
                    icon: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            controller.selectedGender.value == 'Laki-Laki' ? icGenderMaleActive : icGenderMaleUnactive,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Laki-laki',
                            style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w600, color: controller.selectedGender.value == 'Laki-Laki' ? baseColor : blackColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    text: '',
                    onPressed: () => controller.selectGender('Laki-Laki'),
                    height: 60,
                    width: screenWidth * 0.42,
                    borderRadius: 10,
                    style: txtButton.copyWith(
                      fontWeight: FontWeight.w600,
                      color: controller.selectedGender.value == 'Laki-Laki' ? baseColor : blackColor,
                    ),
                    border: controller.selectedGender.value == 'Laki-Laki' ? BorderSide.none : BorderSide(color: blackColor, style: BorderStyle.solid),
                  );
                }),
                Obx(() {
                  return CommonButton(
                    backgroundColor: controller.selectedGender.value == 'Perempuan'
                        ? primaryColor
                        : baseColor,
                    icon: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            controller.selectedGender.value == 'Perempuan' ? icGenderFemaleActive : icGenderFemaleUnactive,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Perempuan',
                            style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w600, color: controller.selectedGender.value == 'Perempuan' ? baseColor : blackColor),
                          ),
                        ],
                      ),
                    ),
                    text: '',
                    onPressed: () => controller.selectGender('Perempuan'),
                    height: 60,
                    width: screenWidth * 0.42,
                    borderRadius: 10,
                    style: txtButton.copyWith(
                      fontWeight: FontWeight.w600,
                      color: controller.selectedGender.value == 'Perempuan' ? baseColor : blackColor,
                    ),
                    border: controller.selectedGender.value == 'Perempuan' ? BorderSide.none : BorderSide(color: blackColor, style: BorderStyle.solid),

                  );
                }),
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
                  onPressed: () {},
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