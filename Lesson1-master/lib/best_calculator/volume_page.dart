import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/scale_widget.dart';

class MyWidgetVolume extends StatefulWidget {
  const MyWidgetVolume({Key? key}) : super(key: key);

  @override
  State<MyWidgetVolume> createState() => _MyWidgetVolumeState();
}

class _MyWidgetVolumeState extends State<MyWidgetVolume>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map listMapVolume = {
    "m³": "cubic meter",
    "mm³": "cubic millimeter",
    "cm³": "cubic santimeter",
    "dm³": "cubic decimeter",
    "ml(cc)": 'millimeter',
    'L': 'liter',
    'ft³': 'cubic foot',
    'ln³': 'cubic inch',
    'gal(US)': '(US)gallon',
    'pt Iqd(US)': '(US)pint',
    'qt Iqd(US)': '(US)quart',
    'oz(US)': '(US)ounce',
    'cup(US)': '(US)cup',
    'tbsp(US)': '(US)tablespoon',
    'tsp(US)': '(US)teaspoon',
    'gal(UK)': '(UK)gallon',
    'qt(UK)': '(UK)quart',
    'pt(UK)': '(UK)pint',
    'oz(UK)': '(UK)ounce',
    'cup(UK)': '(UK)cup',
    'tbsp(UK)': '(UK)tablespoon',
    'tsp(UK)': '(UK)teaspoon',
    'dr': 'dram',
    'bbl': 'barrel',
    'cord': 'cord',
    'gill': 'gill',
  };

  Map listVolume = {
    "m³": 1,
    "mm³": pow(10, -10) * 10,
    "cm³": 0.000001,
    "dm³": 0.001,
    "ml(cc)": 0.000001,
    'L': 0.001,
    'ft³': 35.3147,
    'ln³': 61023.7438368,
    'gal(US)': 264.1721,
    'pt Iqd(US)': 2113.3764,
    'qt Iqd(US)': 1056.6882,
    'oz(US)': 8.4535,
    'cup(US)': 4226.7528,
    'tbsp(US)': 67628.045,
    'tsp(US)': 202884.1,
    'gal(UK)': 264.1721,
    'qt(UK)': 0.22,
    'pt(UK)': 2113.3764,
    'oz(UK)': 35195.08,
    'cup(UK)': 3519.5033,
    'tbsp(UK)': 56312.127564567,
    'tsp(UK)': 168936.3826937,
    'dr': 270512.18047136,
    'bbl': 6.28981077,
    'cord': 0.27589582978642,
    'gill': 7264.664,
  };

  List<Color> lisColor = [
    const Color(0xff262626),
    const Color(0xff161616),
  ];

  final controllerDistance = TextEditingController();
  final _textTop = TextEditingController();
  final _textButtom = TextEditingController();
  var _textTrailing = TextEditingController();
  final _measurements = TextEditingController();
  final _textEdit = TextEditingController();
  double sizeText = 38;
  int a = 1;

  late Widget onclick;
  bool oncliked = true;

  onClickButton(String text) {
    if (text == "C") {
      _measurements.text = "";
    } else if (text == "⌫") {
      _measurements.text =
          _measurements.text.substring(0, _measurements.text.length - 1);
    } else if (text == ".") {
      if (!_measurements.text.contains(".")) {
        _measurements.text = int.parse(_measurements.text).toString() + text;
      }
    } else if (text == "00") {
      _measurements.text += text;
    } else if (text == "1") {
      if (_measurements.text != "1") {
        _measurements.text += text;
      }
    } else {
      if (_measurements.text == '1') {
        _measurements.text = '';
      }
      _measurements.text += text;
    }
    if (_measurements.text.isEmpty) {
      _measurements.text = '1';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _measurements.text = "1";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _textTop.dispose();
    _textButtom.dispose();
    _measurements.dispose();
  }

  late Size sizes;

  String distance(String selectedDistance) {
    var res = (listVolume[_textButtom.text] *
            double.tryParse(_measurements.text) /
            listVolume[selectedDistance])
        .toStringAsFixed(10);
    return double.parse(res).toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {
      sizes = size;
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // alignment: Alignment.bottomLeft,
            width: double.infinity,
            height: size.height / 4,
            decoration: const BoxDecoration(
              color: Color(0Xff161616),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 13, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: const Color(0xff262626),
                                  child: ListView.builder(
                                    itemCount: listMapVolume.length,
                                    itemBuilder: (context, index) {
                                      return _itemGestureChecked(
                                        context,
                                        "${listMapVolume.values.elementAt(index)}",
                                        "${listMapVolume.keys.elementAt(index)}",
                                        lisColor[index % 2],
                                        icon: _textTop.text ==
                                                "${listMapVolume.values.elementAt(index)}"
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : null,
                                      );
                                    },
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _textTop.text.isEmpty
                                      ? (_textTop.text =
                                          listMapVolume.values.elementAt(0))
                                      : "${_textTop.text}",
                                  style: kTextStyle(
                                      size: 16,
                                      color: menuText1,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _textButtom.text.isEmpty
                                      ? (_textButtom.text =
                                          listMapVolume.keys.elementAt(0))
                                      : "${_textButtom.text}",
                                  style: kTextStyle(
                                      size: 38,
                                      color: menuText1,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: menuText1,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xff262626),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 18, right: 18, bottom: 34),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: GridView.count(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1.04,
                                      childAspectRatio: size.height * 0.00175,
                                      crossAxisCount: 4,
                                      primary: false,
                                      children: [
                                        _itemMeasurements(
                                          "7",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "8",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "9",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "⌫",
                                          menuText1,
                                        ),
                                        _itemMeasurements(
                                          "4",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "5",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "6",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "C",
                                          menuText1,
                                        ),
                                        _itemMeasurements(
                                          "1",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "2",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "3",
                                          const Color(0xffDADADA),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 95,
                                            height: 81,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff161616),
                                              border: Border(
                                                top: BorderSide(
                                                  color: Color(0xff5A5A5A),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              "ok",
                                              style: kTextStyle(
                                                size: 28,
                                                color: menuText1,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        _itemMeasurements(
                                          ".",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "0",
                                          const Color(0xffDADADA),
                                        ),
                                        _itemMeasurements(
                                          "00",
                                          const Color(0xffDADADA),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 95,
                                            height: 81,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff161616),
                                              border: Border(
                                                top: BorderSide(
                                                  color: Color(0xff5A5A5A),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              "^",
                                              style: kTextStyle(
                                                size: 28,
                                                color: downChange,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        _measurements.text.isNotEmpty
                            ? "${_measurements.text}"
                            : "1",
                        style: kTextStyle(
                          size: sizeText,
                          color: menuText1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height - 307,
            child: ListView.builder(
              itemCount: listMapVolume.length,
              itemBuilder: (BuildContext context, int index) {
                if (_textTop.text == listMapVolume.values.elementAt(index)) {
                  return Container();
                } else {
                  return _itemMeasurementsContanier(
                    lisColor[index % 2],
                    '${listMapVolume.values.elementAt(index)}',
                    "${listMapVolume.keys.elementAt(index)}",
                    "${distance(listMapVolume.keys.elementAt(index))}",
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemMeasurements(String text, Color textColorMeas) {
    return scaleWidget(
      onTap: () {
        setState(() {
          onClickButton(text);
        });
      },
      scale: 0.8,
      child: Container(
        width: 95,
        height: 81,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xff161616),
          border: Border(
            top: BorderSide(
              color: Color(0xff5A5A5A),
              width: 1,
            ),
          ),
        ),
        child: Text(
          text,
          style: kTextStyle(
            size: 28,
            color: textColorMeas,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _itemGestureChecked(
      BuildContext context, String text1, String text2, Color colorsGesture,
      {Icon? icon}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          _textTop.text = text1;
          _textButtom.text = text2;
        });
      },
      child: Container(
        height: 71.17,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorsGesture,
        ),
        child: ListTile(
          title: Text(
            text1,
            style: kTextStyle(
              size: 12,
              color: const Color(0xffDADADA),
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            text2,
            style: kTextStyle(
              size: 24,
              color: const Color(0xffDADADA),
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: icon,
        ),
      ),
    );
  }

  Widget _itemMeasurementsContanier(
      Color colorMeasurements, String text1, String text2, String text3) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: colorMeasurements,
      ),
      child: ListTile(
        title: _itemMeasurementsText(text1, 12),
        subtitle: _itemMeasurementsText(text2, 24),
        trailing: _itemMeasurementsText(text3, 24),
      ),
    );
  }

  Text _itemMeasurementsText(String text, double sizes) {
    return Text(
      text,
      style: kTextStyle(
          size: sizes,
          color: const Color(0xffDADADA),
          fontWeight: FontWeight.w400),
    );
  }
}
