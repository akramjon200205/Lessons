import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, Routes.shufflePage),
              child: Text(
                'Shuffle Page',
                style: kTextStyle(color: Colors.black87),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, Routes.simpleAnimPage),
              child: Text(
                'Animation Page',
                style: kTextStyle(color: Colors.black87),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, Routes.examplePage),
              child: Text(
                'Example Page',
                style: kTextStyle(color: Colors.black87),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, Routes.weatherPage),
              child: Text(
                'Weather App',
                style: kTextStyle(color: Colors.black87),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () => Navigator.pushNamed(context, Routes.comparePage),
              child: Text(
                'Currency App',
                style: kTextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'dart:math';

// import 'package:flutter/material.dart';

// class ShufflePage extends StatefulWidget {
//   const ShufflePage({Key? key}) : super(key: key);

//   @override
//   State<ShufflePage> createState() => _ShufflePageState();
// }

// class _ShufflePageState extends State<ShufflePage> {
//   Alignment cup1 = const Alignment(-0.8, -0.5);
//   Alignment cup2 = const Alignment(0, -0.5);
//   Alignment cup3 = const Alignment(0.8, -0.5);
//   Alignment ball = const Alignment(-0.8, -0.4);
//   int ballPosition = 1;
//   bool isShowBall = true;

//   @override
//   void initState() {
//     super.initState();
//     buildAnim();
//   }

//   Future buildAnim() async {
//     ballPosition = Random.secure().nextInt(3) + 1;
//     await ballChangePostion(
//         ballPosition == 1
//             ? cup1.x
//             : ballPosition == 2
//                 ? cup2.x
//                 : cup3.x, (value) {
//       if (ballPosition == 1) {
//         cup1 = value;
//       } else if (ballPosition == 2) {
//         cup2 = value;
//       } else {
//         cup3 = value;
//       }
//     });
//     for (int i = 0; i < 3; i++) {
//       cupChangePostion();
//       await wait(1);
//     }
//   }

//   cupChangePostion() {
//     var newPosition = Random.secure().nextInt(3) + 1;
//     while (newPosition == ballPosition) {
//       newPosition = Random.secure().nextInt(3) + 1;
//     }
//     var sum = '$ballPosition$newPosition';
//     Alignment cupTemp;
//     if (sum == '12') {
//       cupTemp = cup1;
//       cup1 = cup2;
//       cup2 = cupTemp;
//       ball = cup1;
//     } else if (sum == '21') {
//       cupTemp = cup2;
//       cup2 = cup1;
//       cup1 = cupTemp;
//       ball = cup2;
//     } else if (sum == '13') {
//       cupTemp = cup1;
//       cup1 = cup3;
//       cup3 = cupTemp;
//       ball = cup1;
//     } else if (sum == '31') {
//       cupTemp = cup3;
//       cup3 = cup1;
//       cup1 = cupTemp;
//       ball = cup3;
//     } else if (sum == '23') {
//       cupTemp = cup2;
//       cup2 = cup3;
//       cup3 = cupTemp;
//       ball = cup2;
//     } else if (sum == '32') {
//       cupTemp = cup3;
//       cup3 = cup2;
//       cup2 = cupTemp;
//       ball = cup3;
//     }
//     setState(() {
//       ballPosition = newPosition;
//     });
//   }

//   Future ballChangePostion(double pos, Function callBack) async {
//     if (pos == ball.x) {
//       ball = Alignment(pos, -0.5);
//       isShowBall = true;
//     }
//     callBack(Alignment(pos, -0.7));
//     setState(() {});
//     await wait(1.5);
//     callBack(Alignment(pos, -0.5));
//     setState(() {});
//     await wait(1);
//     isShowBall = false;
//   }

//   Future wait(double sec) => Future.delayed(Duration(milliseconds: (sec * 1000).toInt()));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shuffle Game'),
//       ),
//       body: Stack(
//         children: [
//           if (isShowBall)
//             Align(
//               alignment: ball,
//               child: Image.asset(
//                 'assets/ball.png',
//                 height: 25,
//                 width: 80,
//               ),
//             ),
//           AnimatedAlign(
//             alignment: cup1,
//             duration: const Duration(milliseconds: 1000),
//             child: GestureDetector(
//               onTap: () {
//                 ballChangePostion(cup1.x, (value) {
//                   cup1 = value;
//                 });
//               },
//               child: Image.asset(
//                 'assets/cup.png',
//                 width: 80,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           AnimatedAlign(
//             alignment: cup2,
//             duration: const Duration(milliseconds: 1000),
//             child: GestureDetector(
//               onTap: () {
//                 ballChangePostion(cup2.x, (value) {
//                   cup2 = value;
//                 });
//               },
//               child: Image.asset(
//                 'assets/cup.png',
//                 width: 80,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//           AnimatedAlign(
//             alignment: cup3,
//             duration: const Duration(milliseconds: 1000),
//             child: GestureDetector(
//               onTap: () {
//                 ballChangePostion(cup3.x, (value) {
//                   cup3 = value;
//                 });
//               },
//               child: Image.asset(
//                 'assets/cup.png',
//                 width: 80,
//                 color: Colors.green,
//               ),
//             ),
//           ),
//           Center(
//             child: TextButton(onPressed: () {}, child: Text('Start')),
//           )
//         ],
//       ),
//     );
//   }
// }

