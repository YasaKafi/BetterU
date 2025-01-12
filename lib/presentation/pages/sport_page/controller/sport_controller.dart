import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/sport_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/current_user_model.dart';
import '../../../../data/api/model/sport_category_model.dart';
import '../../../../data/api/model/sport_model.dart';

class SportController extends GetxController {

  RxString currentTypePage = 'BASE'.obs;
  RxString currentCategory = ''.obs;
  RxBool isLoadingMain = false.obs;
  RxBool isLoadingSportCategory = false.obs;
  RxBool isLoadingSportRecommendation = false.obs;
  RxBool isLoadingSportByCategory = false.obs;
  RxBool isLoadingSportSearch = false.obs;
  late SportServices sportServices;
  late AuthServices userService;
  late ShowCurrentUserResponse userResponse;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  Rx<SportCategoryModel> sportCategory = Rx<SportCategoryModel>(SportCategoryModel());
  Rx<SportModel> sportRecommendation = Rx<SportModel>(SportModel());
  Rx<SportModel> sportByCategory = Rx<SportModel>(SportModel());
  Rx<SportModel> sportSearch = Rx<SportModel>(SportModel());
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    userService = AuthServices();
    sportServices = SportServices();

    currentTypePage.value = 'BASE';
    isLoadingMain(true);
    isLoadingSportCategory(true);
    isLoadingSportRecommendation(true);

    await getCurrentUser();
    getAllSportCategory();

    if (dataUser.value != null) {
      await getAllSportRecommendation();
    }
  }

  void refresh() {
    initialize();
  }

  Future<void> getCurrentUser() async {
    try {
      isLoadingMain(false);
      final response = await userService.showCurrentUser();
      print("CHECK CURRENT RESPONSE");
      print(response.data);

      if (response.data != null) {
        userResponse = ShowCurrentUserResponse.fromJson(response.data);
        if (userResponse.data!.name != null) {
          dataUser = userResponse.data!.obs;
          print("User data fetched: ${userResponse.data!.name}");
        } else {
          print("User data is null");
        }
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoadingSportSearch(false);
    }
  }

  Future<void> getAllSportCategory() async {
    try {
      isLoadingMain(false);
      currentTypePage.value = 'BASE';
      final response = await sportServices.showAllSportCategory();

      print("CHECK SPORT CATEGORY RESPONSE");
      print(response.data);

      if (response.data != null) {
        final sportData = SportCategoryModel.fromJson(response.data);
        sportCategory.value = sportData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching sport category: $e');
    } finally {
      isLoadingSportCategory(false);
    }
  }

  Future<void> getAllSportRecommendation() async {
    try {
      isLoadingMain(false);
      currentTypePage.value = 'BASE';
      if (dataUser.value != null) {
        final currentUser = dataUser.value!;

        // determine goals
        String goals = '';
        if (currentUser.goals == "Menaikkan Berat Badan" || currentUser.goals == "Menaikkan Berat Badan Ekstrim") {
          goals = "Menaikkan Berat Badan";
        }
        else if (currentUser.goals == "Menurunkan Berat Badan" || currentUser.goals == "Menurunkan Berat Badan Ekstrim") {
          goals = "Menurunkan Berat Badan";
        }

        final response = await sportServices.showAllSportByGoals(
          goals: goals,
        );

        print("CHECK SPORT RECOMMENDATION RESPONSE");
        print(response.data);

        if (response.data != null) {
          final sportData = SportModel.fromJson(response.data);
          sportRecommendation.value = sportData;
        } else {
          print("Response data is null");
        }
      } else {
        print("User data is not available for sport recommendation");
      }
    } catch (e) {
      print('Error fetching sport recommendation data: $e');
    } finally {
      isLoadingSportRecommendation(false);
    }
  }

  Future<void> getAllSportByCategory({required String category}) async {
    try {
      isLoadingMain(false);
      currentTypePage.value = 'CATEGORY';
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

  Future<void> getAllSportSearch() async {
    try {
      isLoadingMain(false);
      currentTypePage.value = 'SEARCH';
      isLoadingSportSearch(true);

      final response = await sportServices.showAllSportBySearch(
        search: searchController.text,
      );

      print("CHECK SPORT SEARCH RESPONSE");
      print(response.data);

      if (response.data != null) {
        final sportData = SportModel.fromJson(response.data);
        sportSearch.value = sportData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching sport search data: $e');
    } finally {
      isLoadingSportSearch(false);
    }
  }

}
