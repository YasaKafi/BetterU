import 'package:better_u/presentation/initial_pages/register_page/widget/input_biodata.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../controller/register_controller.dart';
import '../widget/input_activity.dart';
import '../widget/input_bb_tb.dart';
import '../widget/input_email.dart';
import '../widget/input_goals.dart';
import '../widget/input_otp.dart';
import '../widget/input_password.dart';
import '../widget/introduction_create_account.dart';
import '../widget/success_register.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({Key? key}) : super(key: key);

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

    void datePicker() {
      BottomPicker.date(
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: DateTime(1996, 10, 22),
        maxDateTime: DateTime(2100),
        minDateTime: DateTime(1980),
        pickerTextStyle: txtSecondaryTitle.copyWith(
            fontWeight: FontWeight.w500, color: primaryColor),
        onChange: (index) {
          print(index);
        },
        buttonStyle: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        onSubmit: (index) {
          controller.birthDateController.text =
              '${index.year}-${index.month}-${index.day}';
        },
        bottomPickerTheme: BottomPickerTheme.plumPlate,
        pickerTitle: Text(''),
      ).show(context);
    }

    return Scaffold(
        backgroundColor: baseColor,
        body: SafeArea(
          child: Obx(() {
            return IndexedStack(
              index: controller.currentPage.value,
              children: [
                buildIntroductionCreateAccount(
                    screenWidth, screenHeight, controller, stringToBool(isFromOnboard)),
                buildEmailInputPage(screenWidth, screenHeight, controller),
                buildOtpVerificationPage(screenWidth, screenHeight, controller),
                buildPasswordCreationPage(screenWidth, screenHeight, controller),
                buildBiodataInputPage(
                    screenWidth, screenHeight, controller, datePicker),
                buildGoalsInputPage(screenWidth, screenHeight, controller),
                buildActivityInputPage(screenWidth, screenHeight, controller),
                buildBbTbInputPage(screenWidth, screenHeight, controller),
                buildSuccessCreateAccount(screenWidth, screenHeight, controller),
              ],
            );
          }),
        ));
  }
}
