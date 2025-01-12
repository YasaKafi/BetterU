import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';
import '../controller/onboarding_controller.dart';
import '../model/onboard_data.dart';
import '../widgets/item_pageview.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    controller.onPageChanged(index);
                  },
                  itemCount: onboard_data.length,
                  controller: controller.pageController,
                  itemBuilder: (context, index) =>
                      ItemOnBoarding(
                        imgBoarding: onboard_data[index].image,
                        titleBoarding: onboard_data[index].text,
                        subtitleBoarding: onboard_data[index].description,
                        screenWidth: screenWidth,
                        index: index,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SmoothPageIndicator(
                          controller: controller.pageController,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            dotColor: greytxtNote,
                            activeDotColor: primaryColor,
                            dotHeight: 8,
                            dotWidth: 6,
                            spacing: 10,
                            expansionFactor: 4,
                          )
                      ),
                      TextButton(
                          onPressed: () {
                            controller.skipOnboarding();
                          },
                          child: Text(
                            'Skip',
                            style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor, ),
                          )),
                    ],
                  ),
                  Obx(() {
                    double progress = (controller.pageIndex.value + 1) / 3;
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progress),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                backgroundColor: primaryColor.withOpacity(0.2),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: primaryColor,
                              child: IconButton(
                                onPressed: () => controller.onPressedButton(),
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: baseColor,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
