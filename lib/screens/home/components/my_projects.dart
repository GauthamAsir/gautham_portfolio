import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/screens/home/components/project_details.dart';
import 'package:responsive_portfolio/screens/widgets/responsive.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

import 'project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  MainController homeController = Get.put(MainController());

  ProjectModel? pr;

  void showProjectFullDetails(int index, ProjectModel project) {
    homeController.showProjectDetails.value = true;
    pr = project;
  }

  @override
  void initState() {
    if (!kDebugMode) {
      firestore
          .collection('Configs')
          .doc('views')
          .update({'count': FieldValue.increment(1)}).then((value) {
        log('Count Updated');
        return null;
      }).catchError((error) {
        log('Push Error: ${error.toString()}');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1.2, 0), end: Offset(0, 0))
                  .animate(animation),
              child: child,
            );
          },
          child: WillPopScope(
              child: homeController.showProjectDetails.value
                  ? ProjectDetail(
                      project: pr!,
                      onBackPressed: () {
                        homeController.showProjectDetails.value = false;
                        pr = null;
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Projects",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: defaultPadding),
                        Responsive(
                          mobile: ProjectsGridView(
                            crossAxisCount: 1,
                            childAspectRatio: 1.7,
                            onReadMore: showProjectFullDetails,
                          ),
                          mobileLarge: ProjectsGridView(
                            crossAxisCount: 2,
                            onReadMore: showProjectFullDetails,
                          ),
                          tablet: ProjectsGridView(
                            childAspectRatio: 1.1,
                            onReadMore: showProjectFullDetails,
                          ),
                          desktop: ProjectsGridView(
                            onReadMore: showProjectFullDetails,
                          ),
                        )
                      ],
                    ),
              onWillPop: () {
                homeController.showProjectDetails.value =
                    !homeController.showProjectDetails.value;
                return Future.value(false);
              }),
        ));
  }
}

class ProjectsGridView extends StatelessWidget {
  ProjectsGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    required this.onReadMore,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  final Function onReadMore;

  final MainController homeController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: homeController.getData(fetchType: FetchType.Project),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return messageWidget(context,
                useScaffold: false, msg: 'Unable to load Projects');
          }

          if (snapshot.hasData) {
            if (snapshot.data is List<ProjectModel>) {
              List<ProjectModel> list = snapshot.data as List<ProjectModel>;

              return GridView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                padding: EdgeInsets.all(defaultPadding / 2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                ),
                itemBuilder: (context, index) => ProjectCard(
                  project: list[index],
                  onReadMorePressed: () {
                    onReadMore(index, list[index]);
                  },
                ),
              );
            }

            return messageWidget(context,
                useScaffold: false,
                msg: (snapshot.data as Response).body.toString());
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
