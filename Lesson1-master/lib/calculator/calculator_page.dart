import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/widgets/scale_widget.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  bool _isNightDay = true;
  final _controller = TextEditingController(); // controller = output
  final _resultController = TextEditingController(); //
  double summa = 0;
  double summax = 0;
  String _output = '';
  String operand = '';
  String expression = "";
  double topSize = 28;
  double buttomSize = 40;

  String spliter(String text) {
    var result = text;
    ["/", "+", "-", "x"].forEach((element) {
      result = result.split(element).last;
    });
    return result;
  }

  sizeChecker() {
    if (_controller.text.length > 10 && _controller.text.length % 10 == 0) {
      if (topSize >= 20) {
        topSize -= 5;
      } else {}

      setState(() {});
    } else if (_resultController.text.length > 10 &&
        _resultController.text.length % 5 == 0) {
      if (buttomSize >= 30) {
        buttomSize -= 5;
      } else {}

      setState(() {});
    }
  }

  buttinCalculator(String buttonText) {
    if (buttonText == "C") {
      _controller.text = "0";
      _resultController.text = "0";
      topSize = 28;
      buttomSize = 40;
    } else if (buttonText == "X") {
      _controller.text =
          _controller.text.substring(0, _controller.text.length - 1);

      expression = _controller.text;
      expression = expression.replaceAll("x", '*');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        _resultController.text =
            double.parse("${exp.evaluate(EvaluationType.REAL, cm)}")
                .toString();
      } catch (e) {
        _resultController.text = "";
      }

      if (_controller.text == "") {
        _controller.text = "0";
      }
    } else if (buttonText == "=") {
      expression = _controller.text;
      expression = expression.replaceAll("x", '*');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        _resultController.text =
            ("${exp.evaluate(EvaluationType.REAL, cm)}").toString();
        _controller.text = _resultController.text;
      } catch (e) {
        _resultController.text = "Error";
      }
    } else if (buttonText == "+/-") {
      if (_controller.text.length > 1) {
        expression = _controller.text;
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        _resultController.text =
            "${exp.evaluate(EvaluationType.REAL, cm) * (-1)}";
        _controller.text = _resultController.text;
      }
    } else if (buttonText == "%") {
      if (_controller.text.isNotEmpty) {
        var last = spliter(_controller.text);
        var _controllerText = _controller.text;
        _controller.text =
            "${_controllerText.substring(0, _controllerText.length - last.length)}${double.parse(last) / 100}";
      }
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      if (_controller.text[_controller.text.length - 1] == "+" ||
          _controller.text[_controller.text.length - 1] == "-" ||
          _controller.text[_controller.text.length - 1] == "x" ||
          _controller.text[_controller.text.length - 1] == "/") {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
        _controller.text += buttonText;
      } else {
        if (_controller.text.length > 2 &&
            _controller.text[_controller.text.length - 2] == "." &&
            _controller.text[_controller.text.length - 1] == "0") {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 2);
        }
        _controller.text = _controller.text + buttonText;
      }
    } else if (buttonText == ".") {
      if (!spliter(_controller.text).contains(".")) {
        _controller.text += buttonText;
      }
    } else {
      if (_controller.text == "0") {
        _controller.text = buttonText;
      } else {
        _controller.text = _controller.text + buttonText;
        expression = _controller.text;
        expression = expression.replaceAll("x", '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          _resultController.text =
              double.parse("${exp.evaluate(EvaluationType.REAL, cm)}")
                  .toString();
        } catch (e) {
          _resultController.text = "";
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: _isNightDay == true
            ? const Color(0xff17171C)
            : const Color(0xffF1F2F3),
        statusBarBrightness:
            _isNightDay == true ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            _isNightDay == true ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: _isNightDay == true
          ? const Color(0xff17171C)
          : const Color(0xffF1F2F3),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 151, right: 152),
              child: Container(
                width: 72,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff2E2F38),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isNightDay = true;
                        });
                      },
                      child: _isNightDay == true
                          ? Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff4E505F),
                              ),
                            )
                          : const Icon(
                              Icons.sunny,
                              color: Colors.blue,
                            ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isNightDay = false;
                          });
                        },
                        child: _isNightDay == false
                            ? Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff4E505F),
                                ),
                              )
                            : const Icon(
                                CupertinoIcons.moon,
                                color: Colors.blue,
                              )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.04, bottom: size.height * 0.015),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      onTap: sizeChecker(),
                      maxLines: 1,
                      style: kTextStyle(
                          color:
                              _isNightDay == true ? Colors.white : Colors.grey,
                          size: topSize,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.end,
                      readOnly: true,
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                            fontSize: 28,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 14),
                    ),
                    TextField(
                      onTap: sizeChecker(),
                      maxLines: 1,
                      style: kTextStyle(
                          color:
                              _isNightDay == true ? Colors.white : Colors.black,
                          size: buttomSize,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.end,
                      readOnly: true,
                      controller: _resultController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(
                            fontSize: 40,
                            color: _isNightDay == true
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: size.height * 0.0018,
              crossAxisCount: 4,
              primary: false,
              children: [
                _itemButton(
                  "C",
                  const Color(0xff4E505F),
                  Colors.white,
                ),
                _itemButton(
                  "+/-",
                  const Color(0xff4E505F),
                  Colors.white,
                ),
                _itemButton(
                  "%",
                  const Color(0xff4E505F),
                  Colors.white,
                ),
                _itemButton(
                  "/",
                  const Color(0xff4B5EFC),
                  Colors.white,
                ),
                _itemButton(
                  "7",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "8",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "9",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "x",
                  const Color(0xff4B5EFC),
                  Colors.white,
                ),
                _itemButton(
                  "4",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "5",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "6",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "-",
                  const Color(0xff4B5EFC),
                  Colors.white,
                ),
                _itemButton(
                  "1",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "2",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "3",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "+",
                  const Color(0xff4B5EFC),
                  Colors.white,
                ),
                _itemButton(
                  ".",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "0",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "X",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "=",
                  const Color(0xff4B5EFC),
                  Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemButton(String text, Color color, Color textColor) {
    return scaleWidget(
      onTap: () {
        buttinCalculator(text);
      },
      scale: 0.7,
      child: Container(
        alignment: Alignment.center,
        width: 71.75,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color,
        ),
        child: Text(
          text,
          style: kTextStyle(size: 28, color: textColor),
        ),
      ),
    );
  }
}
