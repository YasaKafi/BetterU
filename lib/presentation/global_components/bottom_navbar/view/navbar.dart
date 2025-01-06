import 'package:better_u/common/constant.dart';
import 'package:better_u/presentation/pages/home_page/controller/home_controller.dart';
import 'package:better_u/presentation/pages/sport_page/view/sport_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../pages/food_page/view/food_page.dart';
import '../../../pages/home_page/view/home_page.dart';
import '../../../pages/profile_page/view/profile_page.dart';
import '../controller/navbar_controller.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  final BottomNavigationController controller =
  Get.put(BottomNavigationController());


  final List<Widget> pages = [
    HomePage(),
    FoodPage(),
    Placeholder(),
    SportPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor: baseColor,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            if (index == 2) {
              _openCamera(context);
            } else {
              controller.changePage(index);
            }
          },
          unselectedLabelStyle: txtSecondarySubTitle.copyWith(
              fontWeight: FontWeight.w600, color: primaryColor),
          selectedLabelStyle: txtSecondarySubTitle.copyWith(
              fontWeight: FontWeight.w600, color: grey),
          unselectedItemColor: grey,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icHomeUnactive,
                width: 24,
                height: 24,
              ),
              label: 'Beranda',
              activeIcon: SvgPicture.asset(
                icHomeActive,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icFoodUnactive,
                width: 24,
                height: 24,
              ),
              label: 'Makanan',
              activeIcon: SvgPicture.asset(
                icFoodActive,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icScanner,
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icSportUnactive,
                width: 24,
                height: 24,
              ),
              label: 'Olahraga',
              activeIcon: SvgPicture.asset(
                icSportActive,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icProfileUnactive,
                width: 24,
                height: 24,
              ),
              label: 'Profil',
              activeIcon: SvgPicture.asset(
                icProfileActive,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCamera(BuildContext context) {
    final HomeController controller = Get.find();

    controller.pickImageFromCamera().then((_) {
      if (controller.selectedImage.value != null) {
        controller.postPredictAndAnalyzeFood(context);
      }
    });
  }
}

