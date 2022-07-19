import 'package:flutter/material.dart';

import '../wallet_ui/price_model.dart';

const String currencyBox = 'currency_box';
const String weatherBox = 'weather_box';
const String weeklyBox = 'weekly_box';
const String currencyListKey = 'currency_list_key';
const String dateBox = 'date_box';
const String dateKey = 'date_key';

const scaffoldWeatherGradient =
    LinearGradient(colors: [Color(0xffFEF7FF), Color(0xffFCEBFF)]);
const textWeatherGradient = LinearGradient(
    colors: [Color(0xffFFFFFF), Color(0xffD2C4FF)],
    transform: GradientRotation(45));
const containerWeatherGradient = LinearGradient(
    colors: [Color(0xffE662E5), Color(0xff5364F0)],
    transform: GradientRotation(45));

TextStyle kTextStyle({
  Color? color,
  double size = 14,
  FontWeight fontWeight = FontWeight.w500,
  double? letterSpacing,
  double? height,
}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height);
}

ButtonStyle buttonStyle({
  Color? color,
  Color? shadowColor,
  double? elevation,
  EdgeInsets? padding,
  double? borderRadius,
  BorderSide? side,
  Size? size,
}) {
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shadowColor: MaterialStateProperty.all(shadowColor),
      elevation: MaterialStateProperty.all(elevation),
      padding: MaterialStateProperty.all(padding),
      minimumSize: MaterialStateProperty.all(size),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            side: side ?? BorderSide.none),
      ));
}

List<PriceModel> listPrices = [
  PriceModel(name: 'Groceries', date: '5:20 PM', price: 678),
  PriceModel(name: 'Shopping', date: '6:25 PM', price: 892),
  PriceModel(name: 'Parking', date: '8:25 PM', price: 200),
];

Map<String, String> wtypes = {
  "ochiq havo": "ic_sunny",
  "bulutli": "ic_mist",
  "yomg'ir": "ic_rain",
};

const Color color = Color(0xffBBBBBB);
const Color color1 = Color(0xffFF0000);

const bestCalculateGradient = LinearGradient(
    colors: [Color(0xffEC5C22), Color(0xffF0781A)],
    transform: GradientRotation(20));

// GridView.count(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 1,
//                 mainAxisSpacing: 1,
//                 primary: false,
//                 childAspectRatio: size.height * 0.0024,
//                 children: [
//                   _itemButtonCurrency(
//                     "7",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "8",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "9",
//                     const Color(0xffBBBBBB),
//                   ),
//                   scaleWidget(
//                     onTap: () {},
//                     scale: 0.8,
//                     child: Container(
//                       width: 94.89,
//                       height: 81,
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                         color: Color(0xff161616),
//                         border: Border(
//                           top: BorderSide(
//                             color: Color(0xff54617F),
//                             width: 1,
//                           ),
//                           right: BorderSide(
//                             color: Color(0xff54617F),
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                       child: const Icon(
//                         Icons.backspace_outlined,
//                         size: 25,
//                         color: Color(0xffFF0000),
//                       ),
//                     ),
//                   ),
//                   _itemButtonCurrency(
//                     "4",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "5",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "6",
//                     const Color(0xffBBBBBB),
//                   ),
//                   scaleWidget(
//                     onTap: () {},
//                     scale: 0.8,
//                     child: Container(
//                         width: 94.89,
//                         height: 81,
//                         alignment: Alignment.center,
//                         decoration: const BoxDecoration(
//                           color: Color(0xff161616),
//                           border: Border(
//                             top: BorderSide(
//                               color: Color(0xff54617F),
//                               width: 1,
//                             ),
//                             right: BorderSide(
//                               color: Color(0xff54617F),
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                         child: Image.asset(
//                           "assets/down_top.png",
//                           width: 25.19,
//                           height: 49.84,
//                         )),
//                   ),
//                   _itemButtonCurrency(
//                     "1",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "2",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "3",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "C",
//                     const Color(0xffFF0000),
//                   ),
//                   _itemButtonCurrency(
//                     ",",
//                     const Color(0xffBBBBBB),
//                   ),
//                   _itemButtonCurrency(
//                     "0",
//                     const Color(0xffBBBBBB),
//                   ),
//                   Expanded(
//                     child: scaleWidget(
//                       onTap: () {},
//                       scale: 0.8,
//                       child: Container(
//                         width: 188,
//                         height: 81,
//                         alignment: Alignment.center,
//                         decoration: const BoxDecoration(
//                           color: Color(0xff161616),
//                           border: Border(
//                             top: BorderSide(
//                               color: Color(0xff54617F),
//                               width: 1,
//                             ),
//                             right: BorderSide(
//                               color: Color(0xff54617F),
//                               width: 1,
//                             ),
//                           ),
//                         ),
//                         child: Text(
//                           "00",
//                           style: kTextStyle(
//                               size: 28,
//                               color: const Color(0xffBBBBBB),
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),