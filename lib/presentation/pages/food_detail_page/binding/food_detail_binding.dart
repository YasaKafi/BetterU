import 'package:get/get.dart';

import '../controller/food_detail_controller.dart';

class FoodDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodDetailController>(() => FoodDetailController());
  }
}