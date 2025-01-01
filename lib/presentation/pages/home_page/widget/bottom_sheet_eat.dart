
import 'package:better_u/data/api/auth/model/nutrition_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';

Widget buildBottomSheetContentEat(BuildContext context, NutritionInformationFromAI item) {
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
                    "Makanan",
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
