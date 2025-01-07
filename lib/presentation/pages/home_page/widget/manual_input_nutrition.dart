import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/home_controller.dart';

class ManualInputNutrition extends StatelessWidget {
   ManualInputNutrition({super.key});
  final HomeController controller =
  Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
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
                          controller.foodController.clear();
                          controller.userMessageActivityController.clear();
                        controller.kaloriController.clear();
                        controller.lemakController.clear();
                        controller.proteinController.clear();
                        controller.karboController.clear();
                        controller.kaloriTerbakarController.clear();
                          Get.back();
                        }
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
                  unselectedLabelColor:
                  blackColor,
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
                    ManualInputActivityForm(),
                    ManualInputFoodForm(),
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

class ManualInputActivityForm extends StatelessWidget {
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Aktivitas",
                    style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextFieldAuth(
                      controller: controller.userMessageActivityController,
                      title: 'Enter your activity',
                      borderSide: BorderSide.none,
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Kalori yang terbakar",
                        style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldAuth(
                                controller: controller.kaloriTerbakarController,
                                title: 'Enter total kalori',
                                borderSide: BorderSide.none,
                                isNumeric: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Kkal',
                                style: txtSecondaryTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.only(bottom: 50, left: 28, right: 28),
              child: CommonButton(
                text: 'Submit',
                onPressed: () {
                  controller.postChatModelAnalisisActivityManual(context);
                },
                height: 60,
                borderRadius: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManualInputFoodForm extends StatelessWidget {
  final HomeController controller =
  Get.find(); // Pastikan HomeController sudah diinisialisasi sebelumnya

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.foodController.clear();
        controller.kaloriController.clear();
        controller.lemakController.clear();
        controller.proteinController.clear();
        controller.karboController.clear();
        controller.kaloriTerbakarController.clear();
        controller.userMessageActivityController.clear();

        return true;
      },
      child: SingleChildScrollView(
        // Untuk menghindari overflow saat keyboard muncul
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Makanan",
                    style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextFieldAuth(
                      controller: controller.foodController,
                      title: 'Enter your food',
                      borderSide: BorderSide.none,
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Kalori",
                        style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldAuth(
                                controller: controller.kaloriController,
                                title: 'Enter your kalori',
                                borderSide: BorderSide.none,
                                isNumeric: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Kkal',
                                style: txtSecondaryTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Lemak",
                        style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldAuth(
                                controller: controller.lemakController,
                                title: 'Enter your lemak',
                                borderSide: BorderSide.none,
                                isNumeric: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Gram',
                                style: txtSecondaryTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Protein",
                        style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldAuth(
                                controller: controller.proteinController,
                                title: 'Enter your protein',
                                borderSide: BorderSide.none,
                                isNumeric: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Gram',
                                style: txtSecondaryTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Karbohidrat",
                        style: txtSecondaryTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomTextFieldAuth(
                                controller: controller.karboController,
                                title: 'Enter your karbohidrat',
                                borderSide: BorderSide.none,
                                isNumeric: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Gram',
                                style: txtSecondaryTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.only(bottom: 50, left: 28, right: 28),
              child: CommonButton(
                text: 'Submit',
                onPressed: () {
                  controller.postChatModelAnalisisFoodManual(context,);
                },
                height: 60,
                borderRadius: 15,
              ),
            ),

          ],
        )
      ),
    );
  }



}
