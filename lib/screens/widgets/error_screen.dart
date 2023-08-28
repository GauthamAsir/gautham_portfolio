import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/screens/home/home.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SelectableText(
              'OOps!!!, No Page available',
              style: Get.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(HomeScreen.routeName);
                  },
                  child: const Text('Go to home screen')),
            )
          ],
        ),
      ),
    );
  }
}
