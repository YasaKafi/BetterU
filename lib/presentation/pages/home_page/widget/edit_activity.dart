import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../../data/api/auth/model/current_combo_model.dart';
import '../../../global_components/common_button.dart';
import '../../../global_components/textfield_auth_custom.dart';
import '../controller/home_controller.dart';

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