import 'package:better_u/presentation/pages/sport_page/widget/card_sport_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/sport_category_model.dart';

class ListviewSportHorizontal extends StatelessWidget {
  const ListviewSportHorizontal({
    super.key,
    required this.sportCategory,
    required this.onTap
  });

  final Rx<SportCategoryModel> sportCategory;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final categoryData = sportCategory.value;

      if (categoryData.data == null || categoryData.data!.isEmpty) {
        return SizedBox(
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          child: const Center(
            child: Text(
              "Tidak ada category",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryData.data!.length + 1, // Tambahkan 1 untuk SizedBox
        itemBuilder: (context, index) {
          if (index == categoryData.data!.length) {
            return SizedBox(width: screenWidth * 0.05); // Ruang di akhir ListView
          }
          final item = categoryData.data![index];
          return InkWell(
            onTap: () {
              onTap(item.name ?? '');
            },
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              margin: EdgeInsets.only(left: screenWidth * 0.05),
              child: CardSportHorizontal(
                imageUrl: item.imageUrl ?? 'https://www.pallenz.co.nz/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                textTitle: item.name ?? 'Nama Kategori Tidak Diketahui',
              ),
            ),
          );
        },
      );
    });
  }
}