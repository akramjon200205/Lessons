import 'dart:math';

import 'package:flutter/material.dart';

class ShuffleBuildPage extends StatefulWidget {
  const ShuffleBuildPage({Key? key}) : super(key: key);

  @override
  State<ShuffleBuildPage> createState() => _ShuffleBuildPageState();
}

class _ShuffleBuildPageState extends State<ShuffleBuildPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<AlignmentGeometry> _anim1;
  late Animation<AlignmentGeometry> _anim2;
  late Animation<AlignmentGeometry> _anim3;
  Alignment ball = const Alignment(-0.8, -0.5);
  int ballPosition = 1;
  bool isShowBall = true;

  var left = const Alignment(-0.8, -0.5);
  var right = const Alignment(0.8, -0.5);
  var medium = const Alignment(0.0, -0.5);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _anim1 = Tween<AlignmentGeometry>(
      begin: const Alignment(-0.8, -0.5),
      end: const Alignment(-0.8, -0.5),
    ).animate(_controller);
    _anim2 = Tween<AlignmentGeometry>(
      begin: const Alignment(0, -0.5),
      end: const Alignment(0, -0.5),
    ).animate(_controller);
    _anim3 = Tween<AlignmentGeometry>(
      begin: const Alignment(0.8, -0.5),
      end: const Alignment(0.8, -0.5),
    ).animate(_controller);
    // ballChangePosition();
    buildAnim();
  }

  Future buildAnim() async {
    ballPosition = Random.secure().nextInt(3) + 1;
    await ballChangePosition();
    for (int i = 0; i < 3; i++) {
      cupChangePosition();
      await wait(1);
    }
  }

  Future ballChangePosition() async {
    ballPosition = Random.secure().nextInt(3) + 1;
    if (ballPosition == 1) {
      _anim1 = Tween<AlignmentGeometry>(
        begin: const Alignment(-0.8, -0.5),
        end: const Alignment(-0.8, -0.7),
      ).animate(_controller);
      await wait(1.5);
    } else if (ballPosition == 2) {
      _anim2 = Tween<AlignmentGeometry>(
        begin: const Alignment(0, -0.5),
        end: const Alignment(0, -0.7),
      ).animate(_controller);
      await wait(1.5);
    } else {
      _anim3 = Tween<AlignmentGeometry>(
        begin: const Alignment(0.8, -0.5),
        end: const Alignment(0.8, -0.7),
      ).animate(_controller);
      await wait(1.5);
    }
    _controller.forward().then((value) {
      _controller.reverse();
    });
    isShowBall = false;
    await wait(1);
  }

  cupChangePosition() {
    var newPosition = Random.secure().nextInt(3) + 1;
    while (newPosition == ballPosition) {
      newPosition = Random.secure().nextInt(3) + 1;
    }

    if (ballPosition == 1) {
      if (newPosition == 2) {
        _anim1 = Tween<AlignmentGeometry>(begin: left, end: right)
            .animate(_controller);
      } else {}
    } else if (ballPosition == 2) {
      if (newPosition == 1) {
      } else {}
    } else {
      if (newPosition == 1) {
      } else {}
    }
    setState(() {});
  }

  Future wait(double sec) =>
      Future.delayed(Duration(milliseconds: (sec * 1000).toInt()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shuffle Game'),
      ),
      body: Stack(
        children: [
          if (isShowBall)
            Align(
              alignment: ball,
              child: Image.asset(
                'assets/ball.png',
                height: 25,
                width: 80,
              ),
            ),
          AnimatedBuilder(
            animation: _anim1,
            builder: (context, child) {
              return AlignTransition(alignment: _anim1, child: child!);
            },
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.red,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _anim2,
            builder: (context, child) {
              return AlignTransition(alignment: _anim2, child: child!);
            },
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.blue,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _anim3,
            builder: (context, child) {
              return AlignTransition(alignment: _anim3, child: child!);
            },
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.green,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                ballChangePosition();
              },
              child: const Text("Start"),
            ),
          ),
        ],
      ),
    );
  }
}
