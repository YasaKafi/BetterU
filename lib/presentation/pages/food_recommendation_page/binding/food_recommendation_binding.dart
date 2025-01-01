import 'package:get/get.dart';

import '../controller/food_recommendation_controller.dart';

class FoodRecommendationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodRecommendationController>(() => FoodRecommendationController());
  }
}