part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const BOTTOM_NAVBAR = _Paths.BOTTOM_NAVBAR;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const ONBOARDING_SCREEN = _Paths.ONBOARDING_SCREEN;
  static const ONBOARDING_FINAL_SCREEN = _Paths.ONBOARDING_FINAL_SCREEN;
}

abstract class _Paths {
  _Paths._();

  static const BOTTOM_NAVBAR = '/bottom-navbar';
  static const SPLASH_SCREEN = '/splash-screen';
  static const ONBOARDING_SCREEN = '/onboarding-screen';
  static const ONBOARDING_FINAL_SCREEN = '/onboarding-final-screen';


}
