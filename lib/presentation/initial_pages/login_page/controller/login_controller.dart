import 'dart:async';

import 'package:better_u/data/api/service/ai_service.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api/auth/model/daily_nutrition_model.dart';
import '../../../../route/app_pages.dart';

class LoginController extends GetxController {

  var isLoading = false.obs;

  @override
  void onClose() {
    passwordController.dispose();
    emailController.dispose();
    super.onClose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  void goToHomePage() {
    Get.offNamed(Routes.BOTTOM_NAVBAR);
  }


  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 8) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void registerUser() {
    Get.snackbar("Success", "Akun berhasil dibuat!");
  }

  String formatGender(String gender) {
    return gender.toLowerCase().replaceAll('-', ' ');
  }

  final AuthServices authServices = AuthServices();
  final AiServices aiServices = AiServices();

  Future<void> postLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading(true);
    try {
      if (passwordController.text.isNotEmpty &&
          emailController.text.isNotEmpty
      ) {

          final response = await authServices.postLogin(
            email: emailController.text,
            password: passwordController.text,
          );


            prefs.setString('token', response.data['token']);
            Get.snackbar("Login Success", "Welcome to Better U",
                snackPosition: SnackPosition.TOP);
            Get.offNamed(Routes.BOTTOM_NAVBAR);


      } else {
        Get.snackbar(
            "Please fill in all required fields", "Please checking your field",
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception: ', '');
      print('Error placing order: $e');
      Get.snackbar("Error", "$errorMessage",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading(false);
    }
  }


}
