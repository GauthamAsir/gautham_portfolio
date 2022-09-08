import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_portfolio/constants.dart';
import 'package:responsive_portfolio/screens/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCwh6mQH0E97oUoT3SLlsane1YvIs42q_E",
          authDomain: "fly-ads.firebaseapp.com",
          projectId: "fly-ads",
          storageBucket: "fly-ads.appspot.com",
          messagingSenderId: "6428699133",
          appId: "1:6428699133:web:0c6d15e49eabf82dd1d194",
          measurementId: "G-XJXEWCF1E1"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: HomeScreen(),
    );
  }
}
