import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_portfolio/models/full_data_model.dart';
import 'package:responsive_portfolio/screens/add_project/add_project.dart';
import 'package:responsive_portfolio/screens/home/home.dart';
import 'package:responsive_portfolio/screens/login/login_screen.dart';
import 'package:responsive_portfolio/screens/widgets/error_screen.dart';

import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyACOdfeLGCWCf0eTJkyKaXPE9FSyGR3Y1c",
          authDomain: "gautham-portfolio.firebaseapp.com",
          projectId: "gautham-portfolio",
          storageBucket: "gautham-portfolio.appspot.com",
          messagingSenderId: "814428664501",
          appId: "1:814428664501:web:48df51b0c8a4016701c4fc",
          measurementId: "G-F8L2VZSH7K"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SkillsModel skillsModel = SkillsModel();

    return GetMaterialApp(
      title: 'Gautham Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        canvasColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .copyWith(
              bodyText1: TextStyle(color: bodyTextColor),
              bodyText2: TextStyle(color: bodyTextColor),
            ),
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        final Map<String, dynamic> args;

        if (routeSettings.arguments != null) {
          args = routeSettings.arguments as Map<String, dynamic>;
        } else {
          args = {};
        }

        return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case HomeScreen.routeName:
                  return HomeScreen();
                case AdminLoginScreen.routeName:
                  return AdminLoginScreen();
                case AddProject.routeName:
                  return AddProject();
                default:
                  return ErrorScreen();
              }
            });
      },
      home: FutureBuilder(
          future: _initFirebase,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return messageWidget(context,
                  msg: (snapshot.error ?? '').toString());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return const HomeScreen();
            }
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
    );
  }
}
