import 'dart:convert';

import 'package:better_u/data/api/ai_instance.dart';
import 'package:better_u/data/api/auth/model/current_combo_model.dart';
import 'package:better_u/data/api/auth/model/current_total_nutrition_model.dart';
import 'package:better_u/data/api/auth/model/nutrition_information.dart';
import 'package:better_u/data/api/service/ai_service.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/nutrition_service.dart';
import 'package:better_u/presentation/pages/home_page/widget/bottom_sheet_eat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api/auth/model/current_user_model.dart';
import '../../../../data/api/auth/model/daily_nutrition_model.dart';



class HomeController extends GetxController {

  RxBool isLoading = false.obs;
  late AuthServices userService;
  late NutritionServices nutritionServices;
  late AiServices aiService;
  late ShowCurrentUserResponse userResponse;
  late OpenRouterAPI openRouterAPI;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);

  TextEditingController foodController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController lemakController = TextEditingController();
  TextEditingController karboController = TextEditingController();


  TextEditingController userMessageController = TextEditingController();

  Rx<NutritionInformation> nutritionInformation = Rx<NutritionInformation>(NutritionInformation());
  Rx<NutritionInformationFromAI> nutritionInformationFromAI = Rx<NutritionInformationFromAI>(NutritionInformationFromAI());
  Rx<CurrentTotalNutrition> currentTotalNutrition = Rx<CurrentTotalNutrition>(CurrentTotalNutrition());
  Rx<ShowCurrentCombo> currentCombo = Rx<ShowCurrentCombo>(ShowCurrentCombo());

  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi initialize() yang menampung inisialisasi
    initialize();
  }

  // Fungsi inisialisasi untuk fetch data dan proses lainnya
  Future<void> initialize() async {
    userService = AuthServices();
    aiService = AiServices();
    nutritionServices = NutritionServices();
    openRouterAPI = OpenRouterAPI();

    // Memanggil getCurrentUser untuk mendapatkan data user
    await getCurrentUser();

    // Jika sudah mendapatkan data user, maka lakukan perhitungan dan ambil data terkait
    if (dataUser.value != null) {
      await postCalculateNutrition();
      await getCurrentTotalNutrition();
      await getCurrentCombo();


    }
  }

  String getGreeting() {
    final jakartaTimeZone = Duration(hours: 7);  // WIB adalah UTC +7
    final nowInJakarta = DateTime.now().toUtc().add(jakartaTimeZone);

    final hour = nowInJakarta.hour;

    if (hour >= 5 && hour < 10) {
      return 'Selamat Pagi';
    } else if (hour >= 10 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }


  Future<void> postChatModel(BuildContext context) async {
    try {
      // Nama makanan dari user input
      final String userMessage = userMessageController.text.trim();

      // Prompt yang digunakan untuk AI
      String prompt = '''
      Berikan informasi tentang komposisi nutrisi makanan berikut: "$userMessage". 
      Isikan field berikut dengan nilai fix:
      - Kalori: Kkal
      - Protein: gram
      - Lemak: gram
      - Karbohidrat: gram
      Catatan untuk anda: Sertakan saran mengarah ke kesehatan yang berkaitan dengan kesehatan untuk makanan ini dengan 1 paragraf saja.
    '''
          .trim();

      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);

      // Validasi response dan parsing data
      if (response != null) {
        final Map<String, dynamic> parsedData = parseAiResponse(response);

        if (parsedData.isNotEmpty) {
          nutritionInformationFromAI.value = NutritionInformationFromAI(
            kalori: parsedData['kalori'] ?? 0,
            protein: parsedData['protein'] ?? 0,
            lemak: parsedData['lemak'] ?? 0,
            karbohidrat: parsedData['karbohidrat'] ?? 0,
            catatan: parsedData['catatan'] ?? 'Tidak ada catatan.',
          );

          print('Nutrition Data: ${nutritionInformationFromAI.value}');
          print('Nutrition Data Kalori: ${nutritionInformationFromAI.value.kalori}');



          // Tampilkan hasil ke Bottom Sheet
          Get.bottomSheet(
            buildBottomSheetContentEat(context, nutritionInformationFromAI.value),
          );
        } else {
          print('Data dari AI tidak sesuai atau kosong.');
        }
      }
    } catch (e) {
      print('Error posting chat model: $e');
    }
  }

// Fungsi untuk mem-parsing response AI ke dalam Map
  Map<String, dynamic> parseAiResponse(String response) {
    try {
      // Cek apakah response mengandung konten yang diinginkan
      if (response.isNotEmpty) {
        // Ekspresi reguler untuk mencari data nutrisi
        final kaloriPattern = RegExp(r'Kalori:\s*([\d\.,]+)\s*Kkal');
        final proteinPattern = RegExp(r'Protein:\s*([\d\.,]+)\s*gram');
        final lemakPattern = RegExp(r'Lemak:\s*([\d\.,]+)\s*gram');
        final karbohidratPattern = RegExp(r'Karbohidrat:\s*([\d\.,]+)\s*gram');
        final catatanPattern = RegExp(r'Catatan:\s*([^.]+)\.');

        // Mencari nilai berdasarkan ekspresi reguler
        final kaloriMatch = kaloriPattern.firstMatch(response);
        final proteinMatch = proteinPattern.firstMatch(response);
        final lemakMatch = lemakPattern.firstMatch(response);
        final karbohidratMatch = karbohidratPattern.firstMatch(response);
        final catatanMatch = catatanPattern.firstMatch(response);

        // Mengambil nilai dari match dan mengubahnya menjadi tipe data yang sesuai
        return {
          'kalori': kaloriMatch != null ? double.parse(kaloriMatch.group(1)!) : 0,
          'protein': proteinMatch != null ? double.parse(proteinMatch.group(1)!) : 0,
          'lemak': lemakMatch != null ? double.parse(lemakMatch.group(1)!) : 0,
          'karbohidrat': karbohidratMatch != null ? double.parse(karbohidratMatch.group(1)!) : 0,
          'catatan': catatanMatch != null ? catatanMatch.group(1)! : 'Tidak ada catatan.',
        };
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {};  // Jika parsing gagal, kembalikan Map kosong
  }




  // Fetch current user and trigger postCalculateNutrition after 1 second
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

  Future<void> getCurrentTotalNutrition() async {
    try {
      isLoading(true);
      final response = await nutritionServices.showCurrentTotalNutrition();

      print("CHECK CURRENT RESPONSE");
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

  Future<void> getCurrentCombo() async {
    try {
      isLoading(true);
      final response = await nutritionServices.showCurrentCombo();

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

  String formatGender(String gender) {
    return gender.toLowerCase().replaceAll('-', ' ');
  }


  Future<void> deleteDailyActivity(int dailyActivityID) async {
    try {
      isLoading(true);
      final response = await nutritionServices.deleteDailyActivity(dailyActivityID);

      print("CHECK DELETE DAILY ACTIVITY RESPONSE");
      print(response.data);

      if (response.data != null) {
        print("Daily activity deleted successfully");
        refresh();
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error deleting daily activity: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> putDailyActivity(
      int dailyActivityID,
      String name,
      String category,
      String kalori,
      String? lemak,
      String? protein,
      String? karbohidrat,
      ) async {
    try {
      isLoading(true);
      final response = await nutritionServices.putDailyActivity(
        name: name,
        category: category,
        kalori: kalori,
        lemak: lemak ?? '',
        protein: protein ?? '',
        karbohidrat: karbohidrat ?? '',
        dailyActivityID: dailyActivityID,
      );

      print("CHECK PUT DAILY ACTIVITY RESPONSE");
      print(response.data);

      if (response.data != null) {
        print("Daily activity added successfully");
        Get.back();
        refresh();
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error adding daily activity: $e');
    } finally {
      isLoading(false);
    }
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

        nutritionInformation.value = NutritionInformation.fromJson(response.data);
        print("Jenis Kelamin: ${nutritionInformation.value.profile?.jenisKelamin}");
        print("Total Kalori: ${nutritionInformation.value.dailyNutrition?.totalKalori}");
      } else {
        print("User data is not available for nutrition calculation");
      }
    } catch (e) {
      print('Error posting nutrition data: $e');
    }
  }

  void refresh() {
    initialize();
  }
}


