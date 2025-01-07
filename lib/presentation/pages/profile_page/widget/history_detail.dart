import 'package:better_u/common/theme.dart';
import 'package:better_u/data/api/auth/model/daily_nutrition_model.dart';
import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:better_u/presentation/pages/profile_page/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../common/constant.dart';
import '../../../../data/api/auth/model/current_combo_model.dart';
import '../../../../data/api/auth/model/show_history_total_nutrition_model.dart';
import '../../../global_components/common_button.dart';
import '../../home_page/widget/list_card_activity.dart';

class DetailHistory extends StatefulWidget {
  final String? date;
  final ShowHistoryTotalNutrition item;
  final NutritionInformation dailyItem;

  DetailHistory({super.key, this.date, required this.item, required this.dailyItem});

  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  final ProfileController controller = Get.find();
  final HomeController homeController = Get.find();


  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await controller.getCurrentCombo(date: widget.date);
      await controller.getDaysTotalNutrition(date: widget.date);
    });
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
          padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
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
                  '${formatDate(widget.date!)}',
                  style: txtSecondaryHeader.copyWith(
                    fontWeight: FontWeight.w700,
                    color: blackColor,
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    icProtein,
                                    width: 46,
                                    height: 46,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Protein",
                                        style: txtSecondaryTitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.item.totalProtein ?? 0}/",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${widget.dailyItem.dailyNutrition?.protein ?? 0} g",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    icKarbo,
                                    width: 46,
                                    height: 46,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Karbohidrat",
                                        style: txtSecondaryTitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.item.totalKarbohidrat ?? 0}/",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${widget.dailyItem.dailyNutrition?.karbohidrat ?? 0} g",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    icLemak,
                                    width: 46,
                                    height: 46,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lemak",
                                        style: txtSecondaryTitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.item.totalLemak ?? 0}/",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${widget.dailyItem.dailyNutrition?.lemak ?? 0} g",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    icKalori,
                                    width: 46,
                                    height: 46,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kalori",
                                        style: txtSecondaryTitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.item.totalKaloriSekarang ?? 0}/",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                          Text(
                                            "${widget.dailyItem.dailyNutrition?.totalKalori ?? 0} g",
                                            style: txtSecondaryTitle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  icCaloriesBurned,
                                  width: 46,
                                  height: 46,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kalori yang terbakar",
                                      style: txtSecondaryTitle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                      ),
                                    ),
                                    Text(
                                      "${widget.item.totalKaloriAktivitas ?? 0} Kkal",
                                      style: txtPrimaryTitle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  icCaloriesAte,
                                  width: 46,
                                  height: 46,
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kalori yang dimakan",
                                      style: txtSecondaryTitle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: blackColor,
                                      ),
                                    ),
                                    Text(
                                      "${widget.item.totalKaloriMakan ?? 0} Kkal",
                                      style: txtPrimaryTitle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text('Kegiatan Saat Itu', style: txtSecondaryHeader.copyWith(
                    fontWeight: FontWeight.w600,
                    color: blackColor,
                  )),
                ),

                SizedBox(height: 20),

                // Kegiatan
                Column(
                  children: List.generate(controller.currentCombo.value.data!.length, (index) {
                    final item = controller.currentCombo.value.data![index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: ActivityItemCard(
                        category: item.category ?? "Kategori Tidak Diketahui",
                        name: item.name ?? "Nama Tidak Diketahui",
                        icon: item.category == "Makan"
                            ? icEatActivity
                            : item.category == "Aktivitas"
                            ? icSportActivity
                            : icEatActivity,
                        kalori: item.kalori ?? 0,
                        item: item,
                        onTap: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => item.category == "Makan" ?  _buildBottomSheetContentEat(context, item) : _buildBottomSheetContentSport(context, item),
                          );
                        },
                      ),
                    );

                  }),
                )


                // Konten lainnya
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildBottomSheetContentEat(BuildContext context, DataCombo item) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 40, right: 25, left: 25),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(65),
          topRight: Radius.circular(65),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 125,
            height: 4,
            decoration: BoxDecoration(
              color: blackColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Rangkuman Makanan",
            style: txtSecondaryHeader.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                icProtein,
                                width: 46,
                                height: 46,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Protein",
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "${item.protein ?? 0} gram",
                                    style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              SvgPicture.asset(
                                icKarbo,
                                width: 46,
                                height: 46,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Karbohidrat",
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "${item.karbohidrat ?? 0} gram",
                                    style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                icLemak,
                                width: 46,
                                height: 46,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lemak",
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "${item.lemak ?? 0} gram",
                                    style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              SvgPicture.asset(
                                icKalori,
                                width: 46,
                                height: 46,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kalori",
                                    style: txtSecondaryTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                  Text(
                                    "${item.kalori ?? 0} kkal",
                                    style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.category ?? "Kategori Tidak Diketahui"}",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item.name ?? "Nama Tidak Diketahui"}",
                      style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: blackColor80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Catatan",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item.note ?? "Tidak ada catatan"}",
                      style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: blackColor80,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                CommonButton(
                    text: 'Tutup',
                    style: txtButton.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                    onPressed: () => Get.back(),
                    height: 60,
                    borderRadius: 10,
                    width: MediaQuery.of(context).size.width,
                    border: BorderSide(
                      color: primaryColor,
                      width: 2,
                    ),
                    backgroundColor: baseColor),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildBottomSheetContentSport(BuildContext context, DataCombo item) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 40, right: 25, left: 25),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(65),
          topRight: Radius.circular(65),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 125,
            height: 4,
            decoration: BoxDecoration(
              color: blackColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Rangkuman Kegiatan",
            style: txtSecondaryHeader.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kalori Yang Terbakar",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        SvgPicture.asset(
                          icKalori,
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${item.kalori ?? "Tidak ada kalori terbakar"} Kkal",
                          style: txtSecondaryHeader.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.category ?? "Kategori Tidak Diketahui"}",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item.name ?? "Nama Tidak Diketahui"}",
                      style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: blackColor80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Catatan",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item.note ?? "Tidak ada catatan"}",
                      style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: blackColor80,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                CommonButton(
                    text: 'Tutup',
                    style: txtButton.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                    onPressed: () => Get.back(),
                    height: 60,
                    borderRadius: 10,
                    width: MediaQuery.of(context).size.width,
                    border: BorderSide(
                      color: primaryColor,
                      width: 2,
                    ),
                    backgroundColor: baseColor),
              ],
            ),
          )
        ],
      ),
    );
  }
}

