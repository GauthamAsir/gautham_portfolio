import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/screens/home/components/home_controller.dart';
import 'package:responsive_portfolio/screens/home/components/my_projects.dart';
import 'package:responsive_portfolio/screens/main/main_screen.dart';

import 'components/home_banner.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Obx(() => MainScreen(children: [
          controller.showProjectDetails.value ? Container() : HomeBanner(),
          MyProjects()
        ]));
  }
}
