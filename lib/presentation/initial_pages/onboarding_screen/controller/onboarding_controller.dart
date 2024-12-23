
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../route/app_pages.dart';


class OnBoardingController extends GetxController{

  late PageController pageController;
  RxInt pageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void changePage(int index) {
    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void nextPage() {
    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void skipOnboarding() {
    Get.offAllNamed(Routes.ONBOARDING_FINAL_SCREEN);
  }

  void onPressedButton() {
    if (pageIndex.value == 2) {
      Get.offAllNamed(Routes.ONBOARDING_FINAL_SCREEN);
    } else {
      nextPage();
    }
  }

  void onPageChanged(int index) {
    pageIndex.value = index;
  }

}