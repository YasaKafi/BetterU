import 'package:better_u/common/constant.dart';
import 'package:better_u/common/theme.dart';
import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../data/api/model/current_combo_model.dart';
import '../../../global_components/common_button.dart';
import '../../profile_page/widget/chatbot_ai.dart';
import '../controller/home_controller.dart';
import '../widget/add_activity.dart';
import '../widget/calorie_circle_progress.dart';
import '../widget/list_card_activity.dart';
import 'package:syncfusion_flutter_core/theme.dart';


class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
                () => ChatbotAi(),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              betterAiLogo,
              width: 28,
              height: 28,
            ),
            Text(
              'Better AI',
              style: txtThirdSubTitle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontSize: 8),
            ),
          ],
        ),
        backgroundColor: baseColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
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

          // Fungsi untuk mendapatkan warna progress
          Color getProgressColor(double progress) {
            if (progress >= 0.97) {
              return Colors.red; // Merah jika lebih dari atau sama dengan 97%
            } else if (progress >= 0.40) {
              return Colors
                  .yellow; // Kuning jika lebih dari atau sama dengan 40%
            } else {
              return grey; // Default warna grey
            }
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
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getProgressColor(progressLemak),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalLemak ?? 0} g / ${dailyNutrition
                                  .lemak} g',
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
                                  getProgressColor(progressProtein),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalProtein ?? 0} g / ${dailyNutrition
                                  .protein} g',
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
                                  getProgressColor(progressKarbo),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${totalKarbohidrat ?? 0} g / ${dailyNutrition
                                  .karbohidrat} g',
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

  CardDailyWater({
    Key? key,
    required this.controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return controller.isLoading.value
          ? ShimmerWidgets.cardDailyWater(width: width, height: height)
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
                      '${controller.currentDailyWater.value.data?.amount ??
                          0.0}L / 2.0L',
                      style: txtPrimarySubTitle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: navyColor.withOpacity(0.6)),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    final initialValues = controller.valuesDrink.value;

                    Get.dialog(
                      WillPopScope(
                        onWillPop: () async {
                          controller.valuesDrink.value = initialValues;
                          return true;
                        },
                        child: Dialog(
                          backgroundColor: baseColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.currentDailyWater.value.data
                                      ?.amount == '0.0'
                                      ? 'Tambah Air Minum'
                                      : 'Edit Air Minum',
                                  style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor),
                                ),
                                SizedBox(height: 10),

                                Obx(() {
                                  return SfRangeSlider(
                                    min: 0.0,
                                    max: 2000.0,
                                    values: controller.valuesDrink.value,
                                    stepSize: 200,
                                    interval: 200,
                                    showDividers: true,
                                    showTicks: false,
                                    showLabels: false,
                                    inactiveColor: primaryColor.withOpacity(
                                        0.3),
                                    activeColor: primaryColor,
                                    dividerShape: _CustomDividerShape(),
                                    thumbShape: _CustomThumbShape(),
                                    tooltipShape: _ChatBubbleTooltipShape(),
                                    enableTooltip: true,
                                    onChanged: (SfRangeValues values) {
                                      controller.valuesDrink.value =
                                          SfRangeValues(
                                              controller.valuesDrink.value
                                                  .start, values.end);
                                    },
                                  );
                                }),

                                SizedBox(height: 10),
                                Obx(() {
                                  return Text(
                                    'Yakin kamu sudah minum air sebanyak ${
                                        controller
                                            .valuesDrink.value.end.toInt()
                                    } ml?',
                                    textAlign: TextAlign.center,
                                    style: txtSecondaryTitle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: blackColor),
                                  );
                                }),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CommonButton(
                                        text: 'Belum',
                                        style: txtButton.copyWith(
                                            fontWeight:
                                            FontWeight.w600,
                                            color: primaryColor),
                                        onPressed: () {
                                          controller.valuesDrink.value =
                                              initialValues;
                                          Get.back();
                                        },
                                        borderRadius: 10,
                                        border: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                        backgroundColor: baseColor),
                                    CommonButton(
                                      text: 'Sudah',
                                      onPressed: () {
                                        if (controller
                                            .currentDailyWater
                                            .value
                                            .data!
                                            .totalGlasses! >=
                                            10) {
                                          Get.snackbar(
                                            'Gagal',
                                            'Tidak bisa menambah air minum lagi',
                                            backgroundColor:
                                            redMedium,
                                            colorText: baseColor,
                                          );
                                          return;
                                        }

                                        Get.back();
                                        controller
                                            .putDailyWater();
                                      },
                                      // height: 60,
                                      borderRadius: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    controller.currentDailyWater.value.data?.amount == '0.0'
                        ? Icons.add_circle
                        : Icons.mode_edit_outlined,
                    size: 28,
                    color: primaryColor,
                  ),
                )
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
                  index <
                      (controller.currentDailyWater.value.data!
                          .totalGlasses ??
                          0)
                      ? icGlassActive // Gunakan ikon gelas aktif
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

class _ChatBubbleTooltipShape extends SfTooltipShape {
  @override
  void paint(PaintingContext context,
      Offset thumbCenter,
      Offset offset,
      TextPainter textPainter, {
        required Animation<double> animation,
        required Paint paint,
        required RenderBox parentBox,
        required SfSliderThemeData sliderThemeData,
        required Rect trackRect,
      }) {
    final Paint bubblePaint = Paint()
      ..color = primaryColor // Warna balon tooltip
      ..style = PaintingStyle.fill;

    // Dimensi balon tooltip
    const double bubbleWidth = 80;
    const double bubbleHeight = 40;
    const double arrowHeight = 10;
    const double arrowWidth = 20;

    // Membuat rect untuk balon tooltip
    final RRect bubbleRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(
            thumbCenter.dx, thumbCenter.dy - bubbleHeight / 2 - arrowHeight),
        width: bubbleWidth,
        height: bubbleHeight,
      ),
      const Radius.circular(8.0), // Radius sudut balon
    );

    // Membuat path untuk balon dengan ekor segitiga (balon chat)
    final Path bubblePath = Path()
      ..addRRect(bubbleRect)
      ..moveTo(
          thumbCenter.dx - arrowWidth / 2, thumbCenter.dy - bubbleHeight / 2)
      ..lineTo(thumbCenter.dx + arrowWidth / 2,
          thumbCenter.dy - bubbleHeight / 2)..lineTo(
          thumbCenter.dx, thumbCenter.dy)
      ..close();

    // Gambar balon tooltip
    context.canvas.drawPath(bubblePath, bubblePaint);

    // **Mengatur Teks Kustom**
    // Format nilai dengan tambahan "ml"
    final String formattedText = "${textPainter.text!.toPlainText()} ml";

    // Update teks dalam `TextPainter`
    final TextPainter formattedTextPainter = TextPainter(
      text: TextSpan(
        text: formattedText,
        style: txtPrimarySubTitle.copyWith(
          color: baseColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout();

    // Mengatur posisi teks di tengah balon
    final Offset textOffset = Offset(
      thumbCenter.dx - (formattedTextPainter.width / 2),
      thumbCenter.dy - bubbleHeight / 2 - arrowHeight -
          (formattedTextPainter.height / 2),
    );

    // Gambar teks tooltip
    formattedTextPainter.paint(context.canvas, textOffset);
  }
}

class _CustomDividerShape extends SfDividerShape {
  @override
  void paint(PaintingContext context, Offset center, Offset? startThumbCenter,
      Offset? endThumbCenter, Offset? thumbCenter,
      {dynamic currentValue,
        SfRangeValues? currentValues,
        required Animation<double> enableAnimation,
        required Paint? paint,
        required RenderBox parentBox,
        required TextDirection textDirection,
        required SfSliderThemeData themeData}) {
    // Menentukan apakah divider sudah dilewati oleh slider (startThumbCenter atau endThumbCenter)
    bool isStepPassed = (startThumbCenter?.dx ?? 0) > center.dx;

    // Kustomisasi warna divider dengan opacity yang lebih rendah jika belum dilewati slider
    final Paint dividerPaint = Paint()
      ..color = primaryColor.withOpacity(
          isStepPassed ? 1.0 : 0.4) // Opacity 0.4 jika belum dilewati
      ..style = PaintingStyle.fill;

    // Outer circle untuk step
    context.canvas.drawCircle(center, 7, dividerPaint);

    // Inner circle berwarna putih
    final Paint innerCirclePaint = Paint()
      ..color = Colors.white;
    context.canvas.drawCircle(center, 5, innerCirclePaint);
  }
}

// Custom Thumb Shape (untuk kepala slider)
class _CustomThumbShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox? child,
        dynamic currentValue,
        SfRangeValues? currentValues,
        required Animation<double> enableAnimation,
        required Paint? paint,
        required RenderBox parentBox,
        required TextDirection textDirection,
        required SfSliderThemeData themeData,
        SfThumb? thumb}) {
    final Paint thumbPaint = paint ?? Paint()
      ..color = primaryColor;

    final double radius = 8;

    // Ukuran lebih besar untuk kepala slider yang bergerak
    double scale = 1.0;
    if (enableAnimation.value > 0) {
      // Saat slider bergerak, beri efek scale (lebih besar)
      scale = 1 + (enableAnimation.value * 0.3); // Penyesuaian besar scale
    }

    // Outer circle dengan ukuran yang lebih besar saat bergerak
    context.canvas.drawCircle(center, radius * scale, thumbPaint);

    // Inner circle berwarna putih untuk semua (termasuk divider dan step)
    final Paint innerCirclePaint = Paint()
      ..color = Colors.white;
    context.canvas.drawCircle(center, radius * scale * 0.4, innerCirclePaint);
  }
}


