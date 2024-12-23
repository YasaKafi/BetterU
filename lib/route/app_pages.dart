import 'package:better_u/presentation/initial_pages/onboarding_screen/binding/onboarding_binding.dart';
import 'package:better_u/presentation/initial_pages/onboarding_screen/view/onboarding_final_screen.dart';
import 'package:better_u/presentation/initial_pages/onboarding_screen/view/onboarding_screen.dart';
import 'package:get/get.dart';

import '../presentation/initial_pages/splash_screen/view/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();


  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    // GetPage(
    //     name: _Paths.BOTTOM_NAVBAR,
    //     bindings: [
    //       HomePageBinding(),
    //       MenuBinding(),
    //       OrderBinding(),
    //       ProfileBinding()
    //     ],
    //     page: () => BottomNavigationBarCustom(),
    //     transition: Transition.fadeIn,
    //     transitionDuration: const Duration(milliseconds: 500)),

    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => SplashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: _Paths.ONBOARDING_SCREEN,
        binding: OnBoardingBinding(),
        page: () => OnboardingScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: _Paths.ONBOARDING_FINAL_SCREEN,
        page: () => OnboardingFinalScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)
    ),
  ];
}
