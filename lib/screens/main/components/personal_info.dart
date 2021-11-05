import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.23,
        child: Container(
          color: Color(0xFF242430),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(flex: 2,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    "assets/images/my_pic3.jpg"),
              ),
              Spacer(),
              Text(
                'Gautham',
                style:
                Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                'App & Website Developer',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!
                    .copyWith(fontWeight: FontWeight.w200,
                    height: 1.5, color: Colors.white30, fontSize: 12),
              ),
              Spacer(flex: 2,),
            ],
          ),
        ));
  }
}
