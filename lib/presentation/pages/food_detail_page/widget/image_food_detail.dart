import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ImageFoodDetail extends StatelessWidget {
  ImageFoodDetail({
    super.key,
    required this.imageUrl,
  });

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.3,
      child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5), // Use fromRGBO to set opacity
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),

          ]
      ),
    );
  }
}