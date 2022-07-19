import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const listColors = [Color(0xffFFFFFF)];
const contanierBestCalGradient = LinearGradient(colors: [
  Color(0xff35748D),
  Color(0xff111111),
], transform: GradientRotation(70));
const conasc = LinearGradient(
  colors: listColors,
  transform: GradientRotation(45),
);

Color backgroundColor = const Color(0xff161616);
Color backgroundColor2 = const Color(0xff262626);
Color menuText1 = const Color(0xffFF0000);
Color calculateText2 = const Color(0xffBBBBBB);
Color claculateText2 = const Color(0xffDADADA);
Color borderColor = const Color(0xff5A5A5A);
double borderwidth = 1;
Color containerColor = const Color(0xff262626);
Color containerColor2 = const Color(0xff161616);
Color appBarColor = const Color(0xff161616);
Color clearColor = const Color(0xffFF0000);
Color downChange = const Color(0xffFF0000);
Color textColor = const Color(0xffBBBBBB);
double widthGridViewCross = 1;
double widthGridViewMain = 1.04;

// BoxDecoration decoration = BoxDecoration(
//   border:
// );

changeTheme(int choosen) {
  switch (choosen) {
    case 4:
      backgroundColor2 = const Color(0xff454545);
      appBarColor = const Color(0xff262626);
      menuText1 = const Color(0xff00E0FF);
      downChange = const Color(0xff02C4F4);
      textColor = const Color(0xffFFFFFF);
      containerColor = const Color(0xff454545);
      break;
    case 5:
      backgroundColor2 = const Color(0xff111111);
      appBarColor = const Color(0xff191919);
      menuText1 = const Color(0xff02C4F4);
      downChange = const Color(0xff02C4F4);
      textColor = const Color(0xff02C4F4);
      containerColor = const Color(0xff454545);
      break;
    case 6:
      backgroundColor2 = const Color(0xff22262F);
      appBarColor = const Color(0xff1F2229);
      menuText1 = const Color(0xffFCA300);
      downChange = const Color(0xff00E0FF);
      textColor = const Color(0xffBBBBBB);
      containerColor = const Color(0xff32363F);
      break;

    case 8:
      backgroundColor2 = const Color(0xff262626);
      appBarColor = const Color(0xff161616);
      menuText1 = const Color(0xffFF0000);
      downChange = const Color(0xffFF0000);
      textColor = const Color(0xffBBBBBB);
      containerColor = const Color(0xff262626);
      break;
  }
}
