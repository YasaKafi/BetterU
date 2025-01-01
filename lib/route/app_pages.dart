import 'package:better_u/presentation/initial_pages/onboarding_screen/binding/onboarding_binding.dart';
import 'package:better_u/presentation/initial_pages/onboarding_screen/view/onboarding_final_screen.dart';
import 'package:better_u/presentation/initial_pages/onboarding_screen/view/onboarding_screen.dart';
import 'package:better_u/presentation/initial_pages/register_page/binding/register_binding.dart';
import 'package:better_u/presentation/initial_pages/register_page/view/register_page.dart';
import 'package:better_u/presentation/pages/food_recommendation_page/binding/food_recommendation_binding.dart';
import 'package:better_u/presentation/pages/food_recommendation_page/view/food_recommendation_page.dart';
import 'package:get/get.dart';

import '../presentation/initial_pages/splash_screen/view/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();


  static const INITIAL = Routes.FOOD_RECOMMENDATION_PAGE;

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
    GetPage(
        name: _Paths.REGISTER_PAGE,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: _Paths.FOOD_RECOMMENDATION_PAGE,
        page: () => FoodRecommendationPage(),
        binding: FoodRecommendationBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)
    ),
  ];
}
