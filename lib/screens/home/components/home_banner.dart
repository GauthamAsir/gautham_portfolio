import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/screens/widgets/responsive.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

class HomeBanner extends StatelessWidget {
  HomeBanner({Key? key}) : super(key: key);

  final MainController homeController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Responsive.isMobile(context) ? 2.5 : 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/bg.jpeg", fit: BoxFit.cover),
          Container(
            color: darkColor.withOpacity(0.66),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover my Amazing\nProjects',
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)
                      : Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (!Responsive.isMobileLarge(context))
                  SizedBox(
                    height: defaultPadding / 2,
                  ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle1!,
                  maxLines: 1,
                  child: AnimatedTextKit(animatedTexts: [
                    TyperAnimatedText('Hello,'),
                    TyperAnimatedText('I am Gautham'),
                  ]),
                ),
                if (!Responsive.isMobileLarge(context))
                  SizedBox(
                    height: defaultPadding,
                  ),
                if (!Responsive.isMobileLarge(context))
                  ElevatedButton(
                      onPressed: () {
                        homeController.projectScrollController.animateTo(
                            homeController.projectScrollController.position
                                    .maxScrollExtent /
                                2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOutSine);
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2,
                              vertical: defaultPadding),
                          backgroundColor: primaryColor),
                      child: Text(
                        'Explore',
                        style: TextStyle(color: darkColor),
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
