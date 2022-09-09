import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/screens/login/components/auth_controller.dart';
import 'package:responsive_portfolio/screens/login/login_screen.dart';
import 'package:responsive_portfolio/screens/widgets/app_text_field.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

class AddProject extends StatelessWidget {
  static const routeName = '/0412/add_project';

  AddProject({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: authController.firebaseUser == null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You need to authenticate first',
                        style: Get.textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AdminLoginScreen.routeName);
                          },
                          child: Text('Go to Login'),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        // shrinkWrap: true,
                        // physics: BouncingScrollPhysics(),
                        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                              controller: authController.titleController,
                              label: 'Title'),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                              controller: authController.descriptionController,
                              label: 'Description'),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                              controller: authController.longDescController,
                              label: 'Long Description'),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (authController
                                        .titleController.text.isNotEmpty &&
                                    authController.descriptionController.text
                                        .isNotEmpty &&
                                    authController
                                        .longDescController.text.isNotEmpty) {
                                  MainController main =
                                      Get.put(MainController());

                                  List<ProjectModel> list =
                                      main.fullDataModel.value.projectList!;
                                  list.add(ProjectModel(
                                      id: list.length,
                                      position: list.length,
                                      title:
                                          authController.titleController.text,
                                      longDesc: authController
                                          .longDescController.text,
                                      description: authController
                                          .descriptionController.text));

                                  bool res =
                                      await authController.addProject(list);
                                  authController.loading.value = false;

                                  if (res) {
                                    authController.titleController.clear();
                                    authController.descriptionController
                                        .clear();
                                    authController.longDescController.clear();
                                    showCustomSnackBar(
                                        'Added Project to Database');
                                    return;
                                  }

                                  showCustomSnackBar('Unable to Login');

                                  return;
                                }
                                showCustomSnackBar('Please enter valid data!',
                                    snackType: SnackType.Warning);
                              },
                              child: Text('Add')),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
