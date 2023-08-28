import 'package:flutter/material.dart';

import 'app_utils.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

snackErrors(BuildContext context, Object e,
    {String? msg, SnackBarAction? action, Duration? duration}) {
  AppUtils.showSnackBar(
      context: context,
      msg: msg ?? e.toString(),
      action: action,
      duration: duration);
}

printErrors(Object e, StackTrace s, String methodName) {
  debugPrint(methodName);
  debugPrint(e.toString());
  debugPrintStack(stackTrace: s);
}
