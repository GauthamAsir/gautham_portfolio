import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/screens/add_project/add_project.dart';
import 'package:responsive_portfolio/screens/list_projects/list_project.dart';

class ActionsScreen extends StatelessWidget {
  static const routeName = '/actions';

  const ActionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(ListProject.routeName);
                },
                child: Text('List Projects')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AddProject.routeName);
                },
                child: Text('Add Project')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar('W.I.P');
                },
                child: Text('Edit Configs')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
