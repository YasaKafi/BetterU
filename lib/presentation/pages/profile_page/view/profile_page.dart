// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/theme.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: baseColor,
        body: Center(
          child: Text('Profile'),
        )
    );
  }
}
