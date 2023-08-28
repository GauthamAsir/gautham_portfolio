import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseScaffold extends ConsumerWidget {
  final Widget body;
  final Widget? bottom;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? actionMenu;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool safeAreaTop;
  final bool changeStatusBarColor;

  const BaseScaffold(
      {super.key,
      required this.body,
      this.bottom,
      this.resizeToAvoidBottomInset,
      this.actionMenu,
      this.backgroundColor,
      this.appBar,
      this.drawer,
      this.scaffoldKey,
      this.floatingActionButton,
      this.floatingActionButtonAnimator,
      this.floatingActionButtonLocation,
      this.safeAreaTop = true,
      this.changeStatusBarColor = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      debugPrint("base scaffold");
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        endDrawerEnableOpenDragGesture: false,
        bottomSheet: bottom,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: SafeArea(top: safeAreaTop, child: body),
        appBar: appBar);
  }
}
