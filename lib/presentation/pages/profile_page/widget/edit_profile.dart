import 'package:better_u/presentation/pages/profile_page/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/theme.dart';
import '../../../../data/api/model/current_user_model.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';

class EditProfile extends StatefulWidget {
  final DataUser item;
  final controller = Get.put(ProfileController());
  EditProfile( {Key? key, required this.item}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController goalsController;
  late TextEditingController levelActivityController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;

  final List<String> goalsOptions = ['Menurunkan Berat Badan', 'Menjaga Berat Badan', 'Menaikkan Berat Badan'];
  final List<String> activityLevelOptions = ['Sangat Jarang Beraktivitas', 'Jarang Beraktivitas', 'Cukup Beraktivitas', 'Sering Beraktivitas', 'Sangat Sering Beraktivitas'];

  String? selectedGoal;
  String? selectedActivityLevel;

  @override
  void initState() {
    super.initState();
    goalsController = TextEditingController(text: widget.item.goals ?? '');
    levelActivityController = TextEditingController(text: widget.item.activityLevel ?? '');
    heightController = TextEditingController(text: widget.item.height?.toString() ?? '');
    weightController = TextEditingController(text: widget.item.weight?.toString() ?? '');
    ageController = TextEditingController(text: widget.item.age?.toString() ?? '');

    selectedGoal = widget.item.goals;
    selectedActivityLevel = widget.item.activityLevel;
  }

  @override
  void dispose() {
    goalsController.dispose();
    levelActivityController.dispose();
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Widget buildCustomDropdown({
    required List<String> options,
    required String hintText,
    String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: blackColor),
        borderRadius: BorderRadius.circular(12),
        color: baseColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: baseColor,
          value: selectedValue,
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          hint: Text(hintText, style: txtSecondaryTitle.copyWith(
              fontWeight: FontWeight.w600, color: blackColor)),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w600, color: blackColor)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              onChanged(value);
            });
          },
        ),
      ),
    );
  }

  String calculateDateOfBirth(int age) {
    final birthOfDateUser = widget.item.dateOfBirth ?? '';
    final convertedDate = DateTime.parse(birthOfDateUser);

    final currentDate = DateTime.now();
    final birthYear = currentDate.year - age;
    final dateOfBirth = DateTime(birthYear, convertedDate.month, convertedDate.day);
    return DateFormat('yyyy-MM-dd').format(dateOfBirth);

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
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Edit Data',
                      style: txtSecondaryHeader.copyWith(fontWeight: FontWeight.w700, color: blackColor),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tujuan
                    Text("Tujuan", style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    buildCustomDropdown(
                      options: goalsOptions,
                      hintText: "Enter your goals",
                      selectedValue: selectedGoal,
                      onChanged: (value) {
                        selectedGoal = value;
                        goalsController.text = value ?? '';
                      },
                    ),
                    SizedBox(height: 15),

                    // Level Aktivitas
                    Text("Level Aktivitas", style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    buildCustomDropdown(
                      options: activityLevelOptions,
                      hintText: "Enter your level activity",
                      selectedValue: selectedActivityLevel,
                      onChanged: (value) {
                        selectedActivityLevel = value;
                        levelActivityController.text = value ?? '';
                      },
                    ),
                    SizedBox(height: 15),

                    // Tinggi Badan
                    Text("Tinggi Badan(cm)", style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    CustomTextFieldAuth(
                      title: "Enter total height",
                      controller: heightController,
                      isNumeric: true,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderFocusRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    SizedBox(height: 15),

                    // Berat Badan
                    Text("Berat Badan(kg)", style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    CustomTextFieldAuth(
                      title: "Enter total weight",
                      controller: weightController,
                      isNumeric: true,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderFocusRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    SizedBox(height: 15),

                    // Usia
                    Text("Usia", style: txtSecondaryTitle.copyWith(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    CustomTextFieldAuth(
                      title: "Enter your age",
                      controller: ageController,
                      isNumeric: true,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderFocusRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    SizedBox(height: 30),

                    CommonButton(
                      text: 'Edit',
                      onPressed: () {
                        final birthOfDateUser = widget.item.dateOfBirth ?? '';
                        final convertedDate = DateTime.parse(birthOfDateUser);
                        final age = int.tryParse(ageController.text) ?? 0;
                        final calculatedDateOfBirth = calculateDateOfBirth(age);

                        // Cek jika ada perubahan pada selectedGoal atau selectedActivityLevel
                        if (selectedGoal != widget.item.goals || selectedActivityLevel != widget.item.activityLevel) {
                          Get.dialog(
                            Dialog(
                              backgroundColor: baseColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Perubahan Tujuan atau Aktivitas',
                                      style: txtPrimaryTitle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: blackColor),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Jika Anda mengubah tujuan atau level aktivitas, kebutuhan nutrisi harian Anda akan direset. Apakah Anda yakin ingin melanjutkan?',
                                      textAlign: TextAlign.center,
                                      style: txtPrimarySubTitle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CommonButton(
                                            text: 'Batal',
                                            style: txtButton.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            borderRadius: 10,
                                            border: BorderSide(
                                              color: primaryColor,
                                              width: 2,
                                            ),
                                            backgroundColor: baseColor),
                                        CommonButton(
                                          text: 'Lanjutkan',
                                          onPressed: () {
                                            Get.back();
                                            widget.controller.putEditProfile(
                                              birthDateController: calculatedDateOfBirth,
                                              weightController: weightController,
                                              heightController: heightController,
                                              selectedGoal: selectedGoal ?? widget.item.goals ?? '',
                                              selectedActivity: selectedActivityLevel ?? widget.item.activityLevel ?? '',
                                            );
                                            Get.back();

                                          },
                                          // height: 60,
                                          borderRadius: 10,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                        } else {
                          // Jika tidak ada perubahan, langsung panggil method putEditProfile
                          widget.controller.putEditProfile(
                            birthDateController: calculatedDateOfBirth,
                            weightController: weightController,
                            heightController: heightController,
                            selectedGoal: selectedGoal ?? widget.item.goals ?? '',
                            selectedActivity: selectedActivityLevel ?? widget.item.activityLevel ?? '',
                          );
                          Get.back();
                        }
                      },
                      height: 60,
                      borderRadius: 15,
                      width: screenWidth,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


