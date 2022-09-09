import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

class PersonalInfo extends StatelessWidget {
  final PersonalDataModel personalData;

  PersonalInfo({Key? key, required this.personalData}) : super(key: key);

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.23,
        child: Container(
          color: Color(0xFF242430),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(
                flex: 2,
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    CachedNetworkImageProvider(personalData.image!),
              ),
              Spacer(),
              Text(
                personalData.name ?? '',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                personalData.role ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w200,
                    height: 1.5,
                    color: Colors.white30,
                    fontSize: 12),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }
}
