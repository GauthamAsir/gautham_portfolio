import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

import 'animated_progress_indicator.dart';

class Coding extends StatelessWidget {
  Coding({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<CodingModel> list;
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            "Coding",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              CodingModel coding = list[index];

              return AnimatedLinearProgressIndicator(
                percentage: coding.percentage! / 100,
                label: coding.name ?? '',
              );
            })
        // AnimatedLinearProgressIndicator(
        //   percentage: 0.6,
        //   label: "Python",
        // ),
        // AnimatedLinearProgressIndicator(
        //   percentage: 0.8,
        //   label: "Java",
        // ),
        // AnimatedLinearProgressIndicator(
        //   percentage: 0.75,
        //   label: "C#",
        // ),
        // AnimatedLinearProgressIndicator(
        //   percentage: 0.58,
        //   label: "SQL",
        // ),
      ],
    );
  }
}
