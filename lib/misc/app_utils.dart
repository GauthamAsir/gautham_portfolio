import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_theme/colors.dart';
import 'package:gautham_portfolio/core/base_widgets/base_text.dart';

class AppUtils {
  AppUtils._();

  static void showCustomBottomSheet(
      {required BuildContext context,
      required Widget child,
      bool enableDrag = true,
      bool isScrollControlled = false,
      bool isDismissible = true}) {
    showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: child,
            ));
  }

  static Future showSnackBar(
      {required BuildContext context,
      String? msg,
      Duration? duration,
      SnackBarAction? action}) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    return await ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).snackBarTheme.backgroundColor ??
              CustomColors.greyButtonColor,
          duration: duration ?? const Duration(seconds: 3),
          content: BaseText(
            msg ?? 'Something went wrong',
            style: TextStyle(
                color: (Theme.of(context).snackBarTheme.backgroundColor ??
                                CustomColors.secondaryColor)
                            .computeLuminance() <
                        0.5
                    ? CustomColors.whiteColor
                    : CustomColors.secondaryColor),
          ),
          behavior: SnackBarBehavior.floating,
          action: action,
        ))
        .closed;
  }
}
