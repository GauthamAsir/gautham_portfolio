import 'package:flutter/material.dart';

class BaseAppLoading extends StatelessWidget {
  final bool useScaffold;

  const BaseAppLoading({Key? key, this.useScaffold = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useScaffold
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
