import 'package:get/get.dart';

import '../../../../route/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.ONBOARDING_SCREEN);
    });
  }

}