import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../controller/register_controller.dart';

Widget buildOtpVerificationPage(
    double screenWidth, double screenHeight, RegisterController controller) {
  final defaultPinTheme = PinTheme(
    margin: const EdgeInsets.only(right: 9),
    width: 80,
    height: 60,
    textStyle: txtSecondaryTitle.copyWith(
        fontWeight: FontWeight.w600, color: blackColor),
    decoration: BoxDecoration(
      color: primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: baseColor,
          ),
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: controller.previousPage),
              Text(
                'Verifikasi Email',
                style: txtSecondaryHeader.copyWith(
                    fontWeight: FontWeight.w700, color: blackColor),
              ),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Masukkan kode yang kami kirimkan ke email ",
                  style: txtSecondaryTitle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                  children: [
                    TextSpan(
                      text: controller.emailController.text,
                      style: txtSecondaryTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(
                  vertical: Dimensions.marginSizeSmall),
              child: Pinput(
                  length: 4,
                  // controller: controller.otpNumberController.value,
                  // defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  // validator: (value) {
                  //   return value == '2222' ? null : 'Pin is incorrect';
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  // onCompleted: (value) => controller.isEnabled.value = true,
                  // onChanged: (value) => controller.isEnabled.value = false,
                  showCursor: true,
                  cursor: Center(
                    child: Container(
                        margin: const EdgeInsets.only(),
                        width: 1,
                        height: 22,
                        color: Colors.grey),
                  ),
                  defaultPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: blackColor),
                    ),
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              final time = controller.timeRemaining.value;
              return Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: time > 0
                      ? TextSpan(
                          text: "Kirim ulang kode setelah ",
                          style: txtSecondaryTitle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                          ),
                          children: [
                              TextSpan(
                                text: " ${time} detik",
                                style: txtSecondaryTitle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                ),
                              ),
                            ])
                      : TextSpan(
                          text: "Tidak menerima kode?",
                          style: txtSecondaryTitle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                          ),
                          children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () => controller.postOtpCode(),
                                  child: Text(
                                    " Kirim Ulang",
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                ),
              );
            }),
            SizedBox(height: 20),
            CommonButton(
              text: 'Verifikasi',
              onPressed: controller.nextPage,
              width: screenWidth,
              height: 60,
              borderRadius: 10,
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Dengan menggunakan BetterU, Anda menyetujui ',
              style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w400, color: blackColor),
              children: <TextSpan>[
                TextSpan(
                  text: 'Persyaratan',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' dan ',
                ),
                TextSpan(
                  text: 'Kebijakan Privasi.',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
