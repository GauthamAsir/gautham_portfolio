import 'package:flutter/material.dart';
import 'package:responsive_portfolio/constants.dart';

import 'animated_progress_indicator.dart';

class Coding extends StatelessWidget {
  const Coding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            "Coding",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        AnimatedLinearProgressIndicator(
          percentage: 0.7,
          label: "Dart",
        ),
        AnimatedLinearProgressIndicator(
          percentage: 0.6,
          label: "Python",
        ),
        AnimatedLinearProgressIndicator(
          percentage: 0.8,
          label: "Java",
        ),
        AnimatedLinearProgressIndicator(
          percentage: 0.75,
          label: "C#",
        ),
        AnimatedLinearProgressIndicator(
          percentage: 0.58,
          label: "SQL",
        ),
      ],
    );
  }
}
