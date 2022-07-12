import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lesson1/utils/hive_util.dart';
import 'package:lesson1/weather/weather_model.dart';
import 'package:lesson1/weather/weekly_model.dart';
import 'package:lesson1/widgets/gradient_text.dart';

import '../utils/constants.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with HiveUtil {
  final Color textColor1 = const Color(0xff25272E);
  final Color textColor2 = const Color(0xffCBCBCB);
  WeatherModel? _weatherModel;
  List<WeeklyModel> _listWeekly = [];

  Future<bool?> loadData(String city) async {
    var isLoad = await loadLocalData();
    if (!isLoad) {
      try {
        _listWeekly.clear();
        var response = await get(Uri.parse("https://obhavo.uz/${city.toLowerCase()}"));

        if (response.statusCode == 200) {
          var document = parse(response.body);

          var tempDoc = document.getElementsByClassName("current-forecast")[0];
          var docDetails = document.getElementsByClassName("current-forecast-details")[0].querySelectorAll('p');
          var wkDoc = document.getElementsByClassName("weather-row-day-short");
          var wkTemp = document.getElementsByClassName('weather-row-forecast');
          var wkRain = document.getElementsByClassName("weather-row-pop");

          var model = WeatherModel();
          model.temp = tempDoc.querySelectorAll('strong')[0].text.substring(1);
          model.rain = docDetails[0].text.substring(8);
          model.wind = docDetails[1].text.substring(8).split(",").last;
          model.pess = docDetails[2].text.substring(7, 11);
          model.moon = docDetails[3].text.substring(4);
          model.sun = docDetails[4].text.substring(17);
          model.sunset = docDetails[5].text.substring(16);
          model.tempNight = tempDoc.querySelectorAll('span')[2].text.substring(1);
          model.curDay = document.getElementsByClassName("current-day")[0].text.replaceFirst(', ', '\n');
          model.desc = document.getElementsByClassName("current-forecast-desc")[0].text;

          for (var i = 0; i < 7; i++) {
            var wkModel = WeeklyModel();
            wkModel.day = wkDoc[i + 1].querySelectorAll('strong')[0].text;
            wkModel.date = wkDoc[i + 1].querySelectorAll('div')[0].text;
            wkModel.temp = wkTemp[i].querySelectorAll('span')[0].text;
            wkModel.desc = document.getElementsByClassName('weather-row-desc')[i + 1].text.trim();
            wkModel.rainPer = wkRain[i + 1].text.trim().split("%")[0];
            _listWeekly.add(wkModel);
          }
          _weatherModel = model;

          await saveBox<String?>(dateBox, DateFormat('dd.MM.yyyy').format(DateTime.now()));
          await saveBox<WeatherModel?>(weatherBox, _weatherModel);
          await saveBox<List<WeeklyModel>>(weeklyBox, _listWeekly);

          return true;
        } else {
          _showMessage('Unknown error');
        }
      } on SocketException {
        _showMessage('Connection error');
      } catch (e) {
        _showMessage(e.toString());
      }
    } else {
      return true;
    }
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String?>(dateBox);
      if (date != null && date == DateFormat('dd.MM.yyyy').format(DateTime.now().add(Duration(days: 1)))) {
        _weatherModel = await getBox<WeatherModel?>(weatherBox);
        var list = (await getBox<List<dynamic>>(weeklyBox, defaultValue: [])) ?? [];
        _listWeekly = List.castFrom<dynamic, WeeklyModel>(list);
        return true;
      }
    } catch (e) {
      _showMessage(e.toString());
    }
    return false;
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: scaffoldWeatherGradient,
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: _weatherModel == null ? loadData('Ferghana') : null,
            builder: (context, snapshot) {
              return Column(
                children: [
                  CustomAppBar(
                    textColor1: textColor1,
                    isUpdate: snapshot.hasData,
                  ),
                  if (_weatherModel != null)
                    Flexible(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        children: [
                          WaetherMainBox(
                            model: _weatherModel!,
                          ),
                          WeatherInfoBox(textColor1: textColor1, textColor2: textColor2),
                          Text(
                            'Недельный прогноз',
                            style: kTextStyle(color: textColor1, fontWeight: FontWeight.bold, size: 22),
                          ),
                          SizedBox(
                            height: 250,
                            child: Flexible(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                shrinkWrap: true,
                                children: [
                                  WeeklyItem(
                                    isActive: true,
                                    textColor1: textColor1,
                                    textColor2: textColor2,
                                  ),
                                  WeeklyItem(
                                    isActive: false,
                                    textColor1: textColor1,
                                    textColor2: textColor2,
                                  ),
                                  WeeklyItem(
                                    isActive: false,
                                    textColor1: textColor1,
                                    textColor2: textColor2,
                                  ),
                                  WeeklyItem(
                                    isActive: false,
                                    textColor1: textColor1,
                                    textColor2: textColor2,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class WeeklyItem extends StatelessWidget {
  WeeklyItem({
    required this.isActive,
    required this.textColor1,
    required this.textColor2,
    Key? key,
  }) : super(key: key);

  bool isActive = false;
  final Color textColor1;
  final Color textColor2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        gradient: isActive ? containerWeatherGradient : null,
        borderRadius: BorderRadius.circular(35),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xff5F68ED).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(2, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(
            'Пнд',
            style: kTextStyle(size: 12, color: isActive ? null : textColor1, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '03 Июл',
            style: kTextStyle(size: 10, color: isActive ? null : textColor2, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Image.asset(
              'assets/ic_mist.png',
              height: 40,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 3),
            child: Text(
              '23°',
              style: kTextStyle(size: 20, color: isActive ? null : textColor1, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              minWidth: 30,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2DBE8D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '10%',
              style: kTextStyle(size: 10, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

class WeatherInfoBox extends StatelessWidget {
  const WeatherInfoBox({
    Key? key,
    required this.textColor1,
    required this.textColor2,
  }) : super(key: key);

  final Color textColor1;
  final Color textColor2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff555555).withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(5, 15),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/info/water.png',
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Качество воздуха',
                  style: kTextStyle(color: textColor1, size: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 35,
                  width: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff9A60E5).withOpacity(0.16),
                        blurRadius: 30,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/ic_refresh.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoItem(
                  textColor2: textColor2,
                  textColor1: textColor1,
                  icon: 'pess',
                  title: 'Давление',
                  subTitle: '753 мм рт. ст.',
                ),
                InfoItem(
                  textColor2: textColor2,
                  textColor1: textColor1,
                  icon: 'wind',
                  title: 'Ветер',
                  subTitle: 'ЗСЗ, 5.4 м/c',
                ),
                InfoItem(
                  textColor2: textColor2,
                  textColor1: textColor1,
                  icon: 'sun',
                  title: 'Восход',
                  subTitle: '04:46',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoItem(
                textColor2: textColor2,
                textColor1: textColor1,
                icon: 'moon',
                title: 'Луна',
                subTitle: 'Растущая Луна',
              ),
              InfoItem(
                textColor2: textColor2,
                textColor1: textColor1,
                icon: 'rain',
                title: 'Влажность',
                subTitle: '10%',
              ),
              InfoItem(
                textColor2: textColor2,
                textColor1: textColor1,
                icon: 'sunset',
                title: 'Закат',
                subTitle: '19:46',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem(
      {Key? key,
      required this.textColor2,
      required this.textColor1,
      required this.icon,
      required this.title,
      required this.subTitle})
      : super(key: key);

  final Color textColor2;
  final Color textColor1;
  final String icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/info/$icon.png',
          height: 25,
          width: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kTextStyle(size: 10, fontWeight: FontWeight.w700, color: textColor2),
            ),
            Text(
              subTitle,
              style: kTextStyle(size: 10, fontWeight: FontWeight.bold, color: textColor1),
            ),
          ],
        )
      ],
    );
  }
}

class WaetherMainBox extends StatelessWidget {
  const WaetherMainBox({
    required this.model,
    Key? key,
  }) : super(key: key);

  final WeatherModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            gradient: containerWeatherGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff5264F0).withOpacity(0.31),
                blurRadius: 30,
                offset: const Offset(10, 15),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 116),
                  child: Text(
                    model.desc ?? '',
                    style: kTextStyle(size: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GradientText(
                    model.temp ?? '',
                    style: kTextStyle(size: 55, fontWeight: FontWeight.bold),
                    gradient: textWeatherGradient,
                  ),
                  Text(
                    'Очищается ${model.tempNight}',
                    style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          child: Image.asset(
            'assets/${wtypes[model.desc] ?? 'ic_sunny'}.png',
            height: 160,
            width: 160,
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: Text(
            model.curDay ?? '',
            style: kTextStyle(size: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.textColor1, required this.isUpdate}) : super(key: key);

  final Color textColor1;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff9A60E5).withOpacity(0.16),
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/ic_settings.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/ic_location.png',
                  height: 20,
                  width: 20,
                ),
                label: Text(
                  'Фергана',
                  style: kTextStyle(color: textColor1, size: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: containerWeatherGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isUpdate ? 'Updated°' : 'Updating°',
                  style: kTextStyle(size: 12),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2),
                image: const DecorationImage(image: AssetImage('assets/img_ava.png'), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff9A60E5).withOpacity(0.16),
                    blurRadius: 30,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
