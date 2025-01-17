import 'package:better_u/presentation/pages/chat_bot/controller/chat_bot_controller.dart';
import 'package:get/get.dart';

class ChatBotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBotController>(() => ChatBotController());
  }
}