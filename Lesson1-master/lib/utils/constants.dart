import 'package:flutter/material.dart';

import '../wallet_ui/price_model.dart';

const String currencyBox = 'currency_box';
const String weatherBox = 'weather_box';
const String weeklyBox = 'weekly_box';
const String currencyListKey = 'currency_list_key';
const String dateBox = 'date_box';
const String dateKey = 'date_key';

const scaffoldWeatherGradient = LinearGradient(colors: [Color(0xffFEF7FF), Color(0xffFCEBFF)]);
const textWeatherGradient =
    LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffD2C4FF)], transform: GradientRotation(45));
const containerWeatherGradient =
    LinearGradient(colors: [Color(0xffE662E5), Color(0xff5364F0)], transform: GradientRotation(45));

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
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0), side: side ?? BorderSide.none),
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
