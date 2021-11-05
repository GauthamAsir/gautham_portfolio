import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_portfolio/constants.dart';

class Links extends StatelessWidget {
  const Links({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        SizedBox(height: defaultPadding / 2),
        TextButton(
          onPressed: () {},
          child: FittedBox(
            child: Row(
              children: [
                Text(
                  "DOWNLOAD CV",
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color,
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
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/linkedin.svg"),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/github.svg"),
              ),
              IconButton(
                onPressed: () {},
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
