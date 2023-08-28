import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/base_scaffold.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(body: Placeholder());
  }
}
