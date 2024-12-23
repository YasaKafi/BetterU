import 'package:better_u/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../controller/navbar_controller.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  final BottomNavigationController controller =
      Get.put(BottomNavigationController());

  final List<Widget> pages = [
    // HomePage(),
    // MenuPage(),
    // OrderPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: baseColor,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          unselectedLabelStyle: txtThirdSubTitle.copyWith(fontWeight: FontWeight.w600, color: primaryColor),
          selectedLabelStyle: txtThirdSubTitle.copyWith(fontWeight: FontWeight.w600, color: grey),
          unselectedItemColor: grey,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
              label: 'Home',
              activeIcon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
              label: 'Menu',
              activeIcon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
              label: 'Order',
              activeIcon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
              label: 'Profile',
              activeIcon: SvgPicture.asset(
                icLogoPrimary,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
