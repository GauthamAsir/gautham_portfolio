import 'package:flutter/material.dart';
import 'package:responsive_portfolio/screens/widgets/responsive.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label, hint;
  final bool obscureText;

  const AppTextField(
      {Key? key,
      required this.controller,
      this.label,
      this.hint,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Responsive(
      mobile: _textField(),
      tablet: _tablet(size),
      desktop: _desktop(size),
      mobileLarge: _tablet(size),
    );
  }

  Widget _tablet(Size size) {
    return SizedBox(
      width: size.width / 2,
      child: _textField(),
    );
  }

  Widget _desktop(Size size) {
    return SizedBox(
      width: size.width / 3,
      child: _textField(),
    );
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            isDense: false,
            labelText: label,
            hintText: hint,
            border: OutlineInputBorder()),
      ),
    );
  }
}
