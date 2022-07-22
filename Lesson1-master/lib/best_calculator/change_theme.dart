import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
const contanierGradient = LinearGradient(
  colors: [
    Color(0xffEC5C22),
    Color(0xffF0781A),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.3, 1],
);

Color backgroundColorCurrency = const Color(0xff161616);
Color backgroundColor2 = const Color(0xff262626);
Color menuText1 = const Color(0xffFF0000);
Color menuText2 = const Color(0xffFF0000);

Color appBarColor = const Color(0xff161616);
Color clearColor = const Color(0xffFF0000);
Color downChange = const Color(0xffFF0000);
Color textColor = const Color(0xffBBBBBB);
double widthGridViewCross = 1;
double heightGridViewMain = 1.04;
Color containerColor = const Color(0xff262626);
double leftGra = 0;
double rightGra = 0;
Color currencyButtonColor = const Color(0xff161616);
Color distanceColor1 = const Color(0xff262626);
Color distanceColor2 = const Color(0xff161616);
Color currencyColor = const Color(0xff262626);
Color valumePage = const Color(0xff161616);

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
BoxDecoration decorationMain1 = const BoxDecoration(
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
    case 1:
      backgroundColor2 = Color(0xffFD0D0D0);
      appBarColor = const Color(0xffAAAAAA);
      menuText1 = const Color(0xff333333);
      menuText2 = const Color(0xffFFFFFF);
      clearColor = const Color(0xffFFFFFF);

      downChange = const Color(0xff00E0FF);
      textColor = const Color(0xffFFFFFF);
      decoration = const BoxDecoration(
        color: Color(0xffF1EFED),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xffFFFFFF),
        )),
      );
      decorationMain = const BoxDecoration(
        gradient: contanierGradient,
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xffFAD3B5),
        )),
      );
      decorationMain1 = const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff303030),
            Color(0xff5A5A5A),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1],
        ),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xffFAD3B5),
        )),
      );
      containerColor = const Color(0xff333333);

      heightGridViewMain = 10;
      widthGridViewCross = 12;
      leftGra = 0;
      rightGra = 0;
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        color: Color(0xff303030),
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
      distanceColor1 = const Color(0xffD6D6D6);
      distanceColor2 = const Color(0xffB6B6B6);
      valumePage = const Color(0xffC7C7C7);
      break;
    case 2:
      backgroundColor2 = Color(0xffF3F3F3);
      appBarColor = const Color(0xffCDCDCD);
      menuText1 = const Color(0xff333333);
      menuText2 = const Color(0xff333333);
      downChange = const Color(0xffEAA425);
      textColor = const Color(0xff656565);
      clearColor = const Color(0xffFF0000);
      decoration = const BoxDecoration(
        color: Color(0xffF1EFED),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xffFFFFFF),
        )),
      );
      decorationMain = const BoxDecoration(
        color: Color(0xffDCDCDC),
        border: Border(
            top: BorderSide(
          width: 1.5,
          color: Color(0xffF4F4F4),
        )),
      );
      containerColor = const Color(0xffDCDCDC);
      decorationMain1 = decorationMain;

      heightGridViewMain = 1;
      widthGridViewCross = 1;
      leftGra = 0;
      rightGra = 0;
      //currency uchun Box decoration
      decorationCurVal = const BoxDecoration(
        color: Color(0xffDCDCDC),
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
      distanceColor1 = const Color(0xffDCDCDC);
      distanceColor2 = const Color(0xffC7C7C7);
      valumePage = const Color(0xffC7C7C7);
      break;
    case 4:
      backgroundColor2 = const Color(0xff454545);
      appBarColor = const Color(0xff262626);
      menuText1 = const Color(0xff00E0FF);
      menuText2 = const Color(0xff00E0FF);

      downChange = const Color(0xff02C4F4);
      textColor = const Color(0xffFFFFFF);
      clearColor = const Color(0xffFF0000);
      decorationMain = const BoxDecoration(
        color: Color(0xff262626),
      );
      decoration = const BoxDecoration(
        color: Color(0xff454545),
      );
      decorationMain1 = decorationMain;
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
      valumePage = const Color(0xff262626);
      break;
    case 5:
      // backgrount Colori
      backgroundColor2 = const Color(0xff111111);
      // appBar colori
      appBarColor = const Color(0xff191919);
      // asosiy Textlar va menuning asosiy rangi
      menuText1 = const Color(0xff02C4F4);
      menuText2 = const Color(0xff02C4F4);
      clearColor = const Color(0xff02C4F4);

      // pastga qaratilgan tugma rangi
      downChange = const Color(0xff02C4F4);
      // asosiy bo'lmagan textlar rangi
      textColor = const Color(0xff02C4F4);
      // asosiy bo'lmagan contanierning harflari va o'zing tuzilishi
      decoration = BoxDecoration(
        gradient: contanierBestCalGradient,
        color: const Color(0xff5A5A5A),
        border: Border.all(
          width: 1.5,
          color: const Color(0xff34728A),
        ),
      );
      //asosiy main contanier x, x kabi larni boxdecorationi
      decorationMain = BoxDecoration(
        gradient: contanierBestCalGradient,
        color: const Color(0xff5A5A5A),
        border: Border.all(
          width: 1.5,
          color: const Color(0xff34728A),
        ),
      );
      decorationMain1 = decorationMain;
      //asosiy menu container colori
      containerColor = const Color(0xff111111);
      // grid viewning oraliqlari
      heightGridViewMain = 5;
      widthGridViewCross = 5;

      leftGra = 8;
      rightGra = 8;
      //currency uchun Box decoration
      decorationCurVal = BoxDecoration(
        gradient: contanierBestCalGradient,
        border: Border.all(
          width: 1,
          color: const Color(0xff54617F),
        ),
      );
      // vo'lchov birliklarining ranglar listi uchun
      distanceColor1 = const Color(0xff002734);
      distanceColor2 = const Color(0xff024056);
      valumePage = const Color(0xff191919);
      break;
    case 6:
      leftGra = 0;
      rightGra = 0;
      widthGridViewCross = 1;
      heightGridViewMain = 1.04;
      backgroundColor2 = const Color(0xff22262F);
      appBarColor = const Color(0xff1F2229);
      menuText1 = const Color(0xffFCA300);
      menuText2 = const Color(0xffFCA300);
      downChange = const Color(0xff00E0FF);
      textColor = const Color(0xffBBBBBB);
      clearColor = const Color(0xffFF0000);
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
      decorationMain1 = decorationMain;
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
      valumePage = const Color(0xff1F2229);

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
      decorationMain1 = decorationMain;
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
      currencyColor = const Color(0xff262626);
      valumePage = const Color(0xff161616);
      menuText2 = const Color(0xffFF0000);
      break;
  }
}

//appBar text color uchun
Color appBarTextColor = const Color(0xffFF0000);
Color appBarbackgroundColor = const Color(0xff161616);
Color backgroundColor = const Color(0xff262626);
Color menuContanierColorCalHori = const Color(0xff161616);
Color menuContanierColorCalVer = const Color(0xff161616);
Color contanierColorCal = const Color(0xff262626);
Color tectColor = const Color(0xffFF0000);
Color menuTextColorCal = const Color(0xffFF0000);
Color buttomSheetColor = const Color(0xffFF0000);
Color buttomSheetHistoryColor = const Color(0xffFF0000);
Color historyButtonBorder = const Color(0xffBBBBBB);
Color historyButtonIconColor = const Color(0xffC3C3C3);
Color currencyContanierColor = const Color(0xff262626);
Color currencyBackgroundColor = const Color(0xff434343);
Color fromCurrencyColor = const Color(0xff00E0FF);
Color inCurrencyColor = const Color(0xffFF4D00);
Color currencyTextCcyColor = const Color(0xffFFFFFF);
Color menuCurrencyButtonColor = const Color(0xff161616);
Color menuCurrencyColor = const Color(0xffFF0000);
Color refreshCurrencyColor = const Color(0xffD4D4D4);
Color currencyTextColor = const Color(0xffFFFFFF);
Color valumeAppBarColor = const Color(0xff161616);
Color valumeContainer1Color = const Color(0xff161616);
Color valumeList1Color = const Color(0xff262626);
Color valumeListColor = const Color(0xff161616);
Color valumeButtomSheetColor = const Color(0xff262626);
Color valumeButtomSheetButtonColor = const Color(0xff161616);
Color valumeButtomSheetBottonManuColor = const Color(0xffFF0000);
Color valumeButtomSheetDownColor = const Color(0xffFF0000);

double menuButtonWidth = 1.04;
double menuButtonCross = 1;

const contaniergradient = LinearGradient(
  colors: [
    Color(0xffAAAAAA),
    Color(0xffD0D0D0),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.3, 1],
);

// Calculator page uchun
BoxDecoration decorationCalMenuVer = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(width: 1, color: Color(0xff484D58)),
  ),
);
BoxDecoration decorationCalMenuHori = const BoxDecoration(
  color: Color(0xff262626),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);
BoxDecoration decorationCal = const BoxDecoration(
  color: Color(0xff262626),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);

// Currency uchun
BoxDecoration decorationCurrancyButton = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
    right: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);

BoxDecoration decorationCurrancyButtonMenu = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
    right: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);

//Valume uchun
BoxDecoration decorationValumeButton = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
    right: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);

BoxDecoration decorationValumeButtonMenu = const BoxDecoration(
  color: Color(0xff161616),
  border: Border(
    top: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
    right: BorderSide(
      width: 1,
      color: Color(0xff484D58),
    ),
  ),
);

chekPageDizayn(int number) {
  switch (number) {
    case 1:
      {
        appBarbackgroundColor = const Color(0xffAAAAAA);
        appBarTextColor = const Color(0xff333333);
        backgroundColor = const Color(0xff262626);
        tectColor = const Color(0xffFF0000);
        contanierColorCal = const Color(0xffD0D0D0);

        decorationCalMenuHori = const BoxDecoration(
          gradient: contanierGradient,
          border: Border(
            top: BorderSide(
              width: 1.5,
              color: Color(0xffFAD3B5),
            ),
          ),
        );
      }
  }
}
