import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_v2_pepe/app/const/app_colors.dart';
import 'package:weather_v2_pepe/app/data/models/geocoding_model.dart';
import 'package:weather_v2_pepe/app/widgets/show_list.dart';

import '../controllers/locate_location_controller.dart';

class LocateLocationView extends GetView<LocateLocationController> {
  const LocateLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appbar(),
        body: _body(),
      ),
    );
  }

  _appbar() {
    return AppBar(
      title: const Text('Weather'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: controller.goSetting,
          icon: const Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }

  _body() {
    final thisGeocoding = controller.geocoding;

    return Container(
      color: AppColors.backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                cursorColor: AppColors.primaryNight,
                controller: controller.searchTextCityController,
                style: const TextStyle(
                  color: AppColors.primaryNight,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.secondaryBox,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryNight,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                height: 400,
                color: Colors.blueAccent,
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: thisGeocoding.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.goShowDetail(
                            thisGeocoding[index],
                          ),
                          child: Container(
                            color: Colors.black87,
                            child: ShowList(
                              item: thisGeocoding[index],
                              onTap: () =>
                                  controller.goShowDetail(thisGeocoding[index]),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
