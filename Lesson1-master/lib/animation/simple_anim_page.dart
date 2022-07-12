import 'package:flutter/material.dart';
import 'dart:math' as math;

class SimpleAnimPage extends StatefulWidget {
  const SimpleAnimPage({Key? key}) : super(key: key);

  @override
  State<SimpleAnimPage> createState() => _SimpleAnimPageState();
}

class _SimpleAnimPageState extends State<SimpleAnimPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animRotate;
  late Animation<double> animScale;
  late Animation<double> animMove;
  late Animation<double> animOpacity;
  late Animation<Alignment> animAlign;
  late Animation animBorderRadius;
  late Animation animColor;
  late Animation animBorder;
  double height = 200;
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    final curveAnim =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn, reverseCurve: Curves.elasticOut);
    animScale = Tween<double>(begin: 0, end: 1).animate(curveAnim);
    animMove = Tween<double>(begin: 0, end: 100).animate(animationController);
    animOpacity = Tween<double>(begin: 0, end: 1).animate(animationController);
    animBorderRadius =
        BorderRadiusTween(begin: BorderRadius.circular(4), end: BorderRadius.circular(50)).animate(animationController);
    animAlign = AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomCenter)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    animColor = ColorTween(begin: Colors.green, end: Colors.blue).animate(animationController);
    animBorder =
        BorderTween(begin: Border.all(color: Colors.red, width: 2), end: Border.all(color: Colors.grey, width: 15))
            .animate(animationController);
    animRotate = Tween<double>(begin: 0, end: 2 * math.pi).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: () => setState(() => isVisible = !isVisible), child: Text('Sized')),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: isVisible
                  ? Container(
                      key: Key("loading"),
                      height: height,
                      width: 200,
                      decoration: BoxDecoration(borderRadius: animBorderRadius.value, color: Colors.red),
                    )
                  : Container(
                      key: Key("normal"),
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimContainer extends AnimatedWidget {
  AnimContainer({required super.listenable, required this.animBorderRadius});

  Animation animBorderRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animBorderRadius,
      builder: (context, child) {
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(borderRadius: animBorderRadius.value, color: Colors.red),
        );
      },
    );
  }
}
