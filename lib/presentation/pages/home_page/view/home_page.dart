import 'package:better_u/common/constant.dart';
import 'package:better_u/common/theme.dart';
import 'package:better_u/presentation/global_components/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../route/app_pages.dart';
import '../controller/home_controller.dart';
import '../inner_pages/add_activity.dart';
import '../widget/card_current_nutrition.dart';
import '../widget/card_daily_water.dart';
import '../widget/list_card_activity.dart';


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
        onPressed: () => Get.toNamed(Routes.CHAT_BOT),
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






