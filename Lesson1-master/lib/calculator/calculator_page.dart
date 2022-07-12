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

  buttonString(String textButton) async {
    if (textButton == "C") {
      _output = '';
      _resultController.text = '';
      _controller.text = "";
    } else if (textButton == "X") {
      if (_output != "") {
        _output = _output.substring(0, _output.length - 1);
        // _resultController.text = _resultController.text
        //     .substring(0, _resultController.text.length - 1);
      } else if (_output.length == 1 || _controller.text.length == 1) {
        _output = '';
        setState(() {
          setState(() {
            _controller.text = double.parse(_output).toString();
          });
        });
      }
    } else if (textButton == "+" ||
        textButton == "-" ||
        textButton == "x" ||
        textButton == "/" ||
        textButton == "+/-" ||
        textButton == "%") {
      summa = double.parse(_controller.text);
      operand = textButton;
      // if (operand == '+') {
      //   _output = (double.parse(_output) + summa).toString();
      // }
      _resultController.text = '';
      _resultController.text = "=$_output";
      _output = '';
    } else if (textButton == '.') {
      if (_output.contains(".")) {}
      _output = _output + textButton;
    } else if (textButton == "=") {
      summax = double.parse(_controller.text);
      if (operand == '+') {
        _output = (summa + summax).toString();
      }
      if (operand == '-') {
        _output = (summa - summax).toString();
      }
      if (operand == 'x') {
        _output = (summa * summax).toString();
      }
      if (operand == '/') {
        _output = (summa / summax).toString();
      }
      if (operand == "%") {
        _output = (summax / 100).toString();
      }
      if (operand == "+/-") {
        summax = (summax * (-1));
        _output = summax.toString();
        setState(() {
          _controller.text = double.parse(_output).toString();
        });
      }

      summa = 0.0;
      summax = 0.0;
      operand = '';

      _resultController.text = '';
      _resultController.text = '=$_output';
    } else {
      _output = _output + textButton;
    }

    setState(() {
      _controller.text = double.parse(_output).toString();
    });
  }

  // String equation = "0";
  // String result = "0";
  // String expression = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: const Color(0xff17171C),
          statusBarBrightness:
              _isNightDay == true ? Brightness.dark : Brightness.light),
    );
    return Scaffold(
      backgroundColor: _isNightDay == true
          ? const Color(0xff17171C)
          : const Color(0xffF1F2F3),
      body: SafeArea(
        child: Column(
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
              padding: EdgeInsets.only(top: size.height * 0.04),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      style: kTextStyle(
                          color:
                              _isNightDay == true ? Colors.white : Colors.grey,
                          size: 28,
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
                      style: kTextStyle(
                          color:
                              _isNightDay == true ? Colors.white : Colors.black,
                          size: 40,
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
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "+/-",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
                ),
                _itemButton(
                  "%",
                  _isNightDay == true ? const Color(0xff2E2F38) : Colors.white,
                  _isNightDay == true ? Colors.white : Colors.black,
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

  // Widget _itemButtonPadding(
  //   String text1,
  //   String text2,
  //   String text3,
  //   String text4,
  //   Color color,
  // ) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       _itemButton(
  //         text1,
  //         color,
  //         _isNightDay == true ? Colors.white : Colors.black,
  //       ),
  //       _itemButton(
  //         text2,
  //         color,
  //         _isNightDay == true ? Colors.white : Colors.black,
  //       ),
  //       _itemButton(
  //         text3,
  //         color,
  //         _isNightDay == true ? Colors.white : Colors.black,
  //       ),
  //       _itemButton(
  //         text4,
  //         const Color(0xff4B5EFC),
  //         Colors.white,
  //       ),
  //     ],
  //   );
  // }

  Widget _itemButton(String text, Color color, Color textColor) {
    return scaleWidget(
      onTap: () {
        buttonString(text);
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
  // Widget _itemButton(String buttonText, Color color, Color textColor) {
  //   return scaleWidget(
  //     onTap: () {},
  //     scale: 0.7,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(25),
  //       child: Container(
  //         child: Material(
  //           child: InkWell(
  //             onTap: () {},
  //             child: Container(
  //               alignment: Alignment.center,
  //               width: 71.75,
  //               height: 72,
  //               child: Text(
  //                 buttonText,
  //                 style: TextStyle(
  //                   color: textColor,
  //                   fontSize: 32,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           color: Colors.transparent,
  //         ),
  //         color: color,
  //       ),
  //     ),
  //   );
  // }
}
