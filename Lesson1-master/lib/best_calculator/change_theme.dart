import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';

const listColors = [Color(0xffFFFFFF)];
const contanierBestCalGradient = LinearGradient(
  colors: [
    Color(0xff01232F),
    Color(0xff111111),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.3, 1],
);
const linerBorGra = LinearGradient(
  colors: [Color(0xff34748C), Color(0xff111111)],
  transform: GradientRotation(45),
);

Color backgroundColor = const Color(0xff161616);
Color backgroundColor2 = const Color(0xff262626);
Color menuText1 = const Color(0xffFF0000);
Color appBarColor = const Color(0xff161616);
Color clearColor = const Color(0xffFF0000);
Color downChange = const Color(0xffFF0000);
Color textColor = const Color(0xffBBBBBB);
double widthGridViewCross = 1;
double heightGridViewMain = 1.04;
double widths = 102;
double heights = 78.17;
Color containerColor = const Color(0xff262626);
double leftGra = 0;
double rightGra = 0;
Color currencyButtonColor = const Color(0xff161616);
Color distanceColor1 = const Color(0xff262626);
Color distanceColor2 = const Color(0xff161616);

BoxDecoration decorationCurVal = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff54617F),
    ),
    right: BorderSide(
      width: 1,
      color: Color(0xff54617F),
    ),
  ),
);

BoxDecoration decoration = const BoxDecoration(
  color: Color(0xff262626),
  border: Border(
    top: BorderSide(
      color: Color(0xff5A5A5A),
      width: 1.5,
    ),
  ),
);
BoxDecoration decorationMain = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      color: Color(0xff5A5A5A),
      width: 1.5,
    ),
  ),
);

changeTheme(int choosen) {
  switch (choosen) {
    case 4:
      backgroundColor2 = const Color(0xff454545);
      appBarColor = const Color(0xff262626);
      menuText1 = const Color(0xff00E0FF);
      downChange = const Color(0xff02C4F4);
      textColor = const Color(0xffFFFFFF);
      decorationMain = const BoxDecoration(
        color: Color(0xff262626),
      );
      decoration = const BoxDecoration(
        color: Color(0xff454545),
      );
      containerColor = const Color(0xff000000);
      widthGridViewCross = 3;
      heightGridViewMain = 3;
      leftGra = 0;
      rightGra = 0;
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        color: Color(0xff161616),
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Color(0xff363636),
          ),
          right: BorderSide(
            width: 0.5,
            color: Color(0xff363636),
          ),
        ),
      );
      distanceColor1 = const Color(0xff454545);
      distanceColor2 = const Color(0xff555454);
      break;
    case 5:
      backgroundColor2 = const Color(0xff111111);
      appBarColor = const Color(0xff191919);
      menuText1 = const Color(0xff02C4F4);
      downChange = const Color(0xff02C4F4);
      textColor = const Color(0xff02C4F4);
      decoration = const BoxDecoration(
        gradient: contanierBestCalGradient,
        color: Color(0xff5A5A5A),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xff34728A),
        )),
      );
      decorationMain = const BoxDecoration(
        gradient: contanierBestCalGradient,
        color: Color(0xff5A5A5A),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xff34728A),
        )),
      );
      containerColor = const Color(0xff111111);

      heightGridViewMain = 5;
      widthGridViewCross = 5;
      leftGra = 8;
      rightGra = 8;
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        gradient: contanierBestCalGradient,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
          right: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
        ),
      );
      distanceColor1 = const Color(0xff002734);
      distanceColor2 = const Color(0xff024056);
      break;
    case 6:
      leftGra = 0;
      rightGra = 0;
      widthGridViewCross = 1;
      heightGridViewMain = 1.04;
      backgroundColor2 = const Color(0xff22262F);
      appBarColor = const Color(0xff1F2229);
      menuText1 = const Color(0xffFCA300);
      downChange = const Color(0xff00E0FF);
      textColor = const Color(0xffBBBBBB);
      decoration = const BoxDecoration(
        color: Color(0xff32363F),
        border: Border(
          top: BorderSide(color: Color(0xff5A5A5A), width: 1.5),
        ),
      );
      decorationMain = const BoxDecoration(
        color: Color(0xff1F2229),
        border: Border(
          top: BorderSide(color: Color(0xff5A5A5A), width: 1.5),
        ),
      );
      containerColor = const Color(0xff22262F);
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        color: Color(0xff161616),
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
          right: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
        ),
      );
      distanceColor1 = const Color(0xff32363F);
      distanceColor2 = const Color(0xff494F5C);
      break;

    case 8:
      widthGridViewCross = 1;
      heightGridViewMain = 1.04;
      leftGra = 0;
      rightGra = 0;
      backgroundColor2 = const Color(0xff262626);
      appBarColor = const Color(0xff161616);
      menuText1 = const Color(0xffFF0000);
      downChange = const Color(0xffFF0000);
      textColor = const Color(0xffBBBBBB);

      decoration = const BoxDecoration(
        color: Color(0xff262626),
        border: Border(
          top: BorderSide(
            color: Color(0xff5A5A5A),
            width: 1,
          ),
        ),
      );
      decorationMain = const BoxDecoration(
        color: Color(0xff161616),
        border: Border(
          top: BorderSide(
            color: Color(0xff5A5A5A),
            width: 1,
          ),
        ),
      );
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        color: Color(0xff161616),
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
          right: BorderSide(
            width: 1,
            color: Color(0xff54617F),
          ),
        ),
      );
      containerColor = const Color(0xff262626);
      distanceColor1 = const Color(0xff262626);
      distanceColor2 = const Color(0xff161616);
      break;
  }
}
