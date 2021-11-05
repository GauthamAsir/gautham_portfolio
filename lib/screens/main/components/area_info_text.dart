import 'package:flutter/material.dart';
import 'package:responsive_portfolio/constants.dart';

class AreaInfoText extends StatelessWidget {
  const AreaInfoText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String? title, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          ),
          Text(text!,
            style: Theme.of(context).textTheme.bodyText1!,),
        ],
      ),
    );
  }
}
