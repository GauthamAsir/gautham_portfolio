import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/screens/add_project/add_project.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

class ListProject extends StatelessWidget {
  static const routeName = '/list_project';

  const ListProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestore.collection('Configs').doc('data').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            List d = snapshot.data?.data()?['projects'] ?? [];
            return ListView.builder(
                itemCount: d.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  ProjectModel projectModel = ProjectModel.fromMap(d[index]);
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.white12),
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(AddProject.routeName,
                            arguments: projectModel.toMap());
                      },
                      hoverColor: Colors.grey.shade800,
                      title: Text(projectModel.title ?? '',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        projectModel.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Icon(Icons.folder_open),
                      trailing: IconButton(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              content: Text(
                                  'Are you sure wan to delete this project?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () async {
                                      MainController main =
                                          Get.put(MainController());

                                      List<ProjectModel> list =
                                          main.fullDataModel.value.projectList!;

                                      // list.remove(projectModel);

                                      for (int i = 0; i < list.length; i++) {
                                        if (list[i].id! == projectModel.id) {
                                          list.removeAt(i);
                                          break;
                                        }
                                      }

                                      bool res =
                                          await main.addOrUpdateProject(list);

                                      Get.back();

                                      if (res) {
                                        showCustomSnackBar(
                                            'Project deleted from database');
                                        return;
                                      }
                                      showCustomSnackBar(
                                          'Unable to delete project from database');
                                    },
                                    child: Text('Yes')),
                              ],
                            ));
                          },
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          )),
                    ),
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
