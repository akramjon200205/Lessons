import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/scale_widget.dart';

class MyWidgetCooking extends StatefulWidget {
  const MyWidgetCooking({Key? key}) : super(key: key);

  @override
  State<MyWidgetCooking> createState() => _MyWidgetCookingState();
}

class _MyWidgetCookingState extends State<MyWidgetCooking>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map listMapArea = {
    "mL(cc)": 'milliliter',
    'gal(US)': 'gallon',
    'qt Iqd(US)': 'quart',
    'pt Iqd(US)': 'pint',
    'fl oz(US)': 'ounce',
    'cuo(US)': 'cup',
    'tbsp(US)': 'tablespoon',
    'tsp(US)': 'teaspoon',
    'gal(UK)': 'gallon',
    'qt(UK)': 'quart',
    'pt(UK)': 'pint',
    'fl oz(UK)': 'ounce',
    'cuo(UK)': 'cup',
    'tbsp(UK)': 'tablespoon',
  };

  Map listMass = {
    "mL(cc)": 1,
    'gal(US)': 3787.8787,
    'qt Iqd(US)': 943.39622,
    'pt Iqd(US)': 473.93364,
    'fl oz(US)': 29.585798817,
    'cuo(US)': 236.406619385,
    'tbsp(US)': 14.792899408,
    'tsp(US)': 4.926108374,
    'gal(UK)': 4545.4545,
    'qt(UK)': 1136.3636,
    'pt(UK)': 568.181818182,
    'fl oz(UK)': 28.4090909091,
    'cuo(UK)': 284.090909091,
    'tbsp(UK)': 17.761989343,
  };

  List<Color> listColor = [distanceColor1, distanceColor2];

  final controllerDistance = TextEditingController();
  final _textTop = TextEditingController();
  final _textButtom = TextEditingController();
  final _measurements = TextEditingController();
  double sizeText = 38;

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
    var res = (listMass[_textButtom.text] *
            double.tryParse(_measurements.text) /
            listMass[selectedDistance])
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
            decoration:  BoxDecoration(
              color: valumePage,
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
                                    itemCount: listMapArea.length,
                                    itemBuilder: (context, index) {
                                      return _itemGestureChecked(
                                        context,
                                        "${listMapArea.values.elementAt(index)}",
                                        "${listMapArea.keys.elementAt(index)}",
                                        listColor[index % 2],
                                        icon: _textTop.text ==
                                                "${listMapArea.values.elementAt(index)}"
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
                                          listMapArea.values.elementAt(0))
                                      : "${_textTop.text}",
                                  style: kTextStyle(
                                      size: 16,
                                      color: menuText1,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _textButtom.text.isEmpty
                                      ? (_textButtom.text =
                                          listMapArea.keys.elementAt(0))
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
          Container(
            width: double.infinity,
            height: size.height - 307,
            decoration: BoxDecoration(color: valumePage,),
            child: ListView.builder(
              itemCount: listMapArea.length,
              itemBuilder: (BuildContext context, int index) {
                if (_textTop.text == listMapArea.values.elementAt(index)) {
                  return Container();
                } else {
                  return _itemMeasurementsContanier(
                    listColor[index % 2],
                    '${listMapArea.values.elementAt(index)}',
                    "${listMapArea.keys.elementAt(index)}",
                    "${distance(listMapArea.keys.elementAt(index))}",
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
        decoration: decorationCurVal,
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
              color: menuText1,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            text2,
            style: kTextStyle(
              size: 24,
              color: menuText1,
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
          color: menuText1,
          fontWeight: FontWeight.w400),
    );
  }
}
