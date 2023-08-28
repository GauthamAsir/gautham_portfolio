import 'package:flutter/material.dart';
import 'package:gautham_portfolio/screens/main/main_screen.dart';

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
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        MainScreen.routeName, (route) => false);
                  },
                  child: const Text('Go to home screen')),
            )
          ],
        ),
      ),
    );
  }
}
