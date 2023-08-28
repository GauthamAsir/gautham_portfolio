import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/base_buttons.dart';
import 'package:gautham_portfolio/core/base_widgets/base_scaffold.dart';
import 'package:gautham_portfolio/screens/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BasePrimaryButton(
          text: 'Home',
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.routeName);
          },
        )
      ],
    ));
  }
}
