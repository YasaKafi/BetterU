// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:better_u/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../global_components/common_button.dart';
import '../controller/profile_controller.dart';
import '../widget/edit_profile.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwWidth = MediaQuery.of(context).size.width;
    double screenwHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: SafeArea(child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            String gif() {
              final String gender = controller.dataUser.value!.gender!;

              if (gender == 'Laki Laki') {
                return gifMaleAvatar;
              } else {
                return gifFemaleAvatar;
              }
            }

            return Container(
              width: screenwWidth,
              height: screenwHeight,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  Text(
                    'Profil',
                    style: txtPrimaryHeader.copyWith(
                        fontWeight: FontWeight.w600, color: blackColor),
                  ),
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(gif()),
                  ),
                  SizedBox(height: 20),
                  Text(
                    controller.dataUser.value?.name ?? '',
                    style: txtPrimaryHeader.copyWith(
                        fontWeight: FontWeight.w600, color: blackColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.dataUser.value?.email ?? '',
                    style: txtSecondaryHeader.copyWith(
                        fontWeight: FontWeight.w400, color: blackColor),
                  ),
                  SizedBox(height: 40),
                  CommonButton(
                    backgroundColor: primaryColor,
                    icon: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icHistory,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Riwayat Kegiatan',
                            style: txtSecondaryTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: baseColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    text: '',
                    onPressed: () {},
                    height: 60,
                    width: screenwWidth,
                    borderRadius: 10,
                  ),
                  SizedBox(height: 40),
                  Column(
                    children: [
                      Container(
                        width: screenwWidth,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tujuan',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              controller.dataUser.value?.goals ?? '',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenwWidth,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kelamin',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              controller.dataUser.value?.gender ?? '',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenwWidth,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tinggi Badan',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              '${controller.dataUser.value?.height.toString()}cm' ?? '',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenwWidth,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Berat Badan',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              '${controller.dataUser.value?.weight.toString()}kg' ?? '',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenwWidth,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Usia',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              controller.dataUser.value?.age.toString() ?? '',
                              style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    backgroundColor: baseColor,
                    icon: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icEdit,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Data Diri',
                            style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w600, color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    text: '',
                    onPressed: () {
                      Get.to(() => EditProfile(item: controller.dataUser.value!,));
                    },
                    height: 60,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    borderRadius: 10,
                    style: txtButton.copyWith(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    border:
                    BorderSide(color: primaryColor, style: BorderStyle.solid),
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    backgroundColor: baseColor,
                    icon: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icLogout,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Keluar',
                            style: txtSecondaryTitle.copyWith(
                                fontWeight: FontWeight.w600, color: redMedium),
                          ),
                        ],
                      ),
                    ),
                    text: '',
                    onPressed: () {
                      controller.deleteTokenUser();
                    },
                    height: 60,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    borderRadius: 10,
                    style: txtButton.copyWith(
                      fontWeight: FontWeight.w600,
                      color: redMedium,
                    ),
                    border:
                    BorderSide(color: redMedium, style: BorderStyle.solid),
                  ),
                ],
              ),
            );
          }
        })),
      ),
    );
  }
}
