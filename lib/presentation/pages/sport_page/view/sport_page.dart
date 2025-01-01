import 'package:better_u/presentation/pages/food_page/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';

class SportPage extends GetView<FoodController> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: baseColor,
        body: Center(
          child: Text('Sport'),
        )
    );
  }
}