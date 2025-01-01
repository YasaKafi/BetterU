import 'package:get/get.dart';

import '../controller/sport_controller.dart';



class SportPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportController>(() => SportController());
  }
}