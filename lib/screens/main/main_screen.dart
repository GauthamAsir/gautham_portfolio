import 'package:flutter/material.dart';
import 'package:responsive_portfolio/constants.dart';
import 'package:responsive_portfolio/responsive.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hide AppBar if its Desktop View
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: bgColor,
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              ),
            ),
      drawer: SideMenu(),
      body: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show SideMenu only in Desktop View
            if (Responsive.isDesktop(context))
              Expanded(
                  // 22% of screen
                  // 2+7 = 9 | (2/9) = 0.22 i.e 22%
                  flex: 2,
                  child: Container(
                    child: SideMenu(),
                  )),
            SizedBox(
              width: defaultPadding,
            ),
            Expanded(
                // 78% of screen
                // 7/9 = 0.78 i.e 78%
                flex: 7,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [...children],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
