import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

import 'area_info_text.dart';
import 'coding.dart';
import 'knowledges.dart';
import 'links.dart';
import 'personal_info.dart';
import 'skills.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: FutureBuilder(
          future: mainController.getData(),
          builder: (_, snap) {
            if (snap.hasError) {
              return messageWidget(context,
                  useScaffold: false, msg: snap.error.toString());
            }

            if (snap.hasData) {
              FullDataModel fullDataModel = mainController.fullDataModel.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalInfo(personalData: fullDataModel.personalData!),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        AreaInfoText(
                          title: 'Residence',
                          text: fullDataModel.personalData!.residence ?? '',
                        ),
                        AreaInfoText(
                          title: 'Education',
                          text: fullDataModel.personalData!.education ?? '',
                        ),
                        AreaInfoText(
                          title: 'Age',
                          text: fullDataModel.personalData!.age.toString(),
                        ),
                        Skills(list: fullDataModel.skillsList ?? []),
                        Coding(list: fullDataModel.codingList ?? []),
                        Knowledge(list: fullDataModel.knowledgeList ?? []),
                        Links(
                          list: fullDataModel.linksList ?? [],
                        )
                      ],
                    ),
                  ))
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
