import 'package:better_u/data/api/service/food_service.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/food_model.dart';

class FoodDetailController extends GetxController {

  RxBool isLoading = false.obs;
  late FoodServices foodServices;
  Rx<FoodModel> food= Rx<FoodModel>(FoodModel());
  RxString foodId = ''.obs;


  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading(true);

    // Get arguments from previous page
    final arguments = Get.arguments as Map<String, dynamic>;
    foodId.value = arguments['id'];

    foodServices = FoodServices();
    getFoodById();
  }

  void refresh() {
    initialize();
  }

  Future<void> getFoodById() async {
    try {
      final response = await foodServices.showFoodById(id: foodId.value);

      print("CHECK FOOD RESPONSE");
      print(response.data);

      if (response.data != null) {
        final foodData = FoodModel.fromJson(response.data);
        food.value = foodData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching food data: $e');
    } finally {
      isLoading(false);
    }
  }
}