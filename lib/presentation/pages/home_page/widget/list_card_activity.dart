import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../common/constant.dart';
import '../../../../common/theme.dart';
import '../../../../data/api/model/current_combo_model.dart';
import '../../../global_components/common_button.dart';
import '../controller/home_controller.dart';
import '../inner_pages/edit_activity.dart';

class FoodListView extends StatelessWidget {
  final Rx<ShowCurrentCombo> currentCombo;
  HomeController controller = Get.find();

   FoodListView({Key? key, required this.currentCombo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final comboData = currentCombo.value;


      return Obx(() {
        return controller.isLoading.value
            ? ShimmerWidgets.shimmerCard()
            : comboData.data == null || comboData.data!.isEmpty
                ? Center(
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            gifLazyPerson,
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            "Aktivitas Anda Kosong",
                            style: txtPrimaryTitle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Tambahkan aktivitas harian Anda",
                            style: txtPrimarySubTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: blackColor30,
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                :
          Column(
          children: List.generate(
            comboData.data!.length,
                (index) {
              final item = comboData.data![index];
              return ActivityItemCard(
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
                    builder: (context) =>
                    item.category == "Makan"
                        ? _buildBottomSheetContentEat(context, item)
                        : _buildBottomSheetContentSport(context, item),
                  );
                },
              );
            },
          ),
        );
      });
    });
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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

class ActivityItemCard extends StatelessWidget {
  final String category;
  final String name;
  final String icon;
  final int kalori;
  final Function() onTap;
  final DataCombo item;

  const ActivityItemCard({
    Key? key,
    required this.category,
    required this.name,
    required this.icon,
    required this.kalori,
    required this.onTap,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 45,
                  height: 45,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: txtPrimaryTitle.copyWith(
                            fontWeight: FontWeight.w600, color: blackColor),
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        name,
                        style: txtPrimarySubTitle.copyWith(
                            fontWeight: FontWeight.w500, color: blackColor30),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
                    if (value == 'edit') {
                      // Tambahkan logika untuk opsi Edit
                      Get.to(() => EditActivity(item));
                    } else if (value == 'delete') {
                      // Tambahkan logika untuk opsi Delete
                      Get.defaultDialog(
                        title: 'Hapus Aktivitas',
                        middleText: 'Apakah Anda yakin ingin menghapus aktivitas ini?',
                        textConfirm: 'Hapus',
                        textCancel: 'Batal',
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.back();
                          Get.find<HomeController>().deleteDailyActivity(item
                              .id ?? 0);
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children:  [
                          Icon(Icons.edit, color: primaryColor),
                          SizedBox(width: 8),
                          Text('Edit', style: txtPrimarySubTitle.copyWith(color: primaryColor)),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children:  [
                          Icon(Icons.delete, color: redMedium),
                          SizedBox(width: 8),
                          Text('Hapus', style: txtPrimarySubTitle.copyWith(color: redMedium)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 17),
            const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1.5,
            ),
            const SizedBox(height: 17),
            RichText(
              text: TextSpan(
                text: 'Kalori bertambah sebanyak ',
                style: txtPrimarySubTitle.copyWith(
                    fontWeight: FontWeight.w500, color: blackColor),
                children: [
                  TextSpan(
                    text: '$kalori kkal',
                    style: txtPrimarySubTitle.copyWith(
                        fontWeight: FontWeight.w500, color: primaryColor),
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