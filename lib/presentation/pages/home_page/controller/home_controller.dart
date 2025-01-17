import 'dart:convert';
import 'dart:io';

import 'package:better_u/data/api/ai_instance.dart';
import 'package:better_u/data/api/model/current_daily_water_model.dart';
import 'package:better_u/data/api/service/ai_service.dart';
import 'package:better_u/data/api/service/auth_services.dart';
import 'package:better_u/data/api/service/nutrition_service.dart';
import 'package:better_u/presentation/global_components/common_button.dart';
import 'package:better_u/presentation/pages/home_page/widget/bottom_sheet_eat.dart';
import 'package:better_u/presentation/pages/home_page/widget/result_scan.dart';
import 'package:better_u/presentation/pages/home_page/widget/show_recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/model/current_combo_model.dart';
import '../../../../data/api/model/current_total_nutrition_model.dart';
import '../../../../data/api/model/current_user_model.dart';
import '../../../../data/api/model/daily_nutrition_model.dart';
import '../../../../data/api/model/data_recommendation_food.dart';
import '../../../../data/api/model/nutrition_information_model.dart';
import '../../../../data/api/model/prediction_ai_model.dart';
import '../../../../data/api/model/show_recommendation_model.dart';
import '../../../../route/app_pages.dart';
import '../widget/bottom_sheet_sport.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  bool isCancelled = false;
  late AuthServices userService;
  late NutritionServices nutritionServices;
  late AiServices aiService;
  late ShowCurrentUserResponse userResponse;
  late OpenRouterAPI openRouterAPI;
  Rx<DataUser?> dataUser = Rx<DataUser?>(null);
  RxString responsePredict = ''.obs;
  String imageUrl = '';
  var selectedFood = ''.obs;
  final valuesDrink = Rx<SfRangeValues>(SfRangeValues(0.0, 2000.0));


  final ImagePicker _picker = ImagePicker();
  Rxn<XFile> selectedImage = Rxn<XFile>();

  void selectFood(String food) {
    selectedFood.value = food;
  }

  TextEditingController foodController = TextEditingController();
  TextEditingController kaloriController = TextEditingController();
  TextEditingController kaloriTerbakarController = TextEditingController();
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

  Rx<CurrentDailyWater> currentDailyWater = Rx<CurrentDailyWater>(CurrentDailyWater());

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
    userMessageActivityController.dispose();
    userMessageActivityController.clear();
    kaloriController.clear();

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

    await getCurrentUser();

    if (dataUser.value != null) {
      await postCalculateNutrition();
      await getCurrentTotalNutrition();
      await getCurrentDailyWater();
      await getCurrentCombo();
    }
  }


  Future<void> putDailyWater() async {
    try {
      int waterAmount = valuesDrink.value.end.toInt();  // Menggunakan .end atau .start sesuai kebutuhan
      String waterAmountStr = waterAmount.toString();
      final response = await nutritionServices.putDailyWater(amount: waterAmountStr);

      if (response.data != null) {
        final currentDailyWaterData =
            CurrentDailyWater.fromJson(response.data);
        currentDailyWater.value = currentDailyWaterData;
        print("Current Daily Water: ${currentDailyWater.value}");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error posting current daily water: $e');
    } finally {
      initialize();
    }
  }

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

  void showLoadingDialog(BuildContext context, {String? message = 'makanan'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: baseColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                gifSearchLoading,
                width: 250,
                height: 250,
              ),
              SizedBox(width: 20),
              Center(
                  child: Text(
                "Tunggu ya kami sedang menganalisis $message kamu... ",
                textAlign: TextAlign.center,
                style: txtSecondaryTitle.copyWith(
                    fontWeight: FontWeight.w400, color: blackColor),
              )),
              SizedBox(height: 20),
              CommonButton(
                  text: 'Batalkan',
                  width: MediaQuery.of(context).size.width,
                  style: txtButton.copyWith(
                      fontWeight: FontWeight.w600, color: primaryColor),
                  onPressed: () {
                    isCancelled = true;
                    Get.back();
                  },
                  borderRadius: 10,
                  height: 60,
                  border: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                  backgroundColor: baseColor),
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


  Future<void> postCurrentDailyWaterIncrease() async {
    try {
      final response = await nutritionServices.postDailyWaterIncrease();

      if (response.data != null) {
        final currentDailyWaterData =
            CurrentDailyWater.fromJson(response.data);
        currentDailyWater.value = currentDailyWaterData;
        print("Current Daily Water: ${currentDailyWater.value}");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error posting current daily water: $e');
    } finally {
      initialize();
    }
  }

  Future<void> postCurrentDailyWaterDecrease() async {
    try {
      final response = await nutritionServices.postDailyWaterDecrease();

      if (response.data != null) {
        final currentDailyWaterData =
            CurrentDailyWater.fromJson(response.data);
        currentDailyWater.value = currentDailyWaterData;
        print("Current Daily Water: ${currentDailyWater.value}");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error posting current daily water: $e');
    } finally {
      initialize();
    }
  }

  Future<void> postImageToURL(BuildContext context) async {
    try {
      isCancelled = false; // Reset flag sebelum mulai proses
      showLoadingDialog(context, message: 'makanan');

      final response = await nutritionServices.postImageToUrl(
          file: File(selectedImage.value!.path));

      if (isCancelled) {
        print('Proses dibatalkan saat prediksi makanan.');
        return; // Hentikan eksekusi jika dibatalkan
      }

      print("CHECK POST IMAGE TO URL RESPONSE");
      print(response.data);

      if (response.data != null) {
        imageUrl = response.data['data']['image'];

        Get.back();

        print("Image URL: $imageUrl");
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching recommendation food: $e');
    }
  }

  Future<void> postRecommendationFood(BuildContext context) async {
    try {
      isCancelled = false; // Reset flag sebelum mulai proses
      showLoadingDialog(context, message: 'makanan');

      final response =
          await aiService.postRecommendationFood(imageUrl: imageUrl);

      if (isCancelled) {
        print('Proses dibatalkan saat prediksi makanan.');
        return; // Hentikan eksekusi jika dibatalkan
      }

      print("CHECK RECOMMENDATION FOOD RESPONSE");
      print(response.data);

      if (response.data != null) {
        final recommendationData =
            ShowRecommendationFood.fromJson(response.data);
        final contentString =
            recommendationData.choices!.first.message!.content;
        print("Recommendation Data: $contentString");

        final parsedContent = RecommendationContent.fromJson(
          jsonDecode(contentString!),
        );

        print("Parsed Recommendation Data:");
        print("Makanan One: ${parsedContent.makananOne}");
        print("Makanan Two: ${parsedContent.makananTwo}");
        print("Makanan Three: ${parsedContent.makananThree}");
        print("Makanan Four: ${parsedContent.makananFour}");

        Get.back();

        Get.to(() => ShowRecommendation(
            recommendationContent: parsedContent,
            imagePath: selectedImage.value!.path));
      } else {
        print("Response data is null");
      }
    } catch (e) {
      print('Error fetching recommendation food: $e');
    }
  }

  Future<void> postPredictAndAnalyzeFood(BuildContext context) async {
    if (selectedImage.value == null) {
      Get.snackbar('Error', 'Tidak ada gambar yang dipilih.');
      return;
    }

    try {
      isCancelled = false; // Reset flag sebelum mulai proses
      showLoadingDialog(context, message: 'makanan');

      // Step 1: Prediksi makanan
      final File file = File(selectedImage.value!.path);
      final response = await nutritionServices.postPredict(file: file);

      if (isCancelled) {
        print('Proses dibatalkan saat prediksi makanan.');
        return; // Hentikan eksekusi jika dibatalkan
      }

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
        if (!isCancelled) {
          await postChatModelAnalisisFood(context, isPredict: true);
        } else {
          print('Proses dibatalkan sebelum analisis nutrisi.');
        }
      } else {
        Get.snackbar('Error', 'Response data is null.');
      }
    } catch (e, stackTrace) {
      if (isCancelled) {
        print('Proses dibatalkan: $e');
      } else {
        print('Error: $e');
        print('Stack trace: $stackTrace');
        Get.snackbar('Error', 'Gagal memproses makanan.');
      }
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

  Future<void> postChatModelAnalisisFood(BuildContext context,
      {bool? isPredict = false,
      bool? isFromRecommendation = false,
      bool? isFromInputManual = false}) async {
    try {
      // Nama makanan dari user input
      await dotenv.load();
      String promptTemplate = dotenv.env['PROMPT_TEMPLATE'] ?? '';

      String userMessage = '';

      if (isPredict == true) {
        userMessage = responsePredict.value;
      } else if (isFromRecommendation == true) {
        userMessage = selectedFood.value;
      } else {
        if (userMessageController.text.isEmpty) {
          Get.snackbar('Error', 'Tidak ada makanan yang dimasukkan.');
          return;
        }
        userMessage = userMessageController.text.trim();
      }

      showLoadingDialog(context, message: 'makanan');

      String prompt = promptTemplate.replaceFirst('{userMessage}', userMessage);



      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);




      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {

        Navigator.pop(context);

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
          print(
              'Nutrition Data Kalori: ${nutritionInformationFromAI.value.kalori}');
          print(
              'Nutrition Data Name: ${nutritionInformationFromAI.value.name}');
          print(
              'Nutrition Data Lemak: ${nutritionInformationFromAI.value.lemak}');
          print(
              'Nutrition Data Karbo: ${nutritionInformationFromAI.value.karbohidrat}');
          print(
              'Nutrition Data Protein: ${nutritionInformationFromAI.value.protein}');
          print(
              'Nutrition Data Note: ${nutritionInformationFromAI.value.catatan}');

          if (isPredict == true) {
            Navigator.pop(context);
          }

          // Tampilkan hasil ke Bottom Sheet

          if (isPredict == true) {
            Get.to(() => ResultScan(
                  item: nutritionInformationFromAI.value,
                  imagePath: selectedImage.value!.path,
                ));
          } else {
            Get.bottomSheet(
              Builder(
                builder: (BuildContext context) {
                  return buildBottomSheetContentEat(
                      context,
                      nutritionInformationFromAI.value,
                      isFromRecommendation,
                      isFromInputManual);
                },
              ),
              isScrollControlled: true,
            );
          }
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

      await dotenv.load();
      String promptTemplateActivity = dotenv.env['PROMPT_TEMPLATE_ACTIVITY'] ?? '';


      if (userMessageActivityController.text.isEmpty) {
        Get.snackbar('Error', 'Tidak ada aktivitas yang dimasukkan.');
        return;
      }

      showLoadingDialog(context, message: 'kegiatan');


      // Nama makanan dari user input
      final String userMessage = userMessageActivityController.text.trim();

      String prompt = promptTemplateActivity.replaceFirst('{userMessage}', userMessage);




      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);

      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {

        Navigator.pop(context);

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
                context, nutritionInformationFromAI.value, false),
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
      isLoading(true);
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
    } finally {
      isLoading(false);
    }
  }

  Future<void> postChatModelAnalisisFoodManual(BuildContext context) async {
    try {
      // Nama makanan dari user input

      if (foodController.text.isEmpty) {
        Get.snackbar('Error', 'Tidak ada makanan yang dimasukkan.');
        return;
      }

      String userMessage = foodController.text.trim();

      String generatePrompt(String userMessage,
          {String? kalori, String? protein, String? lemak, String? karbohidrat}) {
        // Buat list untuk field yang kosong
        List<String> missingFields = [];

        if (kalori == null || kalori == '') missingFields.add('kalori');
        if (protein == null || protein == '') missingFields.add('protein');
        if (lemak == null || lemak == '') missingFields.add('lemak');
        if (karbohidrat == null || karbohidrat == '')
          missingFields.add('karbohidrat');

        // Jika semua field terisi
        if (missingFields.isEmpty) {
          return '''
Semua data nutrisi untuk "$userMessage" sudah lengkap.
Tolong masukkan data ke dalam format JSON seperti berikut:
{
  "kalori": "$kalori",
  "protein": "$protein",
  "lemak": "$lemak",
  "karbohidrat": "$karbohidrat",
  "catatan": "Saran kesehatan untuk makanan ini dan efek bagi tubuh jika makanan ini tidak baik, berupa 1 paragraf"
}
'''
              .trim();
        }

        // Jika ada field yang kosong, minta AI melengkapi data
        String prompt = '''
Nama makanan: "$userMessage".
Data berikut belum diketahui: ${missingFields.join(', ')}.
Tolong lengkapi data yang hilang dalam format JSON seperti berikut:
{
  ${missingFields.contains('kalori') ? '"kalori": "Jumlah kalori dalam Kkal",' : '"kalori": "$kalori",'}
  ${missingFields.contains('protein') ? '"protein": "Jumlah protein dalam gram",' : '"protein": "$protein",'}
  ${missingFields.contains('lemak') ? '"lemak": "Jumlah lemak dalam gram",' : '"lemak": "$lemak",'}
  ${missingFields.contains('karbohidrat') ? '"karbohidrat": "Jumlah karbohidrat dalam gram",' : '"karbohidrat": "$karbohidrat",'}
  "catatan": "Saran kesehatan untuk makanan ini dan efek bagi tubuh jika makanan ini tidak baik, berupa 1 paragraf"
}
'''
            .trim();

        return prompt;
      }

      // Panggil API untuk mendapatkan hasil dari prompt
      final response =
          await openRouterAPI.callChatModel(generatePrompt(userMessage, kalori: kaloriController.text, protein: proteinController.text, lemak: lemakController.text, karbohidrat: karboController.text));

      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {
        print('Raw AI Response: $response');

        final Map<String, dynamic> parsedData =
        parseAiResponseAnalisisFoodManual(response);

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
          print(
              'Nutrition Data Kalori: ${nutritionInformationFromAI.value.kalori}');
          print(
              'Nutrition Data Name: ${nutritionInformationFromAI.value.name}');
          print(
              'Nutrition Data Lemak: ${nutritionInformationFromAI.value.lemak}');
          print(
              'Nutrition Data Karbo: ${nutritionInformationFromAI.value.karbohidrat}');
          print(
              'Nutrition Data Protein: ${nutritionInformationFromAI.value.protein}');
          print(
              'Nutrition Data Note: ${nutritionInformationFromAI.value.catatan}');

          Get.bottomSheet(
            Builder(
              builder: (BuildContext context) {
                return buildBottomSheetContentEat(
                    context, nutritionInformationFromAI.value, false, true);
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

  Future<void> postChatModelAnalisisActivityManual(BuildContext context) async {
    try {

      if (userMessageActivityController.text.isEmpty) {
        Get.snackbar('Error', 'Tidak ada aktivitas yang dimasukkan.');
        return;
      }

      // Nama aktivitas dari user input
      final String userMessage = userMessageActivityController.text.trim();

      // Prompt generator
      String generatePrompt(String userMessage, {String? kalori}) {
        if (kalori != null && kalori != '') {
          // Jika kalori sudah diisi, berikan respons langsung
          return '''
Semua data untuk aktivitas "$userMessage" sudah lengkap.
Kalori yang terbakar: $kalori Kkal.
Formatkan respons Anda dalam JSON dengan struktur berikut:
{
  "kalori": "$kalori",
  "catatan": "Saran kesehatan untuk olahraga ini dan sebutkan efek bagi tubuh jika melakukan olahraga ini baik atau buruk, berupa 1 paragraf"
}
Pastikan untuk hanya memberikan data dalam format JSON tanpa penjelasan tambahan dan tolong tambahkan tag penutup -> }  jika response anda tidak terdapat tag penutup -> } sebelumnya.
'''
              .trim();
        }

        // Jika kalori belum diisi, minta AI melengkapi
        return '''
Berikan informasi tentang komposisi aktivitas olahraga berikut: "$userMessage". 
Formatkan respons Anda dalam JSON dengan struktur berikut:
{
  "kalori": "Jumlah kalori terbakar dalam Kkal",
  "catatan": "Saran kesehatan untuk olahraga ini dan sebutkan efek bagi tubuh jika melakukan olahraga ini baik atau buruk, berupa 1 paragraf"
}
Pastikan untuk hanya memberikan data dalam format JSON tanpa penjelasan tambahan dan tolong tambahkan tag penutup -> }  jika response anda tidak terdapat tag penutup -> } sebelumnya.
'''
            .trim();
      }

      // Generate prompt
      String prompt = generatePrompt(userMessage, kalori: kaloriTerbakarController.value.text);

      // Panggil API untuk mendapatkan hasil dari prompt
      final response = await openRouterAPI.callChatModel(prompt);

      // Validasi response dan parsing data
      if (response != null && response.isNotEmpty) {
        print('Raw AI Response: $response');

        final Map<String, dynamic> parsedData =
        parseAiResponseAnalisisActivityManual(response);

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
                context, nutritionInformationFromAI.value, true),
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



  /// PARSE RESPONSE AI ///

// Fungsi untuk mem-parsing response AI ke dalam Map
  Map<String, dynamic> parseAiResponseAnalisisFood(String response) {
    try {
      final endIndex = response.lastIndexOf('}');
      if (endIndex != -1) {
        final validJson = response.substring(0, endIndex + 1);

        final parsedResponse = jsonDecode(validJson) as Map<String, dynamic>;

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
      } else {
        print('Tag penutup JSON tidak ditemukan.');
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }

  Map<String, dynamic> parseAiResponseAnalisisActivity(String response) {
    try {
      // Cari posisi tag penutup `}` terakhir
      final endIndex = response.lastIndexOf('}');
      if (endIndex != -1) {
        final validJson = response.substring(0, endIndex + 1);

        // Parsing JSON yang valid
        final parsedResponse = jsonDecode(validJson) as Map<String, dynamic>;

        // Fungsi untuk menghitung rata-rata dari rentang string
        int parseRange(String? value) {
          if (value == null) return 0; // Nilai default jika data null
          final match = RegExp(r'(\d+)-(\d+)').firstMatch(value);
          if (match != null) {
            final min = int.parse(match.group(1)!);
            final max = int.parse(match.group(2)!);
            return ((min + max) / 2).round(); // Rata-rata dan bulatkan
          }
          // Jika tidak ada rentang, coba parsing angka langsung
          return int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        }

        // Kembalikan hasil parsing
        return {
          'kalori': parseRange(parsedResponse['kalori']),
          'catatan': parsedResponse['catatan'] ?? 'Tidak ada catatan.',
        };
      } else {
        print('Tag penutup JSON tidak ditemukan.');
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }

  Map<String, dynamic> parseAiResponseAnalisisActivityManual(String response) {
    try {
      // Cari posisi tag penutup `}` terakhir
      final endIndex = response.lastIndexOf('}');
      if (endIndex != -1) {
        final validJson = response.substring(0, endIndex + 1).trim();

        // Parsing JSON yang valid
        final parsedResponse = jsonDecode(validJson) as Map<String, dynamic>;

        // Fungsi untuk menghitung rata-rata dari rentang string
        int parseRange(String? value) {
          if (value == null) return 0; // Nilai default jika data null
          final match = RegExp(r'(\d+)-(\d+)').firstMatch(value);
          if (match != null) {
            final min = int.parse(match.group(1)!);
            final max = int.parse(match.group(2)!);
            return ((min + max) / 2).round(); // Rata-rata dan bulatkan
          }
          // Jika tidak ada rentang, coba parsing angka langsung
          return int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        }

        // Kembalikan hasil parsing
        return {
          'kalori': parseRange(parsedResponse['kalori']),
          'catatan': parsedResponse['catatan'] ?? 'Tidak ada catatan.',
        };
      } else {
        print('Tag penutup JSON tidak ditemukan.');
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }

  Map<String, dynamic> parseAiResponseAnalisisFoodManual(String response) {
    try {
      // Cari posisi awal dan akhir JSON menggunakan regex
      final match = RegExp(r'\{.*\}', dotAll: true).firstMatch(response);
      if (match != null) {
        final validJson = match.group(0)!; // Ekstrak bagian JSON

        // Decode JSON menjadi Map
        final parsedResponse = jsonDecode(validJson) as Map<String, dynamic>;

        // Fungsi untuk menghitung rata-rata dari rentang string
        int parseRange(String? value) {
          if (value == null) return 0; // Nilai default jika data null
          final match = RegExp(r'(\d+)-(\d+)').firstMatch(value);
          if (match != null) {
            final min = int.parse(match.group(1)!);
            final max = int.parse(match.group(2)!);
            return ((min + max) / 2).round(); // Hitung rata-rata dan bulatkan ke int
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
      } else {
        print('JSON tidak ditemukan dalam respons.');
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return {}; // Jika parsing gagal, kembalikan Map kosong
  }


  /// GET ///

  // Fetch current user and trigger postCalculateNutrition after 1 second
  Future<void> getCurrentUser() async {
    const int maxRetries = 5; // Batas maksimal percobaan
    int retryCount = 0; // Menghitung jumlah percobaan
    bool isSuccess = false; // Menandakan apakah fetch berhasil

    while (!isSuccess && retryCount < maxRetries) {
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
            isSuccess = true; // Fetch berhasil, keluar dari loop
          } else {
            print("User data is null");
          }
        } else {
          print("Response data is null");
        }
      } catch (e) {
        print('Error fetching user data: $e');
      } finally {
        retryCount++;
        isLoading(false);

        if (!isSuccess && retryCount < maxRetries) {
          print("Retrying... ($retryCount/$maxRetries)");
          await Future.delayed(Duration(seconds: 2)); // Delay sebelum retry
        }
      }
    }

    if (!isSuccess) {
      print("Failed to fetch user data after $maxRetries attempts.");
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

  Future<void> getCurrentDailyWater() async {
    try {
      isLoading(true);
      final response = await nutritionServices.showCurrentDailyWater();

      print("CHECK CURRENT RESPONSE COMBO");
      print(response.data);

      if (response.data != null) {
        final dailyWaterData = CurrentDailyWater.fromJson(response.data);
        currentDailyWater.value = dailyWaterData;

        final checkData = dailyWaterData.data?.amount ?? 0.0;

        print("VALUE AMOUNT OF WATER : $checkData");

        final checkDataAsDouble = checkData is double ? checkData : double.tryParse(checkData.toString()) ?? 0.0;

        // Faktor untuk mengonversi nilai API ke rentang slider
        final conversionFactor = 1000.0;  // Misalnya API memiliki rentang 0.0 - 2.0 dan slider rentangnya 0.0 - 2000.0

        // Mengonversi nilai dari API ke nilai slider
        final convertedValue = checkDataAsDouble * conversionFactor;  // Mengalikan untuk mendapatkan nilai yang sesuai dengan slider

        // Mengganti nilai start dari SfRangeValues dengan nilai yang sudah dikonversi
        final updatedRangeValues = SfRangeValues(valuesDrink.value.start, convertedValue);
        valuesDrink.value = updatedRangeValues;  // Update Rx value

        print("Updated valuesDrink end: ${valuesDrink.value.start}");
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

  /// PUT ///

  Future<void> postDailyActivity(
      {required category,
      required String name,
      required String kalori,
      String? lemak,
      String? protein,
      String? karbohidrat,
      required String note,
      bool? isFromRecommendation = false,
      bool? isFromResultScan = false,
      bool? isInputManual = false}) async {
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

        if (isFromRecommendation == true) {
          Get.back();
          Get.offNamedUntil(
              Routes.BOTTOM_NAVBAR, ModalRoute.withName(Routes.BOTTOM_NAVBAR));
        }

        if (isFromResultScan == true) {
          Get.back();
          Get.offNamedUntil(
              Routes.BOTTOM_NAVBAR, ModalRoute.withName(Routes.BOTTOM_NAVBAR));
        }

        if (isInputManual == true) {
          Get.back();
          Get.offNamedUntil(
              Routes.BOTTOM_NAVBAR, ModalRoute.withName(Routes.BOTTOM_NAVBAR));
        }

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

  void refresh() {
    initialize();
  }
}
