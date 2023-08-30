import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/base_scaffold.dart';
import 'package:gautham_portfolio/screens/main/components/initial_widget.dart';
import 'package:gautham_portfolio/screens/main/main_screen.dart';

class InitialScreen extends StatelessWidget {
  static const routeName = '/initial_screen';

  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // debugPrint('===========>>>>>>');
      Navigator.of(context).pushNamed(MainScreen.routeName);
    });

    return const BaseScaffold(
        body: Hero(
            tag: 'tag01',
            child: InitialWidget(
              animate: true,
            )));
  }
}
