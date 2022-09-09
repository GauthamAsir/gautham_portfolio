import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/screens/home/components/my_projects.dart';
import 'package:responsive_portfolio/screens/main_screen.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

import 'components/home_banner.dart';

class HomeScreen extends GetView<MainController> {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());

    return Obx(() => MainScreen(children: [
          controller.showProjectDetails.value ? Container() : HomeBanner(),
          MyProjects()
        ]));
  }
}
