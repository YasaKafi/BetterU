import 'package:flutter/material.dart';

import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';

class CardSportHorizontal extends StatelessWidget {
  CardSportHorizontal({
    super.key,
    required this.imageUrl,
    required this.textTitle,
  });

  String imageUrl;
  String textTitle;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(34, 34, 34, 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Center(
                child: Text(textTitle, style: txtPrimaryTitle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
              ),
            ]
        )
    );
  }
}