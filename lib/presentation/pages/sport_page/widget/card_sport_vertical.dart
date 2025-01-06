import 'package:better_u/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/dimensions.dart';
import '../../../../common/theme.dart';

class CardSportVertical extends StatelessWidget {
  CardSportVertical({
    super.key,
    required this.imageUrl,
    required this.textTitle,
    required this.textTime,
    required this.textCalories,
    required this.videoUrl,
  });

  String imageUrl;
  String textTitle;
  String textTime;
  String textCalories;
  Uri videoUrl;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ** Image & Text Data ** //
          Row(
            children: [
              Container(
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: screenWidth * 0.03),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.5,
                    child: Text(textTitle, style: txtPrimarySubTitle.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 7.5),

                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, color: blackColor, size: screenWidth * 0.04),
                          const SizedBox(width: 3),
                          Text('$textTime Menit', style: txtThirdSubTitle.copyWith(
                            color: greyDark,
                            fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      const SizedBox(width: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(icKaloriSport, width: screenWidth * 0.05, height: screenWidth * 0.05),
                          const SizedBox(width: 2),
                          Text(textCalories, style: txtThirdSubTitle.copyWith(
                            color: greyDark,
                            fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ]
                  )

                ],
              ),
            ],
          ),

          // ** Button Play Video ** //
          InkWell(
            onTap: () {
              launchUrl(videoUrl);
            },
            child: Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: screenWidth * 0.06,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}