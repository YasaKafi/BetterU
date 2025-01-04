import 'package:flutter/material.dart';

import '../../../../common/theme.dart';

class CalorieProgressWidget extends StatelessWidget {
  final double currentCalories;
  final double totalCalories;
  final double size;

  const CalorieProgressWidget({
    Key? key,
    required this.currentCalories,
    required this.totalCalories,
    this.size = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = (currentCalories / totalCalories).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lingkaran progress
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.7),
            ),
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 3.0,
              backgroundColor: Colors.white.withOpacity(0.2),
              color:
              currentCalories > totalCalories ? Colors.red : Colors.white,
            ),
          ),
          // Konten di dalam lingkaran
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                    text: '${currentCalories.toInt()}',
                    style: txtPrimaryHeader.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: '/ ${totalCalories.toInt()}',
                        style: txtPrimarySubTitle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                'Kalori Tersisa',
                style: txtSecondaryTitle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}