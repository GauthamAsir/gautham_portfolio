import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_portfolio/global.dart';
import 'package:responsive_portfolio/screens/login/components/auth_controller.dart';
import 'package:responsive_portfolio/screens/widgets/app_text_field.dart';
import 'package:responsive_portfolio/screens/widgets/responsive.dart';

class AdminLoginScreen extends StatelessWidget {
  static const routeName = '/0412';

  AdminLoginScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: authController.loading.value
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          // shrinkWrap: true,
                          // physics: BouncingScrollPhysics(),
                          // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          children: [
                            AppTextField(
                                controller: authController.emailController,
                                label: 'Email'),
                            const SizedBox(
                              height: 20,
                            ),
                            AppTextField(
                                obscureText: !authController.obscure.value,
                                controller: authController.passwordController,
                                label: 'Password'),
                            const SizedBox(
                              height: 10,
                            ),
                            Responsive(
                                mobile: _passwordCheckBox(),
                                desktop: SizedBox(
                                  width: size.width /
                                      (Responsive.isDesktop(context) ? 3 : 2),
                                  child: _passwordCheckBox(),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (authController
                                      .emailController.text.isEmail) {
                                    if (authController
                                            .passwordController.text.length <
                                        6) {
                                      showCustomSnackBar(
                                          'Password length should be greater than 6',
                                          snackType: SnackType.Warning);
                                      return;
                                    }

                                    authController.loginUser();

                                    return;
                                  }
                                  showCustomSnackBar(
                                      'Please enter valid email!',
                                      snackType: SnackType.Warning);
                                },
                                child: Text('Login'))
                          ],
                        ),
                      ),
                    ),
            )),
      ),
    );
  }

  Widget _passwordCheckBox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: authController.obscure.value,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      onChanged: (value) {
        if (value != null) {
          authController.obscure.value = value;
        }
      },
      dense: true,
      title: Text('Show Password'),
    );
  }
}
