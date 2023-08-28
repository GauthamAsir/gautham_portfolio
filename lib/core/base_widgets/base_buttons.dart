import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_theme/colors.dart';
import 'package:gautham_portfolio/core/base_theme/test_styles.dart';

import 'base_text.dart';

class BaseButtonStyles {
  BaseButtonStyles._();
}

class BasePrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsets? margin;
  final Color? bgColor;
  final TextStyle? textStyle;
  final double? fontSize;

  const BasePrimaryButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.width,
      this.margin,
      this.bgColor,
      this.textStyle,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        overlayColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
        child: Ink(
          decoration: ShapeDecoration(
            color: bgColor ?? CustomColors.secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: 50,
            margin: margin,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                // color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseText(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                        color: bgColor != null
                            ? (bgColor!.computeLuminance() > .5
                                ? CustomColors.secondaryColor.withOpacity(.6)
                                : CustomColors.buttonText)
                            : CustomColors.buttonText,
                        fontSize: fontSize ?? 14,
                        fontFamily: AppTextStyles.defaultFontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BaseBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsets? margin;
  final Widget? icon;
  final double? radius;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? fontSize;

  const BaseBorderButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.width,
      this.margin,
      this.icon,
      this.radius,
      this.textStyle,
      this.borderColor,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        overlayColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
        child: Ink(
          decoration: ShapeDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color:
                        borderColor ?? Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(radius ?? 6)),
          ),
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: 50,
            margin: margin,
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                      width: 20, height: 20, child: icon ?? const SizedBox()),
                ),
                Center(
                  child: BaseText(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: fontSize ?? 12,
                          fontFamily: AppTextStyles.defaultFontFamily,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BaseGreyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width, height;
  final EdgeInsets? margin;
  final bool suffixIcon;
  final Widget? icon;

  const BaseGreyButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.width,
      this.margin,
      this.height,
      this.suffixIcon = true,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        // height: height ?? 35,
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
        decoration: ShapeDecoration(
          color: CustomColors.greyButtonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? (suffixIcon ? const SizedBox() : icon!)
                : const SizedBox(),
            icon != null
                ? (suffixIcon
                    ? const SizedBox()
                    : const SizedBox(
                        width: 10,
                      ))
                : const SizedBox(),
            BaseText(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            icon != null
                ? (suffixIcon ? const Spacer() : const SizedBox())
                : const SizedBox(),
            icon != null
                ? (!suffixIcon ? const SizedBox() : icon!)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
