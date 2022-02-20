import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends StatelessWidget {
  const Links({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        SizedBox(height: defaultPadding / 2),
        TextButton(
          onPressed: () async {
            String url =
                'https://raw.githubusercontent.com/GauthamAsir/gautham_portfolio/base/Resume%20Gautham.pdf';
            if (!await launch(url)) throw 'Could not launch $url';
          },
          child: FittedBox(
            child: Row(
              children: [
                Text(
                  "DOWNLOAD CV",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                SizedBox(width: defaultPadding / 2),
                SvgPicture.asset("assets/icons/download.svg")
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: defaultPadding),
          color: Color(0xFF24242E),
          child: Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () async {
                  String url =
                      'https://www.linkedin.com/in/gautham-asir-772500156/';
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                icon: SvgPicture.asset("assets/icons/linkedin.svg"),
              ),
              IconButton(
                onPressed: () async {
                  String url = 'https://github.com/GauthamAsir';
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                icon: SvgPicture.asset("assets/icons/github.svg"),
              ),
              IconButton(
                onPressed: () async {
                  String url = 'https://twitter.com/Gautham0412';
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                icon: SvgPicture.asset("assets/icons/twitter.svg"),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
