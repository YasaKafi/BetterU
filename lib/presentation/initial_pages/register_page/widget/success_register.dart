import 'package:better_u/presentation/initial_pages/register_page/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';


Widget buildSuccessCreateAccount(double screenWidth,
    double screenHeight, RegisterController controller) {
  return Container(
    height: screenHeight,
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          gifSuccessRegister,
          width: screenWidth,
          height: screenHeight * 0.4,
        ),
        SizedBox(
          height: 35,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selamat!, Akun Kamu Berhasil Dibuat",
              style: txtPrimaryHeader.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Text(
              "Hanya butuh 1 klik untuk menikmati semua fitur BetterU!",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            CommonButton(
              text: 'Masuk Ke Dalam Akun',
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