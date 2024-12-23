import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/constant.dart';
import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../controller/onboarding_controller.dart';

class OnboardingFinalScreen extends StatelessWidget {
  OnboardingFinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      Column(
                        children: [
                          Center(child: SvgPicture.asset(icLogoPrimary)),
                          SizedBox(height: Dimensions.marginSizeLarge),
                          Container(
                            width: screenWidth,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Selamat Datang di ",
                                    style: txtPrimaryHeader.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "BetterU",
                                    style: txtPrimaryHeader.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.marginSizeSmall),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Aplikasi kesehatan dan kalori tracker yang di dukung oleh Artifical Intelligence",
                                style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  CommonButton(text: 'Buat Akun Baru', onPressed: () {}, width: screenWidth, height: 60, borderRadius: 10,),
                  TextButton(
                    onPressed: () {},
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sudah punya akun? ',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Masuk',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
