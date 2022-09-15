import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/screens/add_project/add_project.dart';
import 'package:responsive_portfolio/screens/list_projects/list_project.dart';

class ActionsScreen extends StatelessWidget {
  static const routeName = '/actions';

  const ActionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: firestore.collection('Configs').doc('views').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError || snapshot.hasData) {
                  return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: snapshot.hasError
                          ? Text(
                              'Unable to get Total Views\n${snapshot.error.toString()}',
                              key: UniqueKey(),
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.headline6)
                          : Text(
                              'Total Views: ${snapshot.data!.data()!['count'].toString()}',
                              key: UniqueKey(),
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.headline6,
                            ));
                }
                return CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(ListProject.routeName);
                },
                child: Text('List Projects')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AddProject.routeName);
                },
                child: Text('Add Project')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showCustomSnackBar('W.I.P');
                },
                child: Text('Edit Configs')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
