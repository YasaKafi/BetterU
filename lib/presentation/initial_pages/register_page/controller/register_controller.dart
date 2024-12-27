import 'dart:async';

import 'package:better_u/data/api/service/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../route/app_pages.dart';

class RegisterController extends GetxController {

  var isLoading = false.obs;
  var isResendingOtp = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(validatePassword);
  }

  @override
  void onClose() {
    passwordController.dispose();
    otpNumberController.dispose();
    usernameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    weightController.dispose();
    heightController.dispose();
    timer?.cancel();
    super.onClose();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController otpNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  var selectedGender = 'Laki-laki'.obs;
  var selectedGoal = 'Menurunkan Berat Badan'.obs;
  var selectedActivity = 'Sangat Jarang Beraktivitas'.obs;

  // Observable untuk validasi password
  final isMinLength = false.obs;
  final hasNumber = false.obs;
  final hasSymbol = false.obs;

  // Menghitung progress berdasarkan validasi
  double get progress {
    int rulesPassed = 0;
    if (isMinLength.value) rulesPassed++;
    if (hasNumber.value) rulesPassed++;
    if (hasSymbol.value) rulesPassed++;
    return rulesPassed / 3; // Total 3 aturan
  }

  Color get progressBarColor {
    int rulesPassed = 0;
    if (isMinLength.value) rulesPassed++;
    if (hasNumber.value) rulesPassed++;
    if (hasSymbol.value) rulesPassed++;

    if (rulesPassed == 1) return Colors.red;
    if (rulesPassed == 2) return Colors.yellow;
    return Colors.green; // Semua validasi terpenuhi
  }

  var timeRemaining = 0.obs;
  Timer? timer;

  void startTimer(String createdAt, String expiredAt) {
    final createdTime = DateTime.parse(createdAt);
    final expiredTime = DateTime.parse(expiredAt);
    timeRemaining.value = expiredTime.difference(createdTime).inSeconds;

    timer?.cancel(); // Pastikan timer sebelumnya dihentikan
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timer.cancel();
        timeRemaining.value = 0; // Untuk memastikan teks berubah ke "Kirim ulang"
      }
    });
  }




  void validatePassword() {
    final text = passwordController.text;
    isMinLength.value = text.length >= 8;
    hasNumber.value = text.contains(RegExp(r'\d'));
    hasSymbol.value = text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void validateAndProceed() {
    if (isMinLength.value && hasNumber.value && hasSymbol.value) {
      nextPage(); // Jika validasi terpenuhi, pindah halaman
    } else {
      Get.snackbar(
        "Password Invalid",
        "Password harus memenuhi semua kriteria",
        snackPosition: SnackPosition.TOP,
      );
    }
  }


  void validateBiodata() {
    if (usernameController.text.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Nama panggilan tidak boleh kosong.",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (birthDateController.text.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Tanggal lahir tidak boleh kosong.",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (selectedGender.value.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Pilih jenis kelamin terlebih dahulu.",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    nextPage();
  }

  void validateTbBb() {
    if (weightController.text.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Berat badan tidak boleh kosong.",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (heightController.text.isEmpty) {
      Get.snackbar(
        "Input Kosong",
        "Tinggi badan tidak boleh kosong.",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    nextPage();
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void selectGoal(String goal) {
    selectedGoal.value = goal;
  }

  void selectActivity(String activity) {
    selectedActivity.value = activity;
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

  final AuthServices authServices = AuthServices();

  Future<void> postRegister() async {
    validateTbBb();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (heightController.text.isNotEmpty &&
          weightController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          birthDateController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          selectedGoal.value.isNotEmpty &&
          selectedGender.value.isNotEmpty &&
          selectedActivity.value.isNotEmpty
      ) {
          final response = await authServices.postRegister(
            name: usernameController.text,
            email: emailController.text,
            password: passwordController.text,
            dateOfBirth: birthDateController.text,
            goals: selectedGoal.value,
            gender: selectedGender.value,
            activityLevel: selectedActivity.value,
            weight: weightController.text,
            height: heightController.text,
          );

          prefs.setString('token', response.data['token']);
          Get.snackbar("Login Success", "Welcome to Better U",
              snackPosition: SnackPosition.TOP);
          Get.offNamed(Routes.ONBOARDING_FINAL_SCREEN);

      } else {
        Get.snackbar(
            "Please fill in all required fields", "Please checking your field",
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Error placing order: $e');
    }
  }

  String? createdAt;
  String? expiredAt;

  Future<void> postOtpCode() async {
    try {
      if (emailController.text.isNotEmpty) {
        isLoading.value = true;
        final response = await authServices.postOtpCode(
          email: emailController.text,
        );

        createdAt = response.data['data']['created_at'];
        expiredAt = response.data['data']['expired_at'];

        Get.snackbar(
          "Success Send OTP",
          "get otp code and input your code",
          snackPosition: SnackPosition.TOP,
        );

        if (createdAt != null && expiredAt != null) {
          startTimer(createdAt!, expiredAt!);
        }
        if (currentPage.value == 1) {
          nextPage();
        }
      } else {
        Get.snackbar(
          "Please fill in all required fields",
          "Please checking your field",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error placing order: $e');
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }

  Future<void> resendOtpCode() async {
    try {
      isResendingOtp.value = true; // Mulai loading overlay
      final response = await authServices.postOtpCode(
        email: emailController.text,
      );

      createdAt = response.data['data']['created_at'];
      expiredAt = response.data['data']['expired_at'];

      Get.snackbar(
        "OTP Sent",
        "A new OTP has been sent to your email.",
        snackPosition: SnackPosition.TOP,
      );

      if (createdAt != null && expiredAt != null) {
        startTimer(createdAt!, expiredAt!);
      }
    } catch (e) {
      print('Error resending OTP: $e');
    } finally {
      isResendingOtp.value = false; // Selesai loading overlay
    }
  }

  Future<void> postOtpCheck() async {
    try {
      if (otpNumberController.text.isNotEmpty) {
        isLoading.value = true;
        final response = await authServices.postOtpCheck(
          email: emailController.text,
          otp: otpNumberController.text,
        );


        Get.snackbar(
          "Berhasil diverifikasi",
          "lanjut isi password",
          snackPosition: SnackPosition.TOP,
        );

          nextPage();

      } else {
        Get.snackbar(
          "Please fill in all required fields",
          "Please checking your field",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error : $e');
      Get.snackbar(
        "Failed to verify OTP",
        'Please check your OTP code',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
