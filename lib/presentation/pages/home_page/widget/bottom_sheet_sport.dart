
import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/model/nutrition_information.dart';
import '../../../global_components/common_button.dart';

Widget buildBottomSheetContentActivity(BuildContext context, NutritionInformationFromAI item, bool? isInputManual ) {
  final controller = Get.find<HomeController>();

  return Container(
    padding: const EdgeInsets.only(top: 12, bottom: 40, right: 25, left: 25),
    decoration: BoxDecoration(
      color: baseColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(65),
        topRight: Radius.circular(65),
      ),
    ),
    child: IntrinsicHeight(
      child: Column(
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
            "Rangkuman Aktivitas",
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
                      "Aktivitas",
                      style: txtPrimaryTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${item.name}",
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
                      "${item.catatan}",
                      style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: blackColor80,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonButton(
                          text: 'Batalkan',
                          style: txtButton.copyWith(
                              fontWeight: FontWeight.w600, color: primaryColor),
                          onPressed: () => Get.back(),
                          borderRadius: 10,
                          height: 60,
                          border: BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                          backgroundColor: baseColor),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CommonButton(
                        text: 'Tambah',
                        onPressed: () {
                          controller.postDailyActivity(
                            category: 'Aktivitas',
                            name: item.name,
                            kalori: item.kalori.toString(),
                            note: item.catatan,
                            isInputManual: isInputManual,
                          );

                        },
                        height: 60,
                        borderRadius: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
