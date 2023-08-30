import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_theme/colors.dart';
import 'package:gautham_portfolio/widgets/text_reveal_animated_widget.dart';

class InitialWidget extends StatefulWidget {
  final bool animate;

  const InitialWidget({super.key, this.animate = true});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                widget.animate ? MediaQuery.of(context).size.width * .3 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRevealAnimWidget(
                displayText: 'Hello, I am Gautham', animate: widget.animate),
            TextRevealAnimWidget(
                displayText: 'Mobile Application Developer (Flutter)',
                animate: widget.animate),
            const SizedBox(
              height: 10,
            ),
            ProgressAnimWidget(animate: widget.animate),
          ],
        ),
      ),
    );
  }
}

class ProgressAnimWidget extends StatefulWidget {
  final bool animate;

  const ProgressAnimWidget({super.key, this.animate = true});

  @override
  State createState() => _ProgressAnimWidgetState();
}

class _ProgressAnimWidgetState extends State<ProgressAnimWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  final double _targetWidth = 200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: _targetWidth,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));

    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.forward();
      });
    }

    // _controller.addListener(() {
    //   if (_controller.isCompleted) {
    //     Future.delayed(const Duration(seconds: 1), () {
    //       _controller.reset();
    //       _controller.forward();
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: widget.animate
            ? AnimatedBuilder(
                builder: (context, child) => _item(),
                animation: _controller,
              )
            : _item());
  }

  Widget _item() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 2,
      width: widget.animate ? _widthAnimation.value : _targetWidth,
      decoration: BoxDecoration(
          color: CustomColors.accentColor,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
    );
  }
}
