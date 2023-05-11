import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loadingIndicator,
      body: Center(
        child: Image.asset(
          controller.logoName,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
