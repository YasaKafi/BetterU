import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/shimmer_widget.dart';
import '../controller/home_controller.dart';
import 'custom_style_sync_function.dart';

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
                                    dividerShape: CustomDividerShape(),
                                    thumbShape: CustomThumbShape(),
                                    tooltipShape: ChatBubbleTooltipShape(),
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
                                  final checkDataWater = controller
                                      .currentDailyWater.value.data?.amount ??
                                      0.0;

                                  final checkDataAsDouble = checkDataWater is double
                                      ? checkDataWater
                                      : double.tryParse(
                                      checkDataWater.toString()) ?? 0.0;

                                  final conversionFactor = 1000.0;

                                  // Mengonversi nilai dari API ke nilai slider
                                  final convertedValue = checkDataAsDouble *
                                      conversionFactor;

                                  final calculateTotal =
                                      controller.valuesDrink.value.end.toInt() -
                                          convertedValue.toInt();

                                  return Text(
                                    calculateTotal < 0
                                        ? 'Yakin ingin mengurangi jumlah minummu sebanyak ${calculateTotal
                                        .abs()} ml?'
                                        : 'Yakin kamu sudah minum air sebanyak $calculateTotal ml?',
                                    textAlign: TextAlign.center,
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  );
                                }),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(() {
                                      final checkDataWater = controller
                                          .currentDailyWater.value.data?.amount ??
                                          0.0;

                                      final checkDataAsDouble = checkDataWater is double
                                          ? checkDataWater
                                          : double.tryParse(
                                          checkDataWater.toString()) ?? 0.0;

                                      final conversionFactor = 1000.0;

                                      // Mengonversi nilai dari API ke nilai slider
                                      final convertedValue = checkDataAsDouble *
                                          conversionFactor;

                                      final calculateTotal =
                                          controller.valuesDrink.value.end.toInt() -
                                              convertedValue.toInt();
                                      return CommonButton(
                                          text: calculateTotal <=
                                              0 ? 'Tidak' : 'Belum',
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
                                          backgroundColor: baseColor);
                                    }),
                                    Obx(() {
                                      final checkDataWater = controller
                                          .currentDailyWater.value.data?.amount ??
                                          0.0;

                                      final checkDataAsDouble = checkDataWater is double
                                          ? checkDataWater
                                          : double.tryParse(
                                          checkDataWater.toString()) ?? 0.0;

                                      final conversionFactor = 1000.0;

                                      // Mengonversi nilai dari API ke nilai slider
                                      final convertedValue = checkDataAsDouble *
                                          conversionFactor;

                                      final calculateTotal =
                                          controller.valuesDrink.value.end.toInt() -
                                              convertedValue.toInt();
                                      return CommonButton(
                                        text: calculateTotal <= 0
                                            ? 'Iya'
                                            : 'Sudah',
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
                                      );
                                    }),
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
                    size: 32,
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