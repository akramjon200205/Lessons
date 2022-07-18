import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/scale_widget.dart';

class MyWidgetArea extends StatefulWidget {
  const MyWidgetArea({Key? key}) : super(key: key);

  @override
  State<MyWidgetArea> createState() => _MyWidgetAreaState();
}

class _MyWidgetAreaState extends State<MyWidgetArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map listMapArea = {
    "mm²": "square millimeter",
    "cm²": "cantimeter",
    "m²": "meter",
    "ha": "hectar",
    "ft²": 'foot',
    'mi²': 'mile',
    'km²': 'kilometer',
    'in²': 'inch',
    'ac²': 'acre',
  };

  Map listMass = {
    "mm²": 100000,
    "cm²": 10000,
    "m²": 1,
    "ha": 0.0001,
    "ft²": 0.09290304,
    'mi²': 0.000000386,
    'km²': 0.000001,
    'in²': 1550.003,
    'ac²': 0.0002471053,
  };

  List<Color> lisColor = [
    const Color(0xff262626),
    const Color(0xff161616),
  ];

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
                                    itemCount: listMapArea.length,
                                    itemBuilder: (context, index) {
                                      return _itemGestureChecked(
                                        context,
                                        "${listMapArea.values.elementAt(index)}",
                                        "${listMapArea.keys.elementAt(index)}",
                                        lisColor[index % 2],
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
                                      color: const Color(0xffFF0000),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  _textButtom.text.isEmpty
                                      ? (_textButtom.text =
                                          listMapArea.keys.elementAt(0))
                                      : "${_textButtom.text}",
                                  style: kTextStyle(
                                      size: 38,
                                      color: const Color(0xffFF0000),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xffFF0000),
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
                                          const Color(0xffFF0000),
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
                                          const Color(0xffFF0000),
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
                                                color: const Color(0xffFF0000),
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
                                                color: const Color(0xffFF0000),
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
                          color: const Color(0xffFF0000),
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
              itemCount: listMapArea.length,
              itemBuilder: (BuildContext context, int index) {
                if (_textTop.text == listMapArea.values.elementAt(index)) {
                  return Container();
                } else {
                  return _itemMeasurementsContanier(
                    lisColor[index % 2],
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
