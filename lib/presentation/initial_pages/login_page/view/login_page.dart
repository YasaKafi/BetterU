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
    final arguments = Get.arguments;
    final isFromOnboard = arguments?['isFromOnboard'] ?? 'false';

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool? stringToBool(String value) {
      if (value.toLowerCase() == 'true') return true;
      if (value.toLowerCase() == 'false') return false;
      return null;
    }

    return Scaffold(
        backgroundColor: baseColor,
        body: SafeArea(
          child: Obx(() {
            return IndexedStack(
              index: controller.currentPage.value,
              children: [
                buildIntroductionCreateAccountLogin(
                    screenWidth, screenHeight, controller, stringToBool(isFromOnboard)),
                buildEmailAndPassInputPage(screenWidth, screenHeight, controller),
              ],
            );
          }),
        ));
  }
}
