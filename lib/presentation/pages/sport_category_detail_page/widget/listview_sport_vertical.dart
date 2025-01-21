import 'package:better_u/presentation/pages/sport_page/widget/card_sport_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api/model/sport_model.dart';

class ListviewSportVertical extends StatelessWidget {
  const ListviewSportVertical({
    super.key,
    required this.sport,
  });

  final Rx<SportModel> sport;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      final sportData = sport.value;

      if (sportData.data == null || sportData.data!.isEmpty) {
        return SizedBox(
          width: screenWidth,
          height: screenHeight * 0.5,
          child: const Center(
            child: Text(
              "Tidak ada data olahraga yang ditemukan.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sportData.data!.length + 1, // Tambahkan 1 untuk SizedBox,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == sportData.data!.length) {
            return SizedBox(width: screenWidth * 0.05); // Ruang di akhir ListView
          }
          final item = sportData.data![index];

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            child: CardSportVertical(
              imageUrl: item.imageUrl ?? 'https://www.pallenz.co.nz/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png',
              textTitle: item.name ?? 'Nama Olahraga Tidak Diketahui',
              textTime: item.time.toString() ?? '0',
              textCalories: item.kalori.toString() ?? '0',
              videoUrl: Uri.parse(item.videoUrl ?? 'https://www.youtube.com/watch?v=6JYIGclVQdw')
            ),
          );
        },
      );
    });
  }
}
