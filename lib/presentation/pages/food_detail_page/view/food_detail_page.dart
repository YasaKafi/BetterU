import 'package:better_u/presentation/pages/food_detail_page/widget/button_watch_recipe.dart';
import 'package:better_u/presentation/pages/food_detail_page/widget/image_food_detail.dart';
import 'package:better_u/presentation/pages/food_detail_page/widget/nutrition_food_detail.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme.dart';
import '../controller/food_detail_controller.dart';

class FoodDetailPage extends GetView<FoodDetailController> {
  const FoodDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: grey2,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final foodData = controller.food.value;

          if (foodData.data == null) {
            return SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: const Center(
                child: Text("Data makanan tidak ditemukan", style: const TextStyle(color: Colors.grey),),
              ),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight,
                  ),
                  child: SizedBox(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageFoodDetail(imageUrl: foodData.data!.imageUrl ?? 'https://www.pallenz.co.nz/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png'),
                        NutritionFoodDetail(
                          textTitle: foodData.data!.name ?? 'nama makanan',
                          textCalories: foodData.data!.kalori.toString() ?? '0',
                          textTime: foodData.data!.time.toString() ?? '0',
                          textProtein: foodData.data!.protein.toString() ?? '0',
                          textKarbo: foodData.data!.karbohidrat.toString() ?? '0',
                          textLemak: foodData.data!.lemak.toString() ?? '0',
                          textCatatan: foodData.data!.note ?? 'Tidak ada catatan',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ButtonWatchRecipe(videoUrl: Uri.parse(foodData.data!.videoUrl ?? 'https://www.youtube.com/watch?v=QwievZ1Tx-8'))
            ],
          );
        }),
      ),
    );
  }
}
