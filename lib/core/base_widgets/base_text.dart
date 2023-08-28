import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final int? maxLines;

  const BaseText(this.text,
      {super.key,
      this.style,
      this.overflow,
      this.textAlign,
      this.onTap,
      this.margin,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Text(
            text,
            maxLines: maxLines,
            style: style,
            overflow: overflow,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
