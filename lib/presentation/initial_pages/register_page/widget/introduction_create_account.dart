import 'package:better_u/presentation/initial_pages/register_page/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../route/app_pages.dart';
import '../../../global_components/common_button.dart';


Widget buildIntroductionCreateAccount(double screenWidth,
    double screenHeight, RegisterController controller, bool? isFromOnboard) {
  return Container(
    height: screenHeight,
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            color: baseColor,
          ),
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          width: screenWidth,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: isFromOnboard == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            children: [
              isFromOnboard == true ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.offNamed(Routes.ONBOARDING_FINAL_SCREEN)
              ) : SizedBox.shrink(),
              Text(
                'Masuk Ke Akun',
                style: txtSecondaryHeader.copyWith(
                    fontWeight: FontWeight.w700, color: blackColor),
              ),
              isFromOnboard == true ? Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ) : SizedBox.shrink(),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Selamat datang di BetterU! Buat akun sekarang untuk menikmati semua fitur unggulan kami dan mulai hidup lebih sehat!",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                CommonButton(
                  text: 'Lanjutkan Dengan Email',
                  onPressed: controller.nextPage,
                  width: screenWidth,
                  height: 60,
                  borderRadius: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20),
                //   child: Text(
                //     "Atau Dengan",
                //     style:
                //     txtPrimaryTitle.copyWith(fontWeight: FontWeight.w400),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // CommonButton(
                //   text: '',
                //   icon: Center(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         SvgPicture.asset(
                //           icGoogle,
                //           width: 22,
                //           height: 22,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'Lanjutkan Dengan Google',
                //           style: txtSecondaryTitle.copyWith(
                //               fontWeight: FontWeight.w600, color: blackColor),
                //         ),
                //       ],
                //     ),
                //   ),
                //   onPressed: () {},
                //   width: screenWidth,
                //   height: 60,
                //   borderRadius: 10,
                //   backgroundColor: baseColor,
                //   border:
                //   BorderSide(color: blackColor, style: BorderStyle.solid),
                // ),
              ],
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