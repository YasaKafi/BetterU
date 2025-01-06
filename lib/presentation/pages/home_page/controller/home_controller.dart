import 'dart:convert';
import 'dart:io';

import 'package:better_u/data/api/ai_instance.dart';
import 'package:better_u/data/api/auth/model/current_combo_model.dart';
import 'package:better_u/data/api/auth/model/current_total_nutrition_model.dart';
import 'package:better_u/data/api/auth/model/nutrition_information.dart';
import 'package:better_u/data/api/auth/model/prediction_ai_model.dart';
import 'package:better_u/data/api/service/ai_service.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/nutrition_service.dart';
import 'package:better_u/presentation/pages/home_page/widget/bottom_sheet_eat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/auth/model/current_user_model.dart';
import '../../../../data/api/auth/model/daily_nutrition_model.dart';
import '../widget/bottom_sheet_sport.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  late AuthServices userService;
  late NutritionServices nutritionServices;
  late AiServices aiService;
  late ShowCurrentUserResponse userResponse;
  late OpenRouterAPI openRouterAPI;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  RxString responsePredict = ''.obs;


  TextEditingController foodController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController lemakController = TextEditingController();
  TextEditingController karboController = TextEditingController();

  TextEditingController userMessageController = TextEditingController();
  TextEditingController userMessageActivityController = TextEditingController();

  Rx<NutritionInformation> nutritionInformation =
      Rx<NutritionInformation>(NutritionInformation());

  Rx<NutritionInformationFromAI> nutritionInformationFromAI =
      Rx<NutritionInformationFromAI>(NutritionInformationFromAI());

  Rx<CurrentTotalNutrition> currentTotalNutrition =
      Rx<CurrentTotalNutrition>(CurrentTotalNutrition());

  Rx<ShowCurrentCombo> currentCombo = Rx<ShowCurrentCombo>(ShowCurrentCombo());

  Rx<ShowPrediction> currentPrediction = Rx<ShowPrediction>(ShowPrediction());

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    foodController.dispose();
    kaloriController.dispose();
    proteinController.dispose();
    lemakController.dispose();
    karboController.dispose();
    userMessageController.dispose();
    userMessageController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

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

  final ImagePicker _picker = ImagePicker();
  Rxn<XFile> selectedImage = Rxn<XFile>(); // Untuk menyimpan gambar yang dipilih


  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil gambar dari kamera');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil gambar dari galeri');
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              Image.asset(
                gifSearchLoading,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 20),
              Text("Processing..."),
            ],
          ),
        );
      },
    );
  }

  String formatGender(String gender) {
    return gender.toLowerCase().replaceAll('-', ' ');
  }

  String getGreeting() {
    final jakartaTimeZone = Duration(hours: 7); // WIB adalah UTC +7
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


  /// POST ///

  Future<void> postPredictAndAnalyzeFood(BuildContext context) async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Tidak ada gambar yang dipilih.');
      return;
    }

    try {
      showLoadingDialog(context);

      // Step 1: Prediksi makanan
      final File file = File(selectedImage.value!.path);
      final response = await nutritionServices.postPredict(file: file);

      print("CHECK PREDICT FOOD RESPONSE");
      print(response.data);

      if (response.data != null) {
        currentPrediction.value = ShowPrediction.fromJson(response.data);
        responsePredict.value = currentPrediction.value.prediction ?? '';

        print("Prediction: ${currentPrediction.value.prediction}");

        Get.snackbar(
          "Berhasil",
          "Prediksi makanan berhasil dikirim",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Step 2: Analisis nutrisi berdasarkan prediksi
        await postChatModelAnalisisFood(context, isPredict: true);

      } else {
        Get.snackbar('Error', 'Response data is null.');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Gagal memproses makanan.');
    }
  }

  Future<void> postPredictFood() async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Tidak ada gambar yang dipilih.');
      return;
    }

    try {
      isLoading(true); // Tampilkan loading
      final File file = File(selectedImage.value!.path);

      // Panggil `postPredict` dari `nutritionServices`
      final response = await nutritionServices.postPredict(file: file);

      print("CHECK PREDICT FOOD RESPONSE");
      print(response.data);

      if (response.data != null) {

        currentPrediction.value = ShowPrediction.fromJson(response.data);

        print("Prediction: ${currentPrediction.value.prediction}");

        responsePredict.value = currentPrediction.value.prediction ?? '';

        Get.snackbar(
          "Berhasil",
          "Prediksi makanan berhasil dikirim",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', 'Response data is null.');
      }
    } catch (e) {
      print('Error posting predict food: $e');
      Get.snackbar('Error', 'Gagal memposting prediksi makanan.');
    } finally {
      isLoading(false); // Sembunyikan loading
    }
  }

  Future<void> postChatModelAnalisisFood(BuildContext context, {bool? isPredict = false}) async {
    try {
      // Nama makanan dari user input

      final String userMessage = isPredict == true ? responsePredict.value : userMessageController.text.trim();

      // Prompt yang digunakan untuk AI
      String prompt = '''
Berikan informasi tentang komposisi nutrisi makanan berikut: "$userMessage". 
Formatkan respons Anda dalam JSON dengan struktur berikut:
{
  "kalori": "Jumlah kalori dalam Kkal",
  "protein": "Jumlah protein dalam gram",
  "lemak": "Jumlah lemak dalam gram",
  "karbohidrat": "Jumlah karbohidrat dalam gram",
  "catatan": "Saran kesehatan untuk makanan ini dan sebutkan efek bagi tubuh jika makanan ini menurut kesehatan ini tidak baik , berupa 1 paragraf"
}
Pastikan untuk hanya memberikan data dalam format JSON tanpa penjelasan tambahan.
'''
          .trim();

      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);

      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {
        print('Raw AI Response: $response');

        final Map<String, dynamic> parsedData =
            parseAiResponseAnalisisFood(response);

        String capitalizeEachWord(String input) {
          return input.split(' ').map((word) {
            return toBeginningOfSentenceCase(word.toLowerCase()) ?? word;
          }).join(' ');
        }

        if (parsedData.isNotEmpty) {
          // Simpan data ke dalam model
          nutritionInformationFromAI.value = NutritionInformationFromAI(
            name: capitalizeEachWord(userMessage),
            kalori: parsedData['kalori'] ?? 0,
            protein: parsedData['protein'] ?? 0,
            lemak: parsedData['lemak'] ?? 0,
            karbohidrat: parsedData['karbohidrat'] ?? 0,
            catatan: parsedData['catatan'] ?? 'Tidak ada catatan.',
          );

          // Debug output
          print('Nutrition Data Kalori: ${nutritionInformationFromAI.value.kalori}');
          print('Nutrition Data Name: ${nutritionInformationFromAI.value.name}');
          print('Nutrition Data Lemak: ${nutritionInformationFromAI.value.lemak}');
          print('Nutrition Data Karbo: ${nutritionInformationFromAI.value.karbohidrat}');
          print('Nutrition Data Protein: ${nutritionInformationFromAI.value.protein}');
          print('Nutrition Data Note: ${nutritionInformationFromAI.value.catatan}');

          if (isPredict == true) {
          Navigator.pop(context);
          }

          // Tampilkan hasil ke Bottom Sheet
          Get.bottomSheet(
            Builder(
              builder: (BuildContext context) {
                return buildBottomSheetContentEat(context, nutritionInformationFromAI.value);
              },
            ),
            isScrollControlled: true,
          );

        } else {
          print('Data dari AI tidak sesuai atau kosong.');
        }
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> postChatModelAnalisisActivity(BuildContext context) async {
    try {
      // Nama makanan dari user input
      final String userMessage = userMessageActivityController.text.trim();

      // Prompt yang digunakan untuk AI
      String prompt = '''
Berikan informasi tentang komposisi aktivitas olahraga berikut: "$userMessage". 
Formatkan respons Anda dalam JSON dengan struktur berikut:
{
  "kalori": "Jumlah kalori terbakar dalam Kkal",
  "catatan": "Saran kesehatan untuk olahraga ini dan sebutkan efek bagi tubuh jika melakukan olahraga ini baik atau buruk , berupa 1 paragraf",
}
Pastikan untuk hanya memberikan data dalam format JSON tanpa penjelasan tambahan tolong tambahkan tag penutup -> }.
'''
          .trim();

      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);

      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {
        print('Raw AI Response: $response');

        final Map<String, dynamic> parsedData =
            parseAiResponseAnalisisActivity(response);

        String capitalizeEachWord(String input) {
          return input.split(' ').map((word) {
            return toBeginningOfSentenceCase(word.toLowerCase()) ?? word;
          }).join(' ');
        }

        if (parsedData.isNotEmpty) {
          // Simpan data ke dalam model
          nutritionInformationFromAI.value = NutritionInformationFromAI(
            name: capitalizeEachWord(userMessage),
            kalori: parsedData['kalori'] ?? 0,
            catatan: parsedData['catatan'] ?? 'Tidak ada catatan.',
          );

          // Debug output
          print('Nutrition Data Kalori: ${parsedData['kalori']}');
          print('Nutrition Data: ${nutritionInformationFromAI.value}');

          // Tampilkan hasil ke Bottom Sheet
          Get.bottomSheet(
            isScrollControlled: true,
            buildBottomSheetContentActivity(
                context, nutritionInformationFromAI.value),
          );
        } else {
          print('Data dari AI tidak sesuai atau kosong.');
        }
      }
    } catch (e, s) {
      print('Error posting chat model: $e');
      print('Stack Trace: $s');
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

// Fungsi untuk mem-parsing response AI ke dalam Map
  Map<String, dynamic> parseAiResponseAnalisisFood(String response) {
    try {
      final parsedResponse = jsonDecode(response) as Map<String, dynamic>;

      // Fungsi untuk menghitung rata-rata dari rentang string
      int parseRange(String? value) {
        if (value == null) return 0; // Nilai default jika data null
        final match = RegExp(r'(\d+)-(\d+)').firstMatch(value);
        if (match != null) {
          final min = int.parse(match.group(1)!);
          final max = int.parse(match.group(2)!);
          return ((min + max) / 2)
              .round(); // Hitung rata-rata dan bulatkan ke int
        }
        // Jika tidak ada rentang, coba parsing angka langsung
        return int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
      }

      return {
        'kalori': parseRange(parsedResponse['kalori']),
        'protein': parseRange(parsedResponse['protein']),
        'lemak': parseRange(parsedResponse['lemak']),
        'karbohidrat': parseRange(parsedResponse['karbohidrat']),
        'catatan': parsedResponse['catatan'] ?? 'Tidak ada catatan.',
      };
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }

  Map<String, dynamic> parseAiResponseAnalisisActivity(String response) {
    try {
      // Parsing respons utama dari AI
      final parsedResponse = jsonDecode(response) as Map<String, dynamic>;

      // Fungsi untuk menghitung rata-rata dari rentang string
      int parseRange(String? value) {
        if (value == null) return 0; // Nilai default jika data null
        final match = RegExp(r'(\d+)-(\d+)').firstMatch(value);
        if (match != null) {
          final min = int.parse(match.group(1)!);
          final max = int.parse(match.group(2)!);
          return ((min + max) / 2)
              .round(); // Hitung rata-rata dan bulatkan ke int
        }
        // Jika tidak ada rentang, coba parsing angka langsung
        return int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
      }

      // Kembalikan hasil parsing
      return {
        'kalori': parseRange(parsedResponse['kalori']),
        'catatan': parsedResponse['catatan'] ?? 'Tidak ada catatan.',
      };
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }


  /// GET ///

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


  /// DELETE ///

  Future<void> deleteDailyActivity(int dailyActivityID) async {
    try {
      isLoading(true);
      final response =
          await nutritionServices.deleteDailyActivity(dailyActivityID);

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


  /// PUT ///

  Future<void> postDailyActivity(
      {required category,
      required String name,
      required String kalori,
       String? lemak,
       String? protein,
       String? karbohidrat,
      required String note}) async {
    try {
      isLoading(true);
      final response = await nutritionServices.postDailyActivity(
        name: name,
        category: category,
        kalori: kalori,
        lemak: lemak ?? '0',
        protein: protein ?? '0',
        karbohidrat: karbohidrat ?? '0',
        note: note ?? '',
      );

      print("CHECK PUT DAILY ACTIVITY RESPONSE");
      print(response.data);

      if (response.data != null) {
        print("Daily activity added successfully");
        Get.back();
        Get.back();
        Get.snackbar(
          "Berhasil",
          "Makanan berhasil ditambahkan",
          backgroundColor: primaryColor,
          colorText: baseColor,
        );
        refresh();
        userMessageController.clear();
        userMessageActivityController.clear();
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error adding daily activity: $e');
    } finally {
      isLoading(false);
    }
  }



  void refresh() {
    initialize();
  }
}
