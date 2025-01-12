import 'package:better_u/common/constant.dart';
import 'package:better_u/presentation/global_components/common_button.dart';
import 'package:better_u/presentation/pages/profile_page/controller/profile_controller.dart';
import 'package:better_u/presentation/pages/profile_page/widget/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../home_page/controller/home_controller.dart';

class HistoryActivities extends StatefulWidget {
  HistoryActivities({super.key});

  ProfileController controller = Get.find<ProfileController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  State<HistoryActivities> createState() => _HistoryActivitiesState();
}

class _HistoryActivitiesState extends State<HistoryActivities> {
  String? selectedFilterDate;
  String? totalKalori;
  String? totalLemak;
  String? totalProtein;
  String? totalKarbo;

  final List<String> filterDate = ['3 Hari', '7 Hari', '14 Hari', '30 Hari'];

  Widget buildCustomDropdown({
    required List<String> options,
    required String hintText,
    String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: baseColor,
          value: selectedValue,
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          hint: Text(hintText,
              style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w600, color: blackColor)),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w600, color: blackColor)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              onChanged(value);
            });
          },
        ),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await widget.controller.getHistoryTotalNutrition(filterDate: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: screenHeight,
          decoration: const BoxDecoration(
            color: baseColor,
          ),
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
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Riwayat Aktivitas',
                  style: txtSecondaryHeader.copyWith(
                      fontWeight: FontWeight.w700, color: blackColor),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            // History Activities
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildCustomDropdown(
                      options: filterDate,
                      hintText: 'Filter',
                      selectedValue: selectedFilterDate,
                      onChanged: (value) {
                        setState(() {
                          String getValue() {
                            switch (value) {
                              case '3 Hari':
                                return '3';
                              case '7 Hari':
                                return '7';
                              case '14 Hari':
                                return '14';
                              case '30 Hari':
                                return '30';
                              default:
                                return '';
                            }
                          }

                          selectedFilterDate = value;
                          widget.controller
                              .getHistoryTotalNutrition(filterDate: getValue());
                        });
                      }),

                  SizedBox(height: 20),

                  // History Activities List
                  Expanded(
                    child: Obx(() {
                      final historyList =
                          widget.controller.historyTotalNutrition.value;

                      totalKalori = widget.homeController.nutritionInformation
                          .value.dailyNutrition?.totalKalori
                          .toString();
                      totalProtein = widget.homeController.nutritionInformation
                          .value.dailyNutrition?.protein
                          .toString();
                      totalLemak = widget.homeController.nutritionInformation
                          .value.dailyNutrition?.lemak
                          .toString();
                      totalKarbo = widget.homeController.nutritionInformation
                          .value.dailyNutrition?.karbohidrat
                          .toString();

                      if (widget.controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (historyList.isEmpty) {
                        return Text(
                          'Tidak ada data untuk filter ini',
                          style: txtSecondaryTitle.copyWith(color: blackColor),
                        );
                      }

                      String _monthName(int month) {
                        const List<String> months = [
                          "January",
                          "February",
                          "March",
                          "April",
                          "May",
                          "June",
                          "July",
                          "August",
                          "September",
                          "October",
                          "November",
                          "December"
                        ];
                        return months[month - 1];
                      }

                      String formatDate(String date) {
                        DateTime parsedDate = DateTime.parse(date);
                        return "${parsedDate.day} ${_monthName(parsedDate.month)} ${parsedDate.year}";
                      }

                      String determineStatus(int activityValue, double? totalValue) {
                        if (totalValue == null) return "Kurang"; // Default jika nilai total null

                        // Hitung toleransi 10%
                        final double tolerance = totalValue * 0.1;
                        final double lowerBound = totalValue - tolerance;
                        final double upperBound = totalValue + tolerance;

                        if (activityValue >= lowerBound && activityValue <= upperBound) {
                          return "Tercukupi";
                        } else if (activityValue > upperBound) {
                          return "Berlebihan";
                        } else {
                          return "Kurang";
                        }
                      }


                      String calculateOverallStatus({
                        required String kaloriStatus,
                        required String lemakStatus,
                        required String proteinStatus,
                        required String karboStatus,
                      }) {
                        final statusList = [
                          kaloriStatus,
                          lemakStatus,
                          proteinStatus,
                          karboStatus
                        ];
                        final statusCount = {
                          "Tercukupi": statusList
                              .where((status) => status == "Tercukupi")
                              .length,
                          "Berlebihan": statusList
                              .where((status) => status == "Berlebihan")
                              .length,
                          "Kurang": statusList
                              .where((status) => status == "Kurang")
                              .length,
                        };

                        // Cari status dengan jumlah terbanyak
                        return statusCount.entries
                            .reduce((a, b) => a.value > b.value ? a : b)
                            .key;
                      }

                      return ListView.builder(
                        itemCount: historyList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final activity = historyList[index];

                          // Di dalam ListView.builder:
                          final kaloriStatus = determineStatus(
                            activity.totalKaloriSekarang ?? 0,
                            double.tryParse(totalKalori ?? '0'),
                          );
                          final lemakStatus = determineStatus(
                            activity.totalLemak ?? 0,
                            double.tryParse(totalLemak ?? '0'),
                          );
                          final proteinStatus = determineStatus(
                            activity.totalProtein ?? 0,
                            double.tryParse(totalProtein ?? '0'),
                          );
                          final karboStatus = determineStatus(
                            activity.totalKarbohidrat ?? 0,
                            double.tryParse(totalKarbo ?? '0'),
                          );

                          final overallStatus = calculateOverallStatus(
                            kaloriStatus: kaloriStatus,
                            lemakStatus: lemakStatus,
                            proteinStatus: proteinStatus,
                            karboStatus: karboStatus,
                          );

                          return Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          icCalendar,
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          formatDate(activity.date!),
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: overallStatus == 'Berlebihan'
                                            ? redMedium
                                            : overallStatus == 'Kurang'
                                                ? grey
                                                : greenMedium,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        overallStatus,
                                        style: txtSecondaryTitle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: baseColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  color: blackColor,
                                  thickness: 1,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Kalori',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${activity.totalKaloriSekarang} kkal',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Lemak',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${activity.totalLemak} g',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Protein',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${activity.totalProtein} g',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Karbo',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${activity.totalKarbohidrat} g',
                                          style: txtSecondaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                CommonButton(
                                    text: 'Cek Detail',
                                    height: 40,
                                    borderRadius: 10,
                                    onPressed: () {
                                      Get.to(() => DetailHistory(
                                            date: activity.date,
                                            item: activity,
                                            dailyItem: widget.homeController
                                                .nutritionInformation.value,
                                          ));
                                    }),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


