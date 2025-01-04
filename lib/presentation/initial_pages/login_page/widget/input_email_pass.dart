import 'package:better_u/presentation/initial_pages/login_page/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';

Widget buildEmailAndPassInputPage(double screenWidth, double screenHeight, LoginController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0),
    child: Column(
      children: [
        Container(
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
                  onPressed: controller.previousPage
              ),
              Text(
                'Masuk Ke Akun',
                style: txtSecondaryHeader.copyWith(
                    fontWeight: FontWeight.w700, color: blackColor),
              ),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            CustomTextFieldAuth(
              title: "Enter your email",
              controller: controller.emailController,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderFocusRadius: BorderRadius.all(Radius.circular(12)),
            ),
            SizedBox(height: 20),
            Text(
              "Password",
              style: txtSecondaryTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            CustomTextFieldAuth(
              title: "Enter your password",
              controller: controller.passwordController,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderFocusRadius: BorderRadius.all(Radius.circular(12)),
            ),
            SizedBox(height: 20),
            CommonButton(
              text: 'Masuk',
              onPressed: () => controller.postLogin(),
              width: screenWidth,
              height: 60,
              borderRadius: 10,
              icon: controller.isLoading.value == false ? Text('Masuk', style:  txtButton.copyWith(
                fontWeight:  FontWeight.w600,
                color:  baseColor,
                fontSize:  16,

              ),
              ) : LoadingAnimationWidget.staggeredDotsWave(
                color: baseColor,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: screenWidth,
              child: Center(
                child: Text(
                  'Lupa Password?',
                  style: txtSecondaryTitle.copyWith(
                      fontWeight: FontWeight.w600, color: primaryColor),
                ),
              ),
            ),


          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Dengan menggunakan BetterU, Anda menyetujui ',
              style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w400, color: blackColor),
              children: <TextSpan>[
                TextSpan(
                  text: 'Persyaratan',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' dan ',
                ),
                TextSpan(
                  text: 'Kebijakan Privasi.',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}