import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:better_u/presentation/pages/home_page/widget/manual_input_nutrition.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';

class ManualInputFromScanner extends StatelessWidget {
   ManualInputFromScanner({super.key});

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor2,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor2,
                ),
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                width: screenWidth,
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
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(width: 40), // Lebih konsisten
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Apa yang kamu makan hari ini?',
                    style: txtSecondaryTitle.copyWith(
                        fontWeight: FontWeight.w500, color: blackColor),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextFieldAuth(
                      controller: controller.userMessageController,
                      title: 'contoh: ayam geprek dengan nasi merah',
                      maxLines: 5,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jelaskan apa yang kamu makan hari ini, dan kami akan menganalisis nutrisi didalam makananmu secara otomatis',
                    style: txtSecondarySubTitle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: blackColor.withOpacity(0.7)),
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    text: 'Analisis',
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 60,
                    borderRadius: 10,
                    onPressed: () {
                      controller.postChatModelAnalisisFood(context, isFromInputManual: true);
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Merasa kurang puas dengan hasilnya? yuk isi manual',
                      style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500, color: blackColor),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()  {
                              Get.to(() => ManualInputNutrition());
                            },
                          text: ' Disini',
                          style: txtSecondaryTitle.copyWith(
                              fontWeight: FontWeight.w700, color: primaryColor),
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
    );
  }
}
