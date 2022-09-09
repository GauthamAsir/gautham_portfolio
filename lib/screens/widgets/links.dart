import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.dart';

class Links extends StatelessWidget {
  final List<LinksModel> list;

  const Links({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        SizedBox(height: defaultPadding / 2),
        TextButton(
          onPressed: () async {
            String url = getLinkByName('Resume').url ?? '';
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
                  String url = getLinkByName('LinkedIn').url ?? '';
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                icon: SvgPicture.asset("assets/icons/linkedin.svg"),
              ),
              IconButton(
                onPressed: () async {
                  String url = getLinkByName('Github').url ?? '';
                  if (!await launch(url)) throw 'Could not launch $url';
                },
                icon: SvgPicture.asset("assets/icons/github.svg"),
              ),
              IconButton(
                onPressed: () async {
                  String url = getLinkByName('Twitter').url ?? '';
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

  LinksModel getLinkByName(String name) {
    return list.where((element) => element.name! == name).first;
  }
}
