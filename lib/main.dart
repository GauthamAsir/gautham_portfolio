import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/base_app_loading.dart';
import 'package:gautham_portfolio/misc/globals.dart';
import 'package:gautham_portfolio/screens/main/main_screen.dart';

import 'core/base_router/app_router.dart';
import 'core/base_theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final Future<FirebaseApp> _initFirebase = Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyACOdfeLGCWCf0eTJkyKaXPE9FSyGR3Y1c",
          authDomain: "gautham-portfolio.firebaseapp.com",
          projectId: "gautham-portfolio",
          storageBucket: "gautham-portfolio.appspot.com",
          messagingSenderId: "814428664501",
          appId: "1:814428664501:web:48df51b0c8a4016701c4fc",
          measurementId: "G-F8L2VZSH7K"));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gautham Portfolio',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        // initialRoute: AppRouter.initialRouteName,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => AppRouter.getWidget(routeSettings));
        },
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: _initFirebase,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return snackErrors(context, (snapshot.error ?? '').toString());
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return const MainScreen();
              }
              return const BaseAppLoading();
            }));
  }
}
