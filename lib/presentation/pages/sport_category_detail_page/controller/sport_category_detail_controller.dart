import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/sport_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/current_user_model.dart';
import '../../../../data/api/model/sport_category_model.dart';
import '../../../../data/api/model/sport_model.dart';

class SportCategoryDetailController extends GetxController {

  RxString currentCategory = ''.obs;
  RxBool isLoadingMain = false.obs;
  RxBool isLoadingSportByCategory = false.obs;
  late SportServices sportServices;
  Rx<SportModel> sportByCategory = Rx<SportModel>(SportModel());

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    sportServices = SportServices();

    // Get arguments from previous page
    final arguments = Get.arguments as Map<String, dynamic>;
    currentCategory.value = arguments['category'];

    isLoadingMain(true);
    isLoadingSportByCategory(true);

    await getAllSportByCategory(category: currentCategory.value);
  }

  void refresh() {
    initialize();
  }

  Future<void> getAllSportByCategory({required String category}) async {
    try {
      isLoadingMain(false);
      final response = await sportServices.showAllSportByCategory(
        category: category,
      );

      print("CHECK SPORT BY CATEGORY RESPONSE");
      print(response.data);

      if (response.data != null) {
        final sportData = SportModel.fromJson(response.data);
        sportByCategory.value = sportData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching sport by category data: $e');
    } finally {
      isLoadingSportByCategory(false);
    }
  }

}
