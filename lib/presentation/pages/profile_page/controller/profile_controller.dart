import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/api/auth/model/current_user_model.dart';
import '../../../../data/api/auth/model/daily_nutrition_model.dart';
import '../../../../data/api/service/ai_service.dart';
import '../../../../data/api/service/auth_services.dart';
import '../../../../route/app_pages.dart';

class ProfileController extends GetxController {

  RxBool isLoading = false.obs;
  ShowCurrentUserResponse userResponse = ShowCurrentUserResponse();
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  Rx<NutritionInformation> nutritionInformation =
  Rx<NutritionInformation>(NutritionInformation());

  late AuthServices userService;
  late AiServices aiService;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userService = AuthServices();
    aiService = AiServices();
    getCurrentUser();
  }


  Future<void> getCurrentUser() async {
    try {
      isLoading(true);
      final response = await userService.showCurrentUser();
      print("CHECK CURRENT RESPONSE");
      print(response.data);

      if (response.data != null) {
        userResponse = ShowCurrentUserResponse.fromJson(response.data);
        if (userResponse.data!.name != null) {
          dataUser = userResponse.data!.obs;
          print("User data fetched: ${userResponse.data!.name}");
          print("User data gender fetched: ${userResponse.data!.gender}");
        } else {
          print("User data is null");
        }
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteTokenUser() async {
    try {
      final response = await userService.deleteTokenUser();
      print("Token deleted: ${response.data}");
      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.LOGIN_PAGE);
      }
    } catch (e) {
      print('Error deleting token: $e');
    }
  }


  Future<void> putEditProfile({
    required String birthDateController,
    required TextEditingController weightController,
    required TextEditingController heightController,
    required String selectedGoal,
    required String selectedActivity,
}) async {
    try {

        final response = await userService.putEditUser(
          userID: dataUser.value!.id.toString(),
          name: dataUser.value!.name!,
          gender: dataUser.value!.gender!,
          dateOfBirth: birthDateController,
          goals: selectedGoal,
          activityLevel: selectedActivity,
          weight: weightController.text,
          height: heightController.text,
        );

        Get.snackbar("Edit Success", "Your profile has been updated", snackPosition: SnackPosition.TOP);
        getCurrentUser();

        if (selectedGoal != dataUser.value!.goals ||
            selectedActivity != dataUser.value!.activityLevel) {
          Future.delayed(Duration(seconds: 1), () {
            postCalculateNutrition();
          });
        }
    } catch (e) {
      print('Error placing order: $e');
    }
  }

  String formatGender(String gender) {
    return gender.toLowerCase().replaceAll('-', ' ');
  }

  Future<void> postCalculateNutrition() async {
    try {
      if (dataUser.value != null) {
        final currentUser = dataUser.value!;
        final response = await aiService.postCalculateNutrition(
          dateOfBirth: currentUser.dateOfBirth ?? '',
          goals: currentUser.goals ?? '',
          gender: formatGender(currentUser.gender ?? ''),
          activityLevel: currentUser.activityLevel ?? '',
          weight: currentUser.weight.toString() ?? '',
          height: currentUser.height.toString() ?? '',
        );

        nutritionInformation.value =
            NutritionInformation.fromJson(response.data);
        print(
            "Jenis Kelamin: ${nutritionInformation.value.profile?.jenisKelamin}");
        print(
            "Total Kalori: ${nutritionInformation.value.dailyNutrition?.totalKalori}");
      } else {
        print("User data is not available for nutrition calculation");
      }
    } catch (e) {
      print('Error posting nutrition data: $e');
    }
  }

}
