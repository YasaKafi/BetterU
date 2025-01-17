import 'package:better_u/common/theme.dart';
import 'package:better_u/data/api/ai_instance.dart';
import 'package:better_u/data/api/model/show_history_chatbot_model.dart';
import 'package:better_u/data/api/service/nutrition_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api/model/current_combo_model.dart';
import '../../../../data/api/model/current_daily_water_model.dart';
import '../../../../data/api/model/current_total_nutrition_model.dart';
import '../../../../data/api/model/current_user_model.dart';
import '../../../../data/api/model/daily_nutrition_model.dart';
import '../../../../data/api/model/show_history_total_nutrition_model.dart';
import '../../../../data/api/service/ai_service.dart';
import '../../../../data/api/service/auth_services.dart';
import '../../../../route/app_pages.dart';

class ProfileController extends GetxController {
  var currentPage = 0.obs;
  final RxInt currentPageChat = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingResponseAi = false.obs;
  ShowCurrentUserResponse userResponse = ShowCurrentUserResponse();
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  Rx<NutritionInformation> nutritionInformation =
      Rx<NutritionInformation>(NutritionInformation());

  RxList<Map<String, String>> chatList = <Map<String, String>>[].obs;

  TextEditingController userMessageController = TextEditingController();

  Rx<List<ShowHistoryTotalNutrition>> historyTotalNutrition =
      Rx<List<ShowHistoryTotalNutrition>>([]);

  Rx<ShowCurrentCombo> currentCombo = Rx<ShowCurrentCombo>(ShowCurrentCombo());
  Rx<HistoryChatBot> historyChatBot = Rx<HistoryChatBot>(HistoryChatBot());
  Rx<CurrentDailyWater> currentDailyWater =
      Rx<CurrentDailyWater>(CurrentDailyWater());

  Rx<CurrentTotalNutrition> currentTotalNutrition =
      Rx<CurrentTotalNutrition>(CurrentTotalNutrition());

  late AuthServices userService;
  late NutritionServices nutritionServices;
  late AiServices aiService;
  late OpenRouterAPI openRouterAPI;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initialize();
  }


  Future<void> initialize() async {
    userService = AuthServices();
    aiService = AiServices();
    nutritionServices = NutritionServices();
    openRouterAPI = OpenRouterAPI();
    isLoading(true);
    getCurrentUser();
    getHistoryTotalNutrition(filterDate: '');
    getCurrentCombo(date: '');
  }

  void refresh() {
    initialize();
  }

  void hasSeenOnboardingChaBot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboardingChatBot', true);
  }



  Future<void> sendMessage(String userMessage) async {
    isLoadingResponseAi(true);
    const maxRetryCount = 5;
    int retryCount = 0;
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());


    try {
      final newMessage = {
        'sender': 'USER',
        'message': userMessage,
        'createdAt': formattedTime,
      };

      print('Adding new message to chatList: $newMessage');
      chatList.add(newMessage);

      // Post respons AI ke backend
      bool successUser = false;
      retryCount = 0; // Reset retry count
      while (retryCount < maxRetryCount && !successUser) {
        try {
          await aiService.postChatBot(
            message: userMessage,
            sender: 'USER',
            createdAt: formattedTime,
          );
          successUser = true;
        } catch (e) {
          retryCount++;
          if (retryCount == maxRetryCount) {
            throw Exception(
                'Gagal mengirim respons AI setelah $maxRetryCount percobaan');
          }
          await Future.delayed(Duration(seconds: 2));
        }
      }


      String prompt = '''
User bertanya: "${userMessage}"

Tugas Anda:
1. Jika pertanyaan relevan dengan kesehatan, makanan, atau pola hidup sehat, jawab dengan jelas, informatif, dan langsung ke inti.
2. Jika pertanyaan tidak relevan dengan kesehatan atau makanan, hanya berikan respons ini:
   "Maaf, saya hanya dapat membantu pertanyaan yang berkaitan dengan kesehatan atau makanan."
3. Jangan memberikan jawaban tambahan jika Anda memutuskan bahwa pertanyaan tidak relevan.
4. Pastikan respons singkat, sopan, dan sesuai konteks.
'''
          .trim();

      // Panggil AI API untuk mendapatkan respons
      String aiResponse = await openRouterAPI.callChatModel(prompt);

      if (aiResponse.contains(
              "Maaf, saya hanya dapat membantu pertanyaan yang berkaitan dengan kesehatan atau makanan.") &&
          aiResponse.split('\n').length > 1) {
        aiResponse =
            "Maaf, saya hanya dapat membantu pertanyaan yang berkaitan dengan kesehatan atau makanan.";
      }

      final aiMessage = {
        'sender': 'AI',
        'message': aiResponse,
        'createdAt': formattedTime,
      };
      print('Adding AI response to chatList: $aiMessage'); // Debug print
      chatList.add(aiMessage);

      chatList.refresh();  // Add this line


      bool success = false;
      retryCount = 0; // Reset retry count
      while (retryCount < maxRetryCount && !success) {
        try {
          await aiService.postChatBot(
            message: aiResponse,
            sender: 'AI',
            createdAt: DateTime.now().toIso8601String(),
          );
          success = true;
        } catch (e) {
          retryCount++;
          if (retryCount == maxRetryCount) {
            throw Exception(
                'Gagal mengirim respons AI setelah $maxRetryCount percobaan');
          }
          await Future.delayed(Duration(seconds: 2));
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingResponseAi(false);
      userMessageController.clear();
    }
  }

  Future<void> getHistoryChatBot() async {
    try {
      isLoading(true);
      chatList.clear(); // Clear the local chat list when loading history
      final response = await aiService.showHistoryChatBot();

      print("CHECK RESPONSE HISTORY CHAT BOT");
      print(response.data);

      if (response.data != null) {
        final chatBot = HistoryChatBot.fromJson(response.data);
        historyChatBot.value = chatBot;

        // if (chatBot.data != null) {
        //   currentPageChat.value = 1;
        // }

        print(
            "History chat bot fetched : ${chatBot.data?.first.messageData?.first.message}");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');

      Get.snackbar(
        "Kesalahan Jaringan",
        "Terjadi masalah dengan koneksi jaringan. Silakan coba lagi.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: redMedium,
        colorText: baseColor,
        duration: Duration(seconds: 3),
      );

      Get.back();
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCurrentDailyWater({String? date}) async {
    try {
      isLoading(true);
      final response =
          await nutritionServices.showCurrentDailyWaterByDate(date: date ?? '');

      print("CHECK CURRENT RESPONSE COMBO");
      print(response.data);

      if (response.data != null) {
        final dailyWaterData = CurrentDailyWater.fromJson(response.data);
        currentDailyWater.value = dailyWaterData;

        final checkData = dailyWaterData.data?.amount ?? 0.0;

        print("VALUE AMOUNT OF WATER : $checkData");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getHistoryTotalNutrition({String? filterDate}) async {
    try {
      isLoading(true);
      final response = await nutritionServices.showHistoryTotalNutrition(
          filterDate: filterDate);
      print("HISTORY TOTAL NUTRITION");
      print(response.data);

      if (response.data != null) {
        // Parsing respons menjadi List<ShowHistoryTotalNutrition>
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final List<ShowHistoryTotalNutrition> historyList = jsonList
            .map((item) => ShowHistoryTotalNutrition.fromJson(item))
            .toList();

        // Simpan hasil ke Rx
        historyTotalNutrition.value = historyList;

        print(
            "History total nutrition fetched, first date: ${historyList.first.date}");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching history total nutrition: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCurrentCombo({String? date}) async {
    try {
      isLoading(true);
      final response =
          await nutritionServices.showCurrentCombo(date: date, isHistory: true);

      print("CHECK CURRENT RESPONSE COMBO");
      print(response.data);

      if (response.data != null) {
        final comboData = ShowCurrentCombo.fromJson(response.data);
        currentCombo.value = comboData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDaysTotalNutrition({String? date}) async {
    try {
      isLoading(true);
      final response = await nutritionServices.showCurrentTotalNutrition(
          date: date, isHistory: true);

      print("CHECK CURRENT RESPONSE COMBO");
      print(response.data);

      if (response.data != null) {
        final nutritionData = CurrentTotalNutrition.fromJson(response.data);
        currentTotalNutrition.value = nutritionData;
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading(false);
    }
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
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Get.offAllNamed(Routes.ONBOARDING_FINAL_SCREEN);
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

      Get.snackbar("Edit Success", "Your profile has been updated",
          snackPosition: SnackPosition.TOP);
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
