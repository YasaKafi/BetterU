import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/theme.dart';

class ButtonWatchRecipe extends StatelessWidget {
  ButtonWatchRecipe({
    super.key,
    required this.videoUrl,
  });

  final Uri videoUrl;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          width: screenWidth,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              launchUrl(videoUrl);
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle, color: Colors.white, size: screenWidth * 0.07),

                  SizedBox(width: screenWidth * 0.025),

                  Text('Tonton Resep', style: txtPrimarySubTitle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  )),
                ]
              )
            ),
          ),
        )
    );
  }
}