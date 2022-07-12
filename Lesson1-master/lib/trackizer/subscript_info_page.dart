import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/line_dash.dart';
import 'package:lesson1/widgets/ticket_clipper.dart';

import '../widgets/border_buttom.dart';

class SubscriptInfoPage extends StatelessWidget {
  const SubscriptInfoPage({Key? key}) : super(key: key);

  final Color textColor1 = const Color(0xffA2A2B5);
  final LinearGradient _gradient = const LinearGradient(
      colors: [Colors.white24, Colors.transparent],
      transform: GradientRotation(45));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0E12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: ClipPath(
            clipper: TicketClipper(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xff353542),
                  borderRadius: BorderRadius.circular(24)),
              child: LayoutBuilder(
                builder: ((context, constraints) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      splashRadius: 20,
                                      icon: Image.asset(
                                        'assets/ic_arrow_down.png',
                                        height: 24,
                                        width: 24,
                                      )),
                                  Text(
                                    'Subscription info',
                                    style:
                                        kTextStyle(color: textColor1, size: 16),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/ic_trash.png',
                                        height: 24,
                                        width: 24,
                                      )),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: Image.asset(
                                  'assets/spotify_logo.png',
                                  height: 106,
                                  width: 106,
                                ),
                              ),
                              Text(
                                'Spotify',
                                style: kTextStyle(
                                    size: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$5.99',
                                style: kTextStyle(
                                    size: 20,
                                    color: textColor1,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: constraints.maxHeight / 2.2),
                          child: Column(
                            children: [
                              const LineDash(
                                color: Color(0xff0E0E12),
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                child: UnicornOutlineButton(
                                  gradient: _gradient,
                                  strokeWidth: 1,
                                  radius: 16,
                                  onPressed: () {},
                                  bgColor: const Color(0xff30303d),
                                  child: Column(
                                    children: [],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
