import 'package:better_u/presentation/pages/food_page/controller/food_controller.dart';
import 'package:get/get.dart';



class FoodPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodController>(() => FoodController());
  }
}