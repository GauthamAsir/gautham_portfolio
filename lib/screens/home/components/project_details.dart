import 'package:flutter/material.dart';
import 'package:responsive_portfolio/models/Project.dart';
import 'package:responsive_portfolio/responsive.dart';

class ProjectDetail extends StatelessWidget {
  final Project project;
  final VoidCallback onBackPressed;

  const ProjectDetail(
      {Key? key, required this.project, required this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          leading: IconButton(
              onPressed: onBackPressed, icon: Icon(Icons.chevron_left)),
          title: Responsive.isMobile(context)
              ? FittedBox(
                  child: Text(
                    project.title!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              : Text(
                  project.title!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 60),
          subtitle: Text(
            project.longDesc!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.white54),
            maxLines: 50,
          ),
        )
      ],
    );
  }
}
