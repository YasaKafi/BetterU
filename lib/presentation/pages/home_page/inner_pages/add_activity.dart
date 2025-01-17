import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/home_controller.dart';
import 'manual_input_nutrition.dart';

class AddActivity extends StatelessWidget {
  AddActivity({super.key});

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor2,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor2,
                  ),
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          controller.userMessageActivityController.clear();
                          controller.userMessageController.clear();
                          Get.back();
                        },
                      ),
                      Text(
                        'Tambah Kegiatan',
                        style: txtSecondaryHeader.copyWith(
                          fontWeight: FontWeight.w700,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(width: 40), // Lebih konsisten
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: screenHeight * 0.065,
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 28,
                ),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  indicatorPadding: EdgeInsets.zero,
                  dividerColor: baseColor,
                  padding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    color: primaryColor, // Warna hijau untuk tab yang aktif
                    borderRadius:
                        BorderRadius.circular(10), // Membuat sudut melengkung
                  ),

                  labelColor: Colors.white,
                  // Warna teks tab aktif
                  unselectedLabelColor: blackColor,
                  // Warna teks tab tidak aktif
                  tabs: [
                    Tab(
                      child: Container(
                        width: screenWidth,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Center(
                          child: Text(
                            'Aktivitas',
                            style: txtPrimarySubTitle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: screenWidth,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Center(
                          child: Text(
                            'Makanan',
                            style: txtPrimarySubTitle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AddActivityForm(),
                    AddFoodForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddActivityForm extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.userMessageActivityController.clear();
        return true;
      },
      child: SingleChildScrollView(
        // Untuk menghindari overflow saat keyboard muncul
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Apa yang kamu lakukan hari ini?',
                style: txtSecondaryTitle.copyWith(
                    fontWeight: FontWeight.w500, color: blackColor),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomTextFieldAuth(
                  controller: controller.userMessageActivityController,
                  title: 'contoh: jogging 1 km, berenang 500m',
                  maxLines: 5,
                  borderSide: BorderSide.none,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Jelaskan apa yang kamu lakukan hari ini, dan kami akan menganalisis efek dari kegiatan mu bagi tubuhmu secara otomatis',
                style: txtSecondarySubTitle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: blackColor.withOpacity(0.7)),
              ),
              SizedBox(height: 20),
              CommonButton(
                text: 'Analisis',
                width: MediaQuery.of(context).size.width,
                height: 60,
                borderRadius: 10,
                onPressed: () {
                  controller.postChatModelAnalisisActivity(context);
                },
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Merasa kurang puas dengan hasilnya? yuk isi manual',
                  style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w500, color: blackColor),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => ManualInputNutrition());
                        },
                      text: ' Disini',
                      style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w700, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFoodForm extends StatelessWidget {
  final HomeController controller =
      Get.find(); // Pastikan HomeController sudah diinisialisasi sebelumnya

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.userMessageController.clear();
        return true;
      },
      child: SingleChildScrollView(
        // Untuk menghindari overflow saat keyboard muncul
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Apa yang kamu makan hari ini?',
                style: txtSecondaryTitle.copyWith(
                    fontWeight: FontWeight.w500, color: blackColor),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomTextFieldAuth(
                  controller: controller.userMessageController,
                  title: 'contoh: ayam geprek dengan nasi merah',
                  maxLines: 5,
                  borderSide: BorderSide.none,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Jelaskan apa yang kamu makan hari ini, dan kami akan menganalisis nutrisi didalam makananmu secara otomatis',
                style: txtSecondarySubTitle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: blackColor.withOpacity(0.7)),
              ),
              SizedBox(height: 20),
              CommonButton(
                text: 'Analisis',
                width: MediaQuery.of(context).size.width,
                height: 60,
                borderRadius: 10,
                onPressed: () {
                  controller.postChatModelAnalisisFood(context);
                },
              ),
              SizedBox(height: 20),
              CommonButton(
                backgroundColor: primaryColor2,
                icon: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        icCamera,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Scan Makananmu',
                        style: txtSecondaryTitle.copyWith(
                            fontWeight: FontWeight.w600, color: primaryColor),
                      ),
                    ],
                  ),
                ),
                text: '',
                onPressed: () {
                  _showImageSourceAlertDialog(context);
                },
                height: 60,
                width: MediaQuery.of(context).size.width,
                borderRadius: 10,
                style: txtButton.copyWith(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                border:
                    BorderSide(color: primaryColor, style: BorderStyle.solid),
              ),
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Merasa kurang puas dengan hasilnya? yuk isi manual',
                  style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w500, color: blackColor),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => ManualInputNutrition());
                        },
                      text: ' Disini',
                      style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w700, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceAlertDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih sumber gambar'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Kamera'),
                onTap: () async {
                  Navigator.pop(context); // Tutup Dialog sumber gambar
                  await controller.pickImageFromCamera();
                  if (controller.selectedImage.value != null) {
                    await controller.postPredictAndAnalyzeFood(parentContext);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Galeri'),
                onTap: () async {
                  Navigator.pop(context); // Tutup Dialog sumber gambar
                  await controller.pickImageFromGallery();
                  if (controller.selectedImage.value != null) {
                    await controller.postPredictAndAnalyzeFood(parentContext);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
