import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/scale_widget.dart';

class MyWidgetDistance extends StatefulWidget {
  const MyWidgetDistance({Key? key}) : super(key: key);

  @override
  State<MyWidgetDistance> createState() => _MyWidgetDistanceState();
}

class _MyWidgetDistanceState extends State<MyWidgetDistance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map listMap = {
    "cm": "santimetr",
    "mm": "millimetr",
    "m": "metr",
    "yd": "yard",
    "ft": 'foot',
    'mi': 'mile',
    'km': 'kilometr',
    'in': 'inch',
    'nmi': 'nautical mile',
  };

  double listdist = 1;

  Map listDistance = {
    "cm": 0.01,
    "mm": 0.001,
    "m": 1,
    "yd": 0.9144,
    "ft": 0.3048,
    'mi': 1609.344,
    'km': 1000,
    'in': 0.0254,
    'nmi': 1852,
  };
  var ab;

  List<Color> lisColor = [
    const Color(0xff262626),
    const Color(0xff161616),
  ];

  final controllerDistance = TextEditingController();
  final textTop = TextEditingController();
  final textButtom = TextEditingController();
  var textTrailing = TextEditingController();
  final measurements = TextEditingController();
  final textEdit = TextEditingController();
  double sizeText = 38;
  int a = 1;

  late Widget onclick;
  bool oncliked = true;

  onClickButton(String text) {
    if (text == "C") {
      measurements.text = "";
    } else if (text == "⌫") {
      measurements.text =
          measurements.text.substring(0, measurements.text.length - 1);
    } else if (text == ".") {
      if (!measurements.text.contains(".")) {
        measurements.text = int.parse(measurements.text).toString() + text;
      }
    } else if (text == "00") {
      measurements.text += text;
    } else if (text == "1") {
      if (measurements.text != "1") {
        measurements.text += text;
      }
    } else {
      if (measurements.text == '1') {
        measurements.text = '';
      }
      measurements.text += text;
    }
    if (measurements.text.isEmpty) {
      measurements.text = '1';
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    measurements.text = "1";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    textTop.dispose();
    textButtom.dispose();
    measurements.dispose();
  }

  late Size sizes;

  String distance(String selectedDistance) {
    var res = (listDistance[textButtom.text] *
            double.tryParse(measurements.text) /
            listDistance[selectedDistance])
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
                                    itemCount: listMap.length,
                                    itemBuilder: (context, index) {
                                      return _itemGestureChecked(
                                        context,
                                        "${listMap.values.elementAt(index)}",
                                        "${listMap.keys.elementAt(index)}",
                                        lisColor[index % 2],
                                        icon: textTop.text ==
                                                "${listMap.values.elementAt(index)}"
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
                                  textTop.text.isEmpty
                                      ? (textTop.text =
                                          listMap.values.elementAt(0))
                                      : "${textTop.text}",
                                  style: kTextStyle(
                                      size: 16,
                                      color: menuText1,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  textButtom.text.isEmpty
                                      ? (textButtom.text =
                                          listMap.keys.elementAt(0))
                                      : "${textButtom.text}",
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
                                          clearColor,
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
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 28,
                                              color: downChange,
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
                        measurements.text.isNotEmpty
                            ? "${measurements.text}"
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
              itemCount: listMap.length,
              itemBuilder: (BuildContext context, int index) {
                if (textTop.text == listMap.values.elementAt(index)) {
                  return Container();
                } else {
                  return _itemMeasurementsContanier(
                    lisColor[index % 2],
                    '${listMap.values.elementAt(index)}',
                    "${listMap.keys.elementAt(index)}",
                    "${distance(listMap.keys.elementAt(index))}",
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
          textTop.text = text1;
          textButtom.text = text2;
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
