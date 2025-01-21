import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/theme.dart';
import '../../../../data/api/ai_instance.dart';
import '../../../../data/api/model/show_history_chatbot_model.dart';
import '../../../../data/api/service/ai_service.dart';
import '../../../../route/app_pages.dart';

class ChatBotController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingResponseAi = false.obs;

  late AiServices aiService;
  late OpenRouterAPI openRouterAPI;

  final HomeController homeController = Get.find<HomeController>();

  TextEditingController userMessageController = TextEditingController();

  RxList<Map<String, String>> chatList = <Map<String, String>>[].obs;
  Rx<HistoryChatBot> historyChatBot = Rx<HistoryChatBot>(HistoryChatBot());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initialize();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //
  //   // Restart HomeController saat ChatBotView ditutup
  //   final homeController = Get.find<HomeController>();
  //   homeController.initialize(); // Panggil metode untuk fetch ulang data
  // }


  Future<void> initialize() async {
    aiService = AiServices();
    openRouterAPI = OpenRouterAPI();
    getHistoryChatBot();
  }

  void refresh() {
    initialize();
  }

  void skipOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboardingChat', true);
    Get.offNamed(Routes.CHAT_BOT);
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
1. Kamu adalah model AI bernama BetterAI yang akan membantu pengguna di aplikasi ini sebagai healthy assistant.
2. Jika ada pengguna yang menyapa kamu seperti menggunakan kata “Hai, Halo,” sapa balik pengguna dengan menyebut namanya (${homeController.dataUser.value!.name}) dan memperkenalkan diri sebagai BetterAI. Tawarkan bantuan kepada pengguna yang bertanya.
3. Jika memang ada pengguna yang bertanya tentang hal yang di luar kesehatan atau makanan, kamu bisa mengaku bahwa BetterAI adalah AI yang dilatih untuk menjawab pertanyaan yang berkaitan dengan kesehatan dan makanan.
4. Jika ada pertanyaan yang menanyakan kamu adalah siapa maka mengakulah sebagai BetterAI dan pastikan tidak mengaku sebagai Meta Llama.
5. Pastikan jawaban dari kamu memuaskan, bisa detail, dan membantu pengguna.
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

      chatList.refresh(); // Add this line

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
}
