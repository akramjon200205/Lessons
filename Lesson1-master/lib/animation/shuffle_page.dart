import 'dart:math';

import 'package:flutter/material.dart';

class ShufflePage extends StatefulWidget {
  const ShufflePage({Key? key}) : super(key: key);

  @override
  State<ShufflePage> createState() => _ShufflePageState();
}

class _ShufflePageState extends State<ShufflePage> {
  Alignment cup1 = const Alignment(-0.8, -0.5);
  Alignment cup2 = const Alignment(0, -0.5);
  Alignment cup3 = const Alignment(0.8, -0.5);
  Alignment ball = const Alignment(-0.7, -0.4);
  int ballPosition = 1;
  bool isShowBall = true;

  @override
  void initState() {
    super.initState();
    buildAnim();
  }

  Future buildAnim() async {
    ballPosition = Random.secure().nextInt(3) + 1;
    await ballChangePostion();
    for (int i = 0; i < 3; i++) {
      cupChangePostion();
      await wait(1);
    }
  }

  cupChangePostion() {
    var newPosition = Random.secure().nextInt(3) + 1;
    while (newPosition == ballPosition) {
      newPosition = Random.secure().nextInt(3) + 1;
    }
    Alignment cupTemp;
    if (ballPosition == 1) {
      if (newPosition == 2) {
        cupTemp = cup1;
        cup1 = cup2;
        cup2 = cupTemp;
        ball = Alignment(cup1.x, -0.4);
      } else {
        cupTemp = cup1;
        cup1 = cup3;
        cup3 = cupTemp;
        ball = Alignment(cup1.x, -0.4);
      }
    } else if (ballPosition == 2) {
      if (newPosition == 1) {
        cupTemp = cup2;
        cup2 = cup1;
        cup1 = cupTemp;
        ball = Alignment(cup2.x, -0.4);
      } else {
        cupTemp = cup2;
        cup2 = cup3;
        cup3 = cupTemp;
        ball = Alignment(cup2.x, -0.4);
      }
    } else {
      if (newPosition == 1) {
        cupTemp = cup3;
        cup3 = cup1;
        cup1 = cupTemp;
        ball = Alignment(cup3.x, -0.4);
      } else {
        cupTemp = cup3;
        cup3 = cup2;
        cup2 = cupTemp;
        ball = Alignment(cup3.x, -0.4);
      }
    }
    setState(() {});
  }

  Future ballChangePostion() async {
    if (ballPosition == 1) {
      ball = const Alignment(-0.8, -0.4);
      cup1 = const Alignment(-0.8, -0.7);
      setState(() {});
      await wait(1.5);
      cup1 = const Alignment(-0.8, -0.5);
      setState(() {});
    } else if (ballPosition == 2) {
      ball = const Alignment(0, -0.4);
      cup2 = const Alignment(0, -0.7);
      setState(() {});
      await wait(1.5);
      cup2 = const Alignment(0, -0.5);
      setState(() {});
    } else {
      ball = const Alignment(0.8, -0.4);
      cup3 = const Alignment(0.8, -0.7);
      setState(() {});
      await wait(1.5);
      cup3 = const Alignment(0.8, -0.5);
      setState(() {});
    }
    await wait(1);
    isShowBall = false;
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
          AnimatedAlign(
            alignment: cup1,
            duration: const Duration(milliseconds: 1000),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowBall = true;
                  cup1 = Alignment(cup1.x, -0.7);
                });
              },
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.red,
              ),
            ),
          ),
          AnimatedAlign(
            alignment: cup2,
            duration: const Duration(milliseconds: 1000),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowBall = true;
                  cup2 = Alignment(cup2.x, -0.7);
                });
              },
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.green,
              ),
            ),
          ),
          AnimatedAlign(
            alignment: cup3,
            duration: const Duration(milliseconds: 1000),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowBall = true;
                  cup3 = Alignment(cup3.x, -0.7);
                });
              },
              child: Image.asset(
                'assets/cup.png',
                width: 80,
                color: Colors.blue,
              ),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  ballChangePostion();
                },
                child: const Text('Start')),
          )
        ],
      ),
    );
  }
}
