import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/locate_location_controller.dart';

class LocateLocationView extends GetView<LocateLocationController> {
  const LocateLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
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
    return const Center(
      child: Text(
        'LocateLocationView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
