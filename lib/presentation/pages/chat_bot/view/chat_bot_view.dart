import 'package:better_u/presentation/pages/chat_bot/controller/chat_bot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/textfield_auth_custom.dart';


class ChatBotView extends GetView<ChatBotController> {
  const ChatBotView({super.key});


  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    AppBar _buildAppBar() {
      final screenHeight = MediaQuery.of(context).size.height;
      return AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: screenHeight,
          decoration:  BoxDecoration(color: baseColor),
          padding:
          const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.back(),
                ),
                Text(
                  'Better AI',
                  style: txtSecondaryHeader.copyWith(
                      fontWeight: FontWeight.w700, color: blackColor),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor2,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // if (!profileController.isLoading.value) {
                //   _scrollToBottom(); // Langsung panggil tanpa post frame callback
                // }

                // Mengambil data riwayat chat
                final historyChat =
                    controller.historyChatBot.value?.data ?? [];

                // Menggabungkan riwayat chat dan chat real-time
                final combinedChat = [
                  ...historyChat
                      .expand((chat) => chat.messageData ?? [])
                      .map((message) => {
                    'sender': message.sender, // Properti dari MessageData
                    'message':
                    message.message, // Properti dari MessageData
                    'createdAt':
                    message.createdAt, // Properti dari MessageData
                  }),
                  ...controller.chatList.map((chat) => {
                    'sender': chat['sender'],
                    'message': chat['message'],
                    'createdAt': chat[
                    'createdAt'], // Pastikan timestamp ada di chatList
                  }),
                ];

                // Urutkan berdasarkan createdAt
                print("Combined Chat: $combinedChat");

                // Mengurutkan berdasarkan waktu (pastikan ada timestamp)
                combinedChat.sort(
                        (a, b) => a['createdAt']?.compareTo(b['createdAt']) ?? 0);

                if (controller.isLoadingResponseAi.value) {
                  combinedChat.add({'sender': 'AI_LOADING', 'message': null});
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: combinedChat.length,
                  itemBuilder: (context, index) {
                    final chat = combinedChat[index];
                    final isUser = chat['sender'] == 'USER';
                    final isAiLoading = chat['sender'] == 'AI_LOADING';


                    if (isAiLoading) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Image.asset(betterAiLogo, width: 24),
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                // Membuat widget teks fleksibel
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: LoadingAnimationWidget.staggeredDotsWave(
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: isUser
                          ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 28, vertical: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          chat['message'] ?? '',
                          style: txtPrimarySubTitle.copyWith(
                              color: baseColor,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                          : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 28, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Image.asset(betterAiLogo, width: 24),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              // Membuat widget teks fleksibel
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: baseColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(chat['message'] ?? '',
                                    style: txtPrimarySubTitle.copyWith(
                                        color: blackColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // Bagian untuk menulis pesan baru
            Obx(() {
              return controller.isLoadingResponseAi.value == true
                  ? Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: baseColor,
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldAuth(
                                controller:
                                controller.userMessageController,
                                title: 'Tanyakan apapun',
                                borderSide: BorderSide.none,
                                readOnly: true,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.rectangle_rounded,
                                  color: baseColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: baseColor,
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldAuth(
                                controller:
                                controller.userMessageController,
                                title: 'Tanyakan apapun',
                                borderSide: BorderSide.none,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final value = controller
                                    .userMessageController.text;
                                if (value.isNotEmpty) {
                                  controller.sendMessage(value);
                                }
                              },
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: primaryColor,
                                child: SvgPicture.asset(
                                  icSend,
                                  width: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );

  }


}
