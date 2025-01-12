import 'package:better_u/common/constant.dart';
import 'package:better_u/common/theme.dart';
import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../data/api/model/current_combo_model.dart';
import '../controller/home_controller.dart';
import '../widget/add_activity.dart';
import '../widget/calorie_circle_progress.dart';
import '../widget/list_card_activity.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor2,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GreetingWidget(controller: controller),
                  SizedBox(height: 20),
                  CardCurrentNutrition(
                      controller: controller, screenWidth: screenWidth),
                  SizedBox(height: 20),
                  CardDailyWater(
                    controller: controller,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kegiatan hari ini',
                        style: txtPrimaryTitle.copyWith(
                            fontWeight: FontWeight.w600, color: blackColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Get.to(() => AddActivity()),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.add,
                              color: baseColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(bottom: 80),
                      width: screenWidth,
                      // height: 400,
                      child:
                          FoodListView(currentCombo: controller.currentCombo)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardCurrentNutrition extends StatelessWidget {
  const CardCurrentNutrition({
    super.key,
    required this.controller,
    required this.screenWidth,
  });

  final HomeController controller;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? ShimmerWidgets.boxNutrition(screenWidth)
          : Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // linear
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    linearBegin,
                    linearEnd,
                  ],
                  stops: [0.65, 1],
                ),
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: screenWidth,
              child: Obx(() {
                final nutritionInfo = controller.nutritionInformation.value;
                if (nutritionInfo.dailyNutrition == null ||
                    controller.currentTotalNutrition.value == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }

                final dailyNutrition = nutritionInfo.dailyNutrition!;

                final currentTotalNutrition =
                    controller.currentTotalNutrition.value;
                final totalKaloriMakan = currentTotalNutrition.totalKaloriMakan;
                final totalKaloriAktivitas =
                    currentTotalNutrition.totalKaloriAktivitas;
                final totalKaloriSekarang =
                    currentTotalNutrition.totalKaloriSekarang;
                final totalLemak = currentTotalNutrition.totalLemak;
                final totalProtein = currentTotalNutrition.totalProtein;
                final totalKarbohidrat = currentTotalNutrition.totalKarbohidrat;

                int formatDoubleToRoundedInt(double value) {
                  // Periksa apakah desimalnya 0.5
                  if (value % 1 == 0.5) {
                    return value.ceil(); // Bulatkan ke atas jika desimalnya 0.5
                  }
                  return value.toInt(); // Hapus desimal lainnya
                }

                // Nilai-nilai untuk progress bars
                int currentLemak = totalLemak ?? 0; // Contoh nilai saat ini
                double progressLemak =
                    (currentLemak / dailyNutrition.lemak!).clamp(0.0, 1.0);

                int currentProtein = totalProtein ?? 0; // Contoh nilai saat ini
                double progressProtein =
                    (currentProtein / dailyNutrition.protein!).clamp(0.0, 1.0);

                int currentKarbo =
                    totalKarbohidrat ?? 0; // Contoh nilai saat ini
                double progressKarbo =
                    (currentKarbo / dailyNutrition.karbohidrat!)
                        .clamp(0.0, 1.0);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Text(
                                '${totalKaloriMakan} Kkal',
                                style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: baseColor,
                                ),
                              ),
                              Text(
                                'Dimakan',
                                style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: baseColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        CalorieProgressWidget(
                            currentCalories:
                                totalKaloriSekarang?.toDouble() ?? 0,
                            totalCalories: dailyNutrition.totalKalori!,
                            size: 150.0),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              Text(
                                '${totalKaloriAktivitas} Kkal',
                                style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: baseColor,
                                ),
                              ),
                              Text(
                                'Terbakar',
                                style: txtPrimarySubTitle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: baseColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    'Lemak',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: LinearProgressIndicator(
                                      value: progressLemak,
                                      // Replace with your dynamic value
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      minHeight: 3,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(grey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${totalLemak ?? 0} g / ${dailyNutrition.lemak} g',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    'Protein',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: LinearProgressIndicator(
                                      value: progressProtein,
                                      // Replace with your dynamic value
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      minHeight: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.yellow),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${totalProtein ?? 0} g / ${dailyNutrition.protein} g',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    'Karbo',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    child: LinearProgressIndicator(
                                      value: progressKarbo,
                                      // Replace with your dynamic value
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      minHeight: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          redMedium),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${totalKarbohidrat ?? 0} g / ${dailyNutrition.karbohidrat} g',
                                    style: txtPrimarySubTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: baseColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }),
            );
    });
  }
}

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? ShimmerWidgets.userHome()
          : controller.dataUser.value != null
              ? Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${controller.getGreeting()},',
                        style: txtPrimaryTitle.copyWith(
                            fontWeight: FontWeight.w600, color: blackColor),
                        children: [
                          TextSpan(
                            text: ' ${controller.dataUser.value!.name}',
                            style: txtPrimaryTitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      icWavingHand,
                      width: 24,
                      height: 24,
                    ),
                  ],
                )
              : Text('No user data available',
                  style: txtPrimaryTitle.copyWith(
                      fontWeight: FontWeight.w600, color: blackColor));
    });
  }
}

class CardDailyWater extends StatelessWidget {
  final HomeController controller;

  const CardDailyWater({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? CircularProgressIndicator()
          : controller.currentDailyWater.value.data == null
              ? SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Air yang diminum',
                                style: txtPrimaryTitle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: blackColor),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${controller.currentDailyWater.value.data?.amount ?? 0.0}L / 2.0L',
                                style: txtPrimarySubTitle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: navyColor.withOpacity(0.6)),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: baseColor,
                            icon: Icon(
                              Icons.more_vert,
                              size: 24,
                              color: Colors.black,
                            ),
                            onSelected: (value) {
                              if (value == 'tambah') {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Tambah Air Minum',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text('Yakin sudah meminum air 1 gelas sebesar 200ml?'),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => Get.back(),
                                                child: Text('Batal'),
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                  controller.postCurrentDailyWaterIncrease();
                                                },
                                                child: Text('Tambah'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (value == 'hapus') {
                                // Tambahkan logika untuk opsi Delete
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Kurangi Air Minum',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text('Yakin ingin mengurangi total air sebanyak 200ml?'),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => Get.back(),
                                                child: Text('Batal'),
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                  controller.postCurrentDailyWaterDecrease();
                                                },
                                                child: Text('Kurangi'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              }
                            },
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'tambah',
                                child: Row(
                                  children:  [
                                    Icon(Icons.add_circle, color: primaryColor),
                                    SizedBox(width: 8),
                                    Text('Tambah', style: txtPrimarySubTitle.copyWith(color: primaryColor)),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'hapus',
                                child: Row(
                                  children:  [
                                    Icon(Icons.delete_forever, color: redMedium),
                                    SizedBox(width: 8),
                                    Text('Hapus', style: txtPrimarySubTitle.copyWith(color: redMedium)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: grey,
                        thickness: 1,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(10, (index) {
                          return SvgPicture.asset(
                            index < (controller.currentDailyWater.value.data!.totalGlasses ?? 0)
                                ? icGlassActive  // Gunakan ikon gelas aktif
                                : icGlassUnactive, // Gunakan ikon gelas tidak aktif
                            width: 32,
                            height: 32,
                          );
                        }),
                      ),

                    ],
                  ),
                );
    });
  }
}
