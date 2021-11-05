import 'package:flutter/material.dart';
import 'package:responsive_portfolio/constants.dart';

import 'area_info_text.dart';
import 'coding.dart';
import 'knowledges.dart';
import 'links.dart';
import 'personal_info.dart';
import 'skills.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonalInfo(),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  AreaInfoText(
                    title: 'Residence',
                    text: 'Navi-Mumbai',
                  ),
                  AreaInfoText(
                    title: 'Education',
                    text: 'MSC C.S',
                  ),
                  AreaInfoText(
                    title: 'Age',
                    text: '21',
                  ),
                  Skills(),
                  Coding(),
                  Knowledges(),
                  Links()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
