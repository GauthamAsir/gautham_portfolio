import 'package:flutter/material.dart';
import 'package:gautham_portfolio/core/base_widgets/base_text.dart';

class TextRevealAnimWidget extends StatefulWidget {
  final String displayText;

  final bool animate;

  const TextRevealAnimWidget(
      {super.key, required this.displayText, this.animate = true});

  @override
  State createState() => _TextRevealAnimWidgetState();
}

class _TextRevealAnimWidgetState extends State<TextRevealAnimWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _revealAnimation;

  late int animDirectionValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _revealAnimation = Tween<double>(
      begin: 0, // Fully clipped
      end: 1, // Fully revealed
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
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
    return Center(
        child: widget.animate
            ? AnimatedBuilder(
                animation: _revealAnimation,
                builder: (BuildContext context, Widget? child) {
                  return ClipRect(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        heightFactor: _revealAnimation.value,
                        child: _text()),
                  );
                },
              )
            : _text());
  }

  Widget _text() {
    return Align(
      alignment: Alignment.centerLeft,
      child: BaseText(
        widget.displayText,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
