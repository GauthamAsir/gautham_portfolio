import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/constants.dart';
import 'package:responsive_portfolio/models/Project.dart';
import 'package:responsive_portfolio/responsive.dart';
import 'package:responsive_portfolio/screens/home/components/home_controller.dart';
import 'package:responsive_portfolio/screens/home/components/project_details.dart';

import 'project_card.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  HomeController homeController = Get.put(HomeController());

  Project? pr;

  void showProjectFullDetails(int index, Project project) {
    homeController.showProjectDetails.value = true;
    pr = project;
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
        ));
  }
}

class ProjectsGridView extends StatelessWidget {
  const ProjectsGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    required this.onReadMore,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  final Function onReadMore;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: demo_projects.length,
      padding: EdgeInsets.all(defaultPadding / 2),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => ProjectCard(
        project: demo_projects[index],
        onReadMorePressed: () {
          onReadMore(index, demo_projects[index]);
        },
      ),
    );
  }
}
