import 'package:flutter/material.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';

import 'animated_progress_indicator.dart';

class Skills extends StatelessWidget {
  final List<SkillsModel> list;

  const Skills({
    Key? key,
    required this.list,
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
            "Skills",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Row(
          children: [
            for (int i = 0; i < list.length; i++) ...[
              SizedBox(width: i == 0 ? 0 : defaultPadding),
              Expanded(
                child: AnimatedCircularProgressIndicator(
                  percentage: (list[i].percentage ?? 1) / 100,
                  label: list[i].name ?? '',
                ),
              ),
            ],
            // Expanded(
            //   child: AnimatedCircularProgressIndicator(
            //     percentage: 0.8,
            //     label: "Flutter",
            //   ),
            // ),
            // SizedBox(width: defaultPadding),
            // Expanded(
            //   child: AnimatedCircularProgressIndicator(
            //     percentage: 0.6,
            //     label: ".NET",
            //   ),
            // ),
            // SizedBox(width: defaultPadding),
            // Expanded(
            //   child: AnimatedCircularProgressIndicator(
            //     percentage: 0.69,
            //     label: "Firebase",
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
