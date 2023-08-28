import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/screens/login/components/auth_controller.dart';
import 'package:responsive_portfolio/screens/login/login_screen.dart';
import 'package:responsive_portfolio/screens/widgets/app_text_field.dart';
import 'package:responsive_portfolio/utils/main_controller.dart';

class AddProject extends StatefulWidget {
  static const routeName = '/add_project';

  AddProject({Key? key, this.projectModel}) : super(key: key);

  final ProjectModel? projectModel;

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.titleController.clear();
    authController.descriptionController.clear();
    authController.longDescController.clear();

    if (widget.projectModel != null) {
      authController.titleController.text = widget.projectModel!.title ?? '';
      authController.descriptionController.text =
          widget.projectModel!.description ?? '';
      authController.longDescController.text =
          widget.projectModel!.longDesc ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

                            ProjectModel p = ProjectModel(
                                      id: widget.projectModel != null
                                          ? widget.projectModel!.id
                                          : list.length,
                                      position: widget.projectModel != null
                                          ? widget.projectModel!.position
                                          : list.length,
                                      title:
                                          authController.titleController.text,
                                      longDesc: authController
                                          .longDescController.text,
                                      description: authController
                                          .descriptionController.text);

                            if (widget.projectModel != null) {
                                    for (int i = 0; i < list.length; i++) {
                                      if (list[i].id! ==
                                          widget.projectModel!.id) {
                                        list[i] = p;
                                        break;
                                      }
                                    }
                                  } else {
                                    list.add(p);
                                  }

                                  authController.loading.value = true;

                            bool res =
                            await main.addOrUpdateProject(list);
                            authController.loading.value = false;

                            if (res) {
                              authController.titleController.clear();
                              authController.descriptionController
                                  .clear();
                              authController.longDescController.clear();

                              if (widget.projectModel != null) {
                                      await Get.dialog(
                                          WillPopScope(
                                              child: AlertDialog(
                                                content: Text(
                                                    'Project Details Updated!'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text('Ok'))
                                          ],
                                        ),
                                        onWillPop: () {
                                          return Future.value(false);
                                        }),
                                    barrierDismissible: false);
                                Get.back();
                                return;
                              }

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
                              child: Text(widget.projectModel != null
                                  ? 'Update'
                                  : 'Add')),
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