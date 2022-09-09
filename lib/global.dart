import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/utils/utils.dart';

const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);

const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1); // we use it on our animation
const maxWidth = 1440.0; // max width of our web

Utils utils = Utils();

FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;

String get countString => 'count';

String get codingString => 'coding';

String get nameString => 'name';

String get percentageString => 'percentage';

String get positionString => 'position';

String get knowledgeString => 'knowledges';

String get activeString => 'active';

String get linksString => 'links';

String get personalDataString => 'personal_data';

String get ageString => 'age';

String get educationString => 'education';

String get imageString => 'image';

String get roleString => 'role';

String get skillsString => 'skills';

String get urlString => 'url';

String get residenceString => 'residence';

enum SnackType { Error, Warning, Normal }

enum FetchType { All, Coding, Knowledge, Links, PersonalData, Project, Skills }

extension SnackTypeExtension on SnackType {
  String get name {
    switch (this) {
      case SnackType.Error:
        return Colors.red.value.toString();
      case SnackType.Warning:
        return Colors.yellow.shade600.value.toString();
      default:
        return Colors.white38.value.toString();
    }
  }

  void talk() {
    print('meow');
  }
}

void showCustomSnackBar(String msg, {SnackType snackType = SnackType.Normal}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }

  Get.showSnackbar(GetSnackBar(
    message: msg,
    backgroundColor: Color(int.parse(snackType.name)),
    duration: Duration(seconds: 3),
    messageText: Text(
      msg,
      style:
          TextStyle(color: snackType.index == 1 ? Colors.black : Colors.white),
    ),
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
  ));
}

Widget messageWidget(BuildContext context,
    {String? msg, bool useScaffold = true}) {
  return useScaffold
      ? Scaffold(
          body: _messageWidget(context, msg: msg),
        )
      : _messageWidget(context, msg: msg);
}

Widget _messageWidget(BuildContext context, {String? msg}) {
  return Center(
    child: SelectableText(
      (msg ?? 'Something Went Wrong!'),
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w600, color: Colors.red),
    ),
  );
}
