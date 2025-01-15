import 'package:get/get.dart';

import '../controller/sport_category_detail_controller.dart';



class SportCategoryDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportCategoryDetailController>(() => SportCategoryDetailController());
  }
}