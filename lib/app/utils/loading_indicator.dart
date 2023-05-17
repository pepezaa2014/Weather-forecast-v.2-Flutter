import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/resources/resources.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    required this.isLoading,
  });
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Positioned.fill(
        child: Container(
          color: AppColors.loadingIndicator,
          child: Center(
            child: Platform.isAndroid
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageName.weather04n,
                        width: 200,
                        height: 200,
                      ),
                      const SpinKitCircle(
                        color: AppColors.primaryNight,
                        size: 50,
                      ),
                    ],
                  )
                : const CupertinoActivityIndicator(radius: 16),
          ),
        ),
      ),
    );
  }
}
