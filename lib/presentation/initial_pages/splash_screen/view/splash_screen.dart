import 'package:better_u/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/theme.dart';
import '../../../../route/app_pages.dart';
import '../controller/splash_controller.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  void _checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    print('PRINT TOKEN AUTH $token');
    print('PRINT TOKEN ONBOARD $hasSeenOnboarding');

    Future.delayed(const Duration(seconds: 2), () {
      if (token != null) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(Routes.BOTTOM_NAVBAR);
        });
      } else if (hasSeenOnboarding == false) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(Routes.ONBOARDING_SCREEN);
        });
      }  else {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(Routes.ONBOARDING_FINAL_SCREEN);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    _checkAuthStatus();

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
