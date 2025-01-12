import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/food_list_model.dart';
import '../widget/card_food_vertical.dart';

class ListviewFoodVertical extends StatelessWidget {
  const ListviewFoodVertical({
    super.key,
    required this.foodList,
  });

  final Rx<FoodListModel> foodList;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      final foodPopularData = foodList.value;

      if (foodPopularData.data == null || foodPopularData.data!.isEmpty) {
        return SizedBox(
          width: screenWidth,
          height: screenHeight * 0.5,
          child: const Center(
            child: Text(
              "Tidak ada data makanan.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: foodPopularData.data!.length + 1, // Tambahkan 1 untuk SizedBox,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == foodPopularData.data!.length) {
            return SizedBox(width: screenWidth * 0.05); // Ruang di akhir ListView
          }
          final item = foodPopularData.data![index];

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            child: InkWell(
              onTap: () {
                Get.toNamed('/food-detail-page',
                  arguments: {
                    'id': item.id.toString(),
                  },
                );
              },
              child: CardFoodVertical(
                imageUrl: item.imageUrl ?? 'https://www.pallenz.co.nz/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
                textTitle: item.name ?? 'Nama Makanan Tidak Diketahui',
                textCalories: item.kalori.toString() ?? '0',
                textTime: item.time.toString() ?? '0',
              ),
            ),
          );
        },
      );
    });
  }
}
