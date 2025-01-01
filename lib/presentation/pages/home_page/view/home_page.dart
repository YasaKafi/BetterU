import 'package:better_u/common/constant.dart';
import 'package:better_u/common/theme.dart';
import 'package:better_u/data/api/auth/model/daily_nutrition_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../common/dimensions.dart';
import '../../../../data/api/auth/model/current_combo_model.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() {
                      return controller.isLoading.value
                          ? CircularProgressIndicator()
                          : controller.dataUser.value != null
                              ? RichText(
                                  text: TextSpan(
                                    text: '${controller.getGreeting()},',
                                    style: txtPrimaryTitle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: blackColor),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${controller.dataUser.value!.name}',
                                        style: txtPrimaryTitle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                )
                              : Text('No user data available',
                                  style: txtPrimaryTitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: blackColor));
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      icWavingHand,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
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
                      )
                      );
                    }

                    final dailyNutrition = nutritionInfo.dailyNutrition!;

                    final currentTotalNutrition =
                        controller.currentTotalNutrition.value;
                    final totalKaloriMakan =
                        currentTotalNutrition.totalKaloriMakan;
                    final totalKaloriAktivitas =
                        currentTotalNutrition.totalKaloriAktivitas;
                    final totalKaloriSekarang =
                        currentTotalNutrition.totalKaloriSekarang;
                    final totalLemak = currentTotalNutrition.totalLemak;
                    final totalProtein = currentTotalNutrition.totalProtein;
                    final totalKarbohidrat =
                        currentTotalNutrition.totalKarbohidrat;

                    int formatDoubleToRoundedInt(double value) {
                      // Periksa apakah desimalnya 0.5
                      if (value % 1 == 0.5) {
                        return value
                            .ceil(); // Bulatkan ke atas jika desimalnya 0.5
                      }
                      return value.toInt(); // Hapus desimal lainnya
                    }

                    // Nilai-nilai untuk progress bars
                    double currentLemak =
                        totalLemak ?? 0; // Contoh nilai saat ini
                    double progressLemak =
                        (currentLemak / dailyNutrition.lemak!).clamp(0.0, 1.0);

                    double currentProtein =
                        totalProtein ?? 0; // Contoh nilai saat ini
                    double progressProtein =
                        (currentProtein / dailyNutrition.protein!)
                            .clamp(0.0, 1.0);

                    double currentKarbo =
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
                                              AlwaysStoppedAnimation<Color>(
                                                  grey),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${formatDoubleToRoundedInt(totalLemak ?? 0)} g / ${formatDoubleToRoundedInt(dailyNutrition.lemak!)} g',
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.yellow),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${formatDoubleToRoundedInt(totalProtein ?? 0)} g / ${formatDoubleToRoundedInt(dailyNutrition.protein!)} g',
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  redMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${formatDoubleToRoundedInt(totalKarbohidrat ?? 0)} g / ${formatDoubleToRoundedInt(dailyNutrition.karbohidrat!)} g',
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kegiatan Hari Ini',
                      style: txtPrimaryTitle.copyWith(
                          fontWeight: FontWeight.w600, color: blackColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => AddActivity()),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.add,
                            color: baseColor,
                          )),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(bottom: 80),
                    width: screenWidth,
                    height: 500,
                    // height: 400,
                    child: FoodListView(currentCombo: controller.currentCombo)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddActivity extends StatelessWidget {
  const AddActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Memastikan keyboard tidak memblok UI
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor,
                ),
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
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
              height: screenHeight * 0.1,
              width: screenWidth,
              child: TabBar(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                dividerColor: grey,
                indicatorColor: blackColor,
                labelColor: blackColor,
                unselectedLabelColor: grey,
                tabs: [
                  Tab(child: Text('Aktivitas', style: txtPrimarySubTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor))),
                  Tab(child: Text('Makanan', style: txtPrimarySubTitle.copyWith(fontWeight: FontWeight.w500, color: blackColor))),
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
    );
  }
}


class AddActivityForm extends StatelessWidget {
  final controller = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController activityController = TextEditingController();
  final TextEditingController kaloriController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFieldAuth(
            controller: activityController,
            title: 'Aktivitas',
          ),
          SizedBox(height: 20),
          CustomTextFieldAuth(
            controller: kaloriController,
             title: 'Kalori',
          ),
          SizedBox(height: 20),
          CustomTextFieldAuth(
            controller: noteController,
             title: 'Catatan',
          ),
          SizedBox(height: 20),
          CommonButton(
            text: 'Tambah',
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}


class AddFoodForm extends StatelessWidget {
  final HomeController controller = Get.find(); // Pastikan HomeController sudah diinisialisasi sebelumnya

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Untuk menghindari overflow saat keyboard muncul
      child: Column(
        children: [
          SizedBox(height: 50),
          CustomTextFieldAuth(
            controller: controller.userMessageController,
            title: 'Makanan',
          ),
          SizedBox(height: 20),
          CommonButton(
            text: 'Analisis',
            onPressed: () {
              controller.postChatModel(context);
            },
          ),
        ],
      ),
    );
  }
}


class FoodListView extends StatelessWidget {
  final Rx<ShowCurrentCombo> currentCombo;

  const FoodListView({Key? key, required this.currentCombo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final comboData = currentCombo.value;

      if (comboData.data == null || comboData.data!.isEmpty) {
        return Center(
          child: Text(
            "Tidak ada data makanan.",
            style: TextStyle(color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        itemCount: comboData.data!.length,
        itemBuilder: (context, index) {
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
                builder: (context) => item.category == "Makan" ?  _buildBottomSheetContentEat(context, item) : _buildBottomSheetContentSport(context, item),
              );
            },
          );
        },
      );
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: txtPrimaryTitle.copyWith(
                          fontWeight: FontWeight.w600, color: blackColor),
                    ),
                    Text(
                      name,
                      style: txtPrimarySubTitle.copyWith(
                          fontWeight: FontWeight.w500, color: blackColor30),
                    ),
                  ],
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
                          Get.find<HomeController>().deleteDailyActivity(item.id ?? 0);
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: const [
                          Icon(Icons.edit, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Hapus'),
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

class EditActivity extends StatefulWidget {
  final DataCombo item;
  final controller = Get.put(HomeController());
  EditActivity(this.item, {Key? key}) : super(key: key);

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  late TextEditingController foodController;
  late TextEditingController kaloriController;
  late TextEditingController lemakController;
  late TextEditingController proteinController;
  late TextEditingController karboController;


  @override
  void initState() {
    super.initState();

    // Inisialisasi TextEditingController dengan nilai dari item
    foodController = TextEditingController(text: widget.item.name ?? '');
    kaloriController = TextEditingController(text: widget.item.kalori?.toString() ?? '');
    lemakController = TextEditingController(text: widget.item.lemak?.toString() ?? '');
    proteinController = TextEditingController(text: widget.item.protein?.toString() ?? '');
    karboController = TextEditingController(text: widget.item.karbohidrat?.toString() ?? '');
  }

  @override
  void dispose() {
    // Jangan lupa untuk dispose TextEditingController untuk menghindari memory leak
    foodController.dispose();
    kaloriController.dispose();
    lemakController.dispose();
    proteinController.dispose();
    karboController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                  ),
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        widget.item.category == "Makan"
                            ? 'Edit Makanan' : 'Edit Aktivitas',
                        style: txtSecondaryHeader.copyWith(
                            fontWeight: FontWeight.w700, color: blackColor),
                      ),
                      Container(
                        width: 40,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              widget.item.category == "Makan"
                  ? Padding(
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
                    CustomTextFieldAuth(
                      title: "Enter your food",
                      controller: foodController,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
                              child: CustomTextFieldAuth(
                                title: "Enter total kalori",
                                controller: kaloriController,
                                isNumeric: true,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
                              child: CustomTextFieldAuth(
                                title: "Enter total lemak",
                                controller: lemakController,
                                isNumeric: true,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
                              child: CustomTextFieldAuth(
                                title: "Enter total protein",
                                controller: proteinController,
                                isNumeric: true,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
                              child: CustomTextFieldAuth(
                                title: "Enter total karbohidrat",
                                controller: karboController,
                                isNumeric: true,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
              )
                  : Padding(
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
                    CustomTextFieldAuth(
                      title: "Enter your activity",
                      controller: foodController,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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
                              child: CustomTextFieldAuth(
                                title: "Enter total kalori",
                                controller: kaloriController,
                                isNumeric: true,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderFocusRadius: BorderRadius.all(Radius.circular(12)),
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


              Spacer(),
              Container(
                width: screenWidth,
                padding: const EdgeInsets.only(bottom: 50, left: 28, right: 28),
                child: CommonButton(
                  text: 'Submit',
                  onPressed: () {
                    widget.item.category == "Makan" ?
                    widget.controller.putDailyActivity(
                      widget.item.id!,
                      foodController.text,
                      widget.item.category!,
                      kaloriController.text,
                      lemakController.text,
                      proteinController.text,
                      karboController.text,
                    ) :
                    widget.controller.putDailyActivity(
                      widget.item.id!,
                      foodController.text,
                      widget.item.category!,
                      kaloriController.text,
                      lemakController.text.isEmpty ? null : lemakController.text,
                      proteinController.text.isEmpty ? null : proteinController.text,
                      karboController.text.isEmpty ? null : karboController.text,
                    );
                  },
                  height: 60,
                  borderRadius: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalorieProgressWidget extends StatelessWidget {
  final double currentCalories;
  final double totalCalories;
  final double size;

  const CalorieProgressWidget({
    Key? key,
    required this.currentCalories,
    required this.totalCalories,
    this.size = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = (currentCalories / totalCalories).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lingkaran progress
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.7),
            ),
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 3.0,
              backgroundColor: Colors.white.withOpacity(0.2),
              color:
                  currentCalories > totalCalories ? Colors.red : Colors.white,
            ),
          ),
          // Konten di dalam lingkaran
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                text: '${currentCalories.toInt()}',
                style: txtPrimaryHeader.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: '/ ${totalCalories.toInt()}',
                    style: txtPrimarySubTitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 5,
              ),
              Text(
                'Kalori Tersisa',
                style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
