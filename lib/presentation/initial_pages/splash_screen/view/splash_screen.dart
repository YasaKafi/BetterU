import 'package:better_u/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../../route/app_pages.dart';
import '../controller/splash_controller.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.ONBOARDING_SCREEN);
    });
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryColor,
        child: Center(
          child: SvgPicture.asset(icLogoPrimary)
        ),
      ),
    );

  }
}
