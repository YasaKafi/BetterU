
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/dimensions.dart';
import '../../common/theme.dart';

class ShimmerWidgets {
  static Widget carousel({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  static Widget userHome() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180,
            height: 16,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }


  static Widget items({double? width = 100, double? height = 20}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180,
            height: 16,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  static Widget point() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 16,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  static Widget boxNutrition(double screenWidth) {
    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
          ],
          stops: [0.65, 1],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: screenWidth,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildShimmerColumn('Dimakan'),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                buildShimmerColumn('Terbakar'),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildShimmerProgress(''),
                buildShimmerProgress(''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget layoutProfile(double screenWidth) {
    return  Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 30,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 40),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200,
              height: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 250,
              height: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 40),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: screenWidth,
              height: 60,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 40),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: screenWidth,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: screenWidth,
              height: 60,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: screenWidth,
              height: 60,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildShimmerColumn(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Container(
            height: 20,
            width: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildShimmerProgress(String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 75,
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey[200],
                  minHeight: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 20,
                width: 100,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget shimmerCard() {
    return Column(
      children: [
        ...List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 16,
                              width: 150,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 17),
                  Container(
                    height: 16,
                    width: 200,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  static Widget shimmerHorizontalFoodCard({screenWidth, screenHeight}) {
    return Row(
      children: [
        ...List.generate(2, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: screenWidth * 0.4,
              height: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Image shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Gradient overlay shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(34, 34, 34, 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Text shimmer
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.38,
                          height: screenHeight * 0.05,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.02,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  static Widget shimmerHorizontalSportCard({screenWidth, screenHeight}) {
    return Row(
      children: [
        ...List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Image shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Gradient overlay shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(34, 34, 34, 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Text shimmer
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.38,
                          height: screenHeight * 0.05,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.02,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }


  static Widget shimmerVerticalFoodCard({screenWidth, screenHeight}) {
    return Column(
      children: [
        ...List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: screenWidth,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Image shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Gradient overlay shimmer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(34, 34, 34, 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Text shimmer
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth * 0.38,
                          height: screenHeight * 0.05,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.02,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }


  static Widget shimmerVerticalSportCard({screenWidth, screenHeight}) {
    return Column(
      children: [
        ...List.generate(6, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ** Image Shimmer ** //
                  Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.03),

                  // ** Text Data Shimmer ** //
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 7.5),
                      Row(
                        children: [
                          Container(
                            width: screenWidth * 0.15,
                            height: 15,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: screenWidth * 0.15,
                            height: 15,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ** Button Play Video Shimmer ** //
                  Container(
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration:  BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

}