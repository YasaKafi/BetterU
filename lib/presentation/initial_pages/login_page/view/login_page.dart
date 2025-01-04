import 'package:better_u/presentation/initial_pages/register_page/widget/input_biodata.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../controller/login_controller.dart';
import '../widget/input_email_pass.dart';
import '../widget/introduction_create_account.dart';


class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: baseColor,
        body: SafeArea(
          child: Obx(() {
            return IndexedStack(
              index: controller.currentPage.value,
              children: [
                buildIntroductionCreateAccountLogin(
                    screenWidth, screenHeight, controller),
                buildEmailAndPassInputPage(screenWidth, screenHeight, controller),
              ],
            );
          }),
        ));
  }
}
