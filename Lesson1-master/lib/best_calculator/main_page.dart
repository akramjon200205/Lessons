import 'dart:async';
import 'dart:math';

// import 'package:eval_ex/expression.dart';
// import 'package:eval_ex/expression.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson1/best_calculator/measurements/measuments_page.dart';
import 'package:lesson1/best_calculator/best_currency/best_currency_page.dart';
import 'package:lesson1/best_calculator/cal_constants.dart';
import 'package:lesson1/best_calculator/change_theme.dart';

import 'package:lesson1/best_calculator/best_currency/best_currency_model/best_currency_model.dart';

import 'package:lesson1/main.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/hive_util.dart';
import 'package:lesson1/widgets/scale_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
// import 'package:math_expressions/math_expressions.dart';
// import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

import 'about.dart';

import 'measurements/measurments_utills.dart';

class MainPage extends StatefulWidget {
  MainPage(this.bestController, {Key? key}) : super(key: key);
  String bestController;
  
  @override
  State<MainPage> createState() =>
      _MainPageState(bestController);
}

class _MainPageState extends State<MainPage>
    with
        TickerProviderStateMixin,
        HiveUtil,
        CalculatorUtils,
        MeasurmentsUtills {
  _MainPageState(this.bestController1);

  var scrollConrtoller = ScrollController();

  late TabController _tabController;
  late TabController _tabController1;
  late List hiveMap;
  List<String> hiveList = [];

  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();

  late TabController _tabController2;
  final controller1 = TextEditingController();
  bool _switchValue1 = false;
  bool _switchValue2 = true;
  bool _switchValue3 = true;
  bool _switchValue4 = false;
  bool _switchValue5 = true;
  bool _switchValue6 = false;
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  bool click = false;
  bool isPage1 = false;
  bool isPage2 = false;
  bool isPage3 = false;

  late String bestController1;
  String expression = "";

  double animCricleClear = 0;
  BestCurrencyModel? topCur;
  BestCurrencyModel? bottomCur;

  factorial(int n) {
    if (n <= 1) {
      return 1;
    }
    return n * factorial(n - 1);
  }

  @override
  void initState() {
    super.initState();
    _tabController2 = TabController(length: 2, vsync: this);
    controller1.addListener(() {
      setState(() {});
    });
    // bestController1 = controller1.text;
    scrollConrtoller = ScrollController();
    hiveMap = [];

    // scrollConrtoller.addListener(() {
    //   if (scrollConrtoller.position.userScrollDirection ==
    //           ScrollDirection.forward &&
    //       calculateController.text.contains('+')) {
    //     calculateController.text = resultController.text.substring(1);
    //     resultController.text = '';
    //   }
    //   setState(() {});
    // });

    scrollConrtoller.addListener(() {
      if (scrollConrtoller.position.userScrollDirection ==
          ScrollDirection.forward) {
        writer("C");
      }
      animCricleClear = 20;
      setState(() {});

      Timer(Duration(milliseconds: 1000), () async {
        animCricleClear = 0;
        setState(() {});
      });
    });

    _tabController = TabController(length: 3, vsync: this);
    _tabController1 = TabController(length: 7, vsync: this);
    _editingControllerTop.addListener(() {
      if (_topFocus.hasFocus) {
        setState(() {
          if (_editingControllerTop.text.isNotEmpty) {
            double sum = double.parse(topCur?.rate ?? '0') /
                double.parse(bottomCur?.rate ?? '0') *
                double.parse(_editingControllerTop.text);
            _editingControllerBottom.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerBottom.clear();
          }
        });
      }
    });
    _editingControllerBottom.addListener(() {
      if (_bottomFocus.hasFocus) {
        setState(() {
          if (_editingControllerBottom.text.isNotEmpty) {
            double sum = double.parse(bottomCur?.rate ?? '0') /
                double.parse(topCur?.rate ?? '0') *
                double.parse(_editingControllerBottom.text);
            _editingControllerTop.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerTop.clear();
          }
        });
      }
    });
  }

  // writer(String text) async {
  //   if (text == 'C') {
  //     calculateController.text = '';
  //     resultController.text = '';
  //     topFieldSize = 35;
  //     bottomFieldSize = 45;
  //   } else if (text == 'del') {
  //     if (calculateController.text.isNotEmpty) {
  //       calculateController.text = calculateController.text
  //           .substring(0, calculateController.text.length - 1);
  //       var res = calculate(calculateController.text);
  //       if (res != null) {
  //         resultController.text = "=$res";
  //       }
  //     } else {}
  //   } else if (text == '=') {
  //     if (resultController.text.isEmpty) {}
  //     if (resultController.text.isNotEmpty) {
  //       box.put("${resultController.text}", "${calculateController.text}");
  //       hiveMap = box.values.toList();
  //       hiveList.add("${resultController.text}");
  //       print(box.get("${resultController.text}"));
  //       setState(() {
  //         calculateController.text = resultController.text.substring(1);
  //       });

  //       resultController.text = '';
  //     } else {}
  //   } else if (text == '+/-') {
  //     if (resultController.text.length > 1) {
  //       if (resultController.text.contains('-')) {
  //         resultController.text = '=${resultController.text.substring(2)}';
  //       } else {
  //         resultController.text = '=-${resultController.text.substring(1)}';
  //       }
  //     }
  //   } else if (text == '√') {
  //     if (calculateController.text.isNotEmpty) {
  //       calculateController.text =
  //           sqrt(double.parse(calculate(calculateController.text)))
  //               .toStringAsFixed(3);

  //       var res = calculateController.text.toString().contains('.')
  //           ? double.parse(calculateController.text).toStringAsFixed(3)
  //           : calculateController.text.toString();
  //       resultController.text = "=$res";
  //     }
  //   } else if (text == 'π') {
  //     calculateController.text += pi.toStringAsFixed(3);
  //   } else if (text == '%') {
  //     if (calculateController.text.isNotEmpty) {
  //       var last = splitter(calculateController.text);

  //       var calculateText = calculateController.text;
  //       calculateController.text =
  //           '${calculateText.substring(0, calculateText.length - last.length)}${double.parse(last) / 100}';
  //       var res = calculate(calculateController.text);
  //       if (res != null) {
  //         resultController.text = "=$res";
  //       }
  //     }
  //   } else if (text == '/' || text == 'x' || text == '+' || text == '-') {
  //     if (text == 'x') {
  //       text = '*';
  //     }
  //     lastOperator = text;
  //     if (calculateController.text.isNotEmpty &&
  //         !isOperator(
  //             calculateController.text[calculateController.text.length - 1])) {
  //       calculateController.text += text;
  //       var res = calculate(calculateController.text);
  //       if (res != null) {
  //         resultController.text = "=$res";
  //       }
  //     }
  //   } else if (text == 'e') {
  //     calculateController.text += text;
  //   } else if (text == 'n!') {
  //   } else if (text == "|x|") {
  //     if (calculateController.text.isNotEmpty &&
  //         double.parse(calculateController.text) < 0) {
  //       var modul = double.parse(calculateController.text) * (-1);
  //       var res = calculateController.text.toString().contains('.')
  //           ? double.parse(calculateController.text).abs().toStringAsFixed(3)
  //           : modul.toString();
  //       resultController.text = "=$res";
  //     }
  //   } else if (text == 'n!') {
  //   } else if (text == 'x²' && calculateController.text.isNotEmpty) {
  //     calculateController.text =
  //         (pow(double.parse(calculateController.text), 2).toString());
  //     var res = calculateController.text.toString().contains('.')
  //         ? double.parse(calculateController.text).toStringAsFixed(3)
  //         : calculateController.text.toString();

  //     resultController.text = "=$res";
  //   } else if (text == 'x³' && calculateController.text.isNotEmpty) {
  //     calculateController.text =
  //         (pow(double.parse(calculateController.text), 3).toString());
  //     var res = calculateController.text.toString().contains('.')
  //         ? double.parse(calculateController.text).toStringAsFixed(3)
  //         : calculateController.text.toString();

  //     resultController.text = "=$res";
  //   } else if (text == 'x⁻¹') {
  //     if (calculateController.text.isNotEmpty) {
  //       calculateController.text =
  //           (1 / double.parse(calculateController.text)).toString();

  //       var res = calculateController.text.toString().contains('.')
  //           ? double.parse(calculateController.text).toStringAsFixed(3)
  //           : calculateController.text.toString();

  //       resultController.text = "=$res";
  //     }
  //   } else if (text == '.') {
  //     if (calculateController.text.isNotEmpty &&
  //         !isOperator(
  //             calculateController.text[calculateController.text.length - 1])) {
  //       if (calculateController.text.isNotEmpty) {
  //         var last = splitter(calculateController.text);
  //         if (!last.contains('.')) {
  //           calculateController.text += text;
  //           var res = calculate(calculateController.text);
  //           if (res != null) {
  //             resultController.text = "=$res";
  //           }
  //         }
  //       }
  //     }
  //   } else if (text == "xⁿ") {
  //     if (calculateController.text.isNotEmpty) {
  //       if (!isOperator(
  //           calculateController.text[calculateController.text.length - 1])) {
  //         calculateController.text += "^";
  //       }
  //     } else {}
  //   } else {
  //     var res;
  //     if (text == 'x' && calculateController.text.isNotEmpty) {
  //       text = '*';
  //     }
  //     if (text == '(') {
  //       if (calculateController.text.isEmpty) {
  //         calculateController.text += '(';
  //       } else if (operators.contains(
  //           calculateController.text[calculateController.text.length - 1])) {
  //         calculateController.text += text;
  //         resultController.text =
  //             calculate(bracketFiller(calculateController.text));
  //       } else {
  //         calculateController.text += '$text';
  //       }
  //     } else if (text == ')') {
  //       if (!operators.contains(calculateController.text.length - 1) &&
  //           calculateController.text.isNotEmpty) {
  //         if (bracketDifference(calculateController.text) > 0) {
  //           calculateController.text += text;
  //           resultController.text =
  //               calculate(bracketFiller(calculateController.text));
  //         }
  //       }
  //     }

  //     else if (resultController.text.isEmpty &&
  //         calculateController.text.isNotEmpty) {
  //       calculateController.text = text;
  //       resultController.text = text;
  //     } else {
  //       if (resultController.text.isEmpty &&
  //         calculateController.text.isNotEmpty) {
  //       if(calculateController.text.contains('(')){
  //         calculateController.text += text;
  //       }else {
  //         calculateController.text = text;
  //       }
  //       resultController.text = text;
  //     } else {
  //       calculateController.text += text;
  //       var res = calculate(bracketFiller(calculateController.text));
  //       if (res != null) {
  //         resultController.text = "$res";
  //       }
  //     }
  //     }
  //   }

  //   // setState(() {});
  // }

  writer(String text) {
    if (text == 'C') {
      calculateController.text = '';
      resultController.text = '';
      topFieldSize = 35;
      bottomFieldSize = 45;
    } else if (text == 'del') {
      if (calculateController.text.isNotEmpty) {
        calculateController.text = calculateController.text
            .substring(0, calculateController.text.length - 1);
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (text == '=') {
      if (resultController.text.isNotEmpty) {
        var currentTime = DateTime.now().toString();
        box.put("${resultController.text}", "${calculateController.text}");
        hiveMap = box.values.toList();
        hiveList.add("${resultController.text}");
        print(box.get("${resultController.text}"));
        calculateController.text = resultController.text;
        resultController.text = '';
      }
    } else if (text == '+/-') {
      if (resultController.text.length > 1) {
        if (resultController.text.contains('-')) {
          resultController.text = resultController.text.substring(1);
        } else {
          resultController.text = '-${resultController.text.substring(1)}';
        }
      }
    } else if (text == '%') {
      if (calculateController.text.isNotEmpty) {
        var last = splitter(calculateController.text);
        var calculateText = calculateController.text;
        calculateController.text =
            '${calculateText.substring(0, calculateText.length - last.length)}${double.parse(last) / 100}';
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-') {
      lastOperator = text;
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        calculateController.text += text;
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    } else if (text == '.') {
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        if (calculateController.text.isNotEmpty) {
          var last = splitter(calculateController.text);
          if (!last.contains('.')) {
            calculateController.text += text;
            var res = calculate(bracketFiller(calculateController.text));
            if (res != null) {
              resultController.text = "$res";
            }
          }
        }
      }
    } else if (text == '(') {
      if (calculateController.text.isEmpty) {
        calculateController.text += text;
      } else if (operators.contains(
          calculateController.text[calculateController.text.length - 1])) {
        calculateController.text += text;
        resultController.text =
            calculate(bracketFiller(calculateController.text));
      } else {
        calculateController.text += '*$text';
      }
    } else if (text == ')') {
      if (!operators.contains(
              calculateController.text[calculateController.text.length - 1]) &&
          calculateController.text.isNotEmpty) {
        if (bracketDifference(calculateController.text) > 0) {
          calculateController.text += text;
          resultController.text =
              calculate(bracketFiller(calculateController.text));
        }
      }
    } else {
      if (resultController.text.isEmpty &&
          calculateController.text.isNotEmpty) {
        if (calculateController.text.contains('(')) {
          calculateController.text += text;
        } else {
          calculateController.text = text;
        }
        resultController.text = text;
      } else {
        calculateController.text += text;
        var res = calculate(bracketFiller(calculateController.text));
        if (res != null) {
          resultController.text = "$res";
        }
      }
    }
  }


  int bracketDifference(String operation) {
    int left = 0;
    int right = 0;
    for (int i = 0; i < operation.length; i++) {
      if (operation[i] == '(') {
        left++;
      }
      if (operation[i] == ')') {
        right++;
      }
    }
    return left - right;
  }

  String bracketFiller(String operation) {
    int left = 0;
    int right = 0;
    for (int i = 0; i < operation.length; i++) {
      if (operation[i] == '(') {
        left++;
      }
      if (operation[i] == ')') {
        right++;
      }
    }
    for (int j = 0; j < left - right; j++) {
      if (!operators.contains(operation[operation.length - 1])) {
        operation += '*1)';
      }
    }
    return operation;
  }

  @override
  void dispose() {
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
    _topFocus.dispose();
    _bottomFocus.dispose();
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
    _topFocus.dispose();
    _bottomFocus.dispose();
    scrollConrtoller.dispose();

    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: Icon(
            Icons.menu,
            color: menuText1, // drawer uchun rangi
            size: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.36),
            child: InkWell(
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              child: Icon(
                Icons.settings,
                color: menuText1,
                size: 28,
              ),
            ),
          ),
        ],
        title: TabBar(
          indicatorColor: appBarColor,
          // indicatorWeight: 0.1,
          // indicatorSize: TabBarIndicatorSize.tab,

          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Image.asset(
                "assets/claculate_icon.png",
                width: 22.9,
                height: 31.36,
                color: menuText1,
              ),
            ),
            Tab(
              icon: Image.asset(
                "assets/currency_icon.png",
                width: 29.58,
                height: 29.58,
                color: menuText1,
              ),
            ),
            Tab(
              icon: Image.asset(
                "assets/lines_icon.png",
                width: 20,
                height: 31,
                color: menuText1,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff474747),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Container(
              width: double.infinity,
              height: 560,
              decoration: const BoxDecoration(
                color: Color(0xff474747),
              ),
              child: ListView(
                padding: const EdgeInsets.only(right: 12, left: 15, top: 10),
                children: <Widget>[
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage(
                          "calcualtor_fragment_1", "calcualtor_fragment_2", 1),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage(
                          "calcualtor_fragment_3", "calcualtor_fragment_4", 3),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage(
                          "calculator_fragment_5", "calcualtor_fragment_6", 5),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage("google_pixel_2", "xalcualtor_fragment", 7),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15.51,
            ),
            Container(
              width: 262,
              height: 33,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: bestCalculateGradient,
              ),
              child: Text(
                "More Themes",
                style: kTextStyle(
                    size: 24, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.grey[350],
        width: double.infinity,
        child: Scaffold(
          backgroundColor: Colors.grey[350],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.grey[350],
            title: TabBar(
              controller: _tabController2,
              tabs: <Widget>[
                Tab(
                  icon: Text(
                    "SETTINGS",
                    style: kTextStyle(size: 20, color: Colors.black87),
                  ),
                ),
                Tab(
                  icon: Text(
                    "THEMES",
                    style: kTextStyle(size: 20, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController2,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Text(
                          "Change the text of the main screen",
                          style: kTextStyle(
                              size: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: builds(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                bottom: 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bestController1 = controller1.text;
                                  });
                                  setState(
                                    () {
                                      // controller3 = controller1.text;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MainPage(
                                                  bestController1),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Text("ok"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        _itemSettings(
                          "Minimum accuracy",
                          "Limit minimum accuracy to 2 digits",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _switchValue1,
                              onChanged: (bool value) {
                                setState(() {
                                  _switchValue1 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        _itemSettings(
                          "Swipe to count",
                          "Swipe down the keyboard to calculate",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _switchValue2,
                              onChanged: (bool value) {
                                setState(() {
                                  _switchValue2 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        _itemSettings(
                          "Disable text animation",
                          "Turn of text animation in the main section",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _switchValue3,
                              onChanged: (bool value) async {
                                setState(() {
                                  box1.put('_switchValue3', value);
                                  _switchValue3 = box1.values.first;
                                });
                                print(box1.values.first);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        _itemSettings(
                          "Leave the screean on",
                          "Disable sleep mode while the application is running",
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _switchValue4,
                              onChanged: (bool value) {
                                setState(() {
                                  if (value) {
                                    Wakelock.enabled;
                                  } else {
                                    Wakelock.disable();
                                  }
                                  _switchValue4 = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Column(
                          children: [
                            _itemsSettings2(
                              "Turn off the vibration",
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: _switchValue5,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _switchValue5 = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            _itemsSettings2(
                              "Hide status bar",
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  value: _switchValue6,
                                  onChanged: (bool value) {
                                    setState(() {
                                      if (value) {
                                        SystemChrome.setEnabledSystemUIMode(
                                            SystemUiMode.manual,
                                            overlays: [SystemUiOverlay.bottom]);
                                      } else {
                                        SystemChrome.setEnabledSystemUIMode(
                                            SystemUiMode.manual,
                                            overlays: [
                                              SystemUiOverlay.top,
                                              SystemUiOverlay.bottom
                                            ]);
                                      }
                                      box1.put('_switchValue6', value);
                                      _switchValue6 = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: TextButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const About(),
                              ),
                            ),
                            icon: Container(
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.5),
                                color: Colors.black,
                              ),
                              child: Text(
                                "i",
                                style: kTextStyle(
                                    size: 18,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            label: Text(
                              "About",
                              style: kTextStyle(
                                  size: 22,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        _itemPages("calcualtor_fragment_1",
                            "calcualtor_fragment_2", 1),
                        const SizedBox(
                          height: 20,
                        ),
                        _itemPages("calcualtor_fragment_3",
                            "calcualtor_fragment_4", 3),
                        const SizedBox(
                          height: 20,
                        ),
                        _itemPages("calculator_fragment_5",
                            "calcualtor_fragment_6", 5),
                        const SizedBox(
                          height: 20,
                        ),
                        _itemPages("google_pixel_2", "xalcualtor_fragment", 7),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height / 3,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Stack(
                            children: [
                              box1.values.first == true
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.bottomCenter,
                                        width: double.infinity,
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        // ),
                                        child: colorizeAnimation(),
                                      ),
                                    )
                                  : const Text(""),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: size.height * 0.89,
                                          color: const Color(0xff262626),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 17, right: 17),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        "history",
                                                        style: kTextStyle(
                                                          size: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: const Color(
                                                              0xffFF0000),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Hive.box(
                                                          'calculatorBest',
                                                        ).clear();
                                                        hiveList.clear();
                                                        hiveMap.clear();
                                                      },
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .delete_simple,
                                                        size: 35,
                                                        color:
                                                            Color(0xffFF0000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ValueListenableBuilder<int>(
                                                builder:
                                                    (context, value, child) {
                                                  return Container(
                                                    width: double.infinity,
                                                    height: size.height * 0.775,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff262626),
                                                      border: Border(
                                                        top: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0xffFF0000),
                                                        ),
                                                        bottom: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0xffFF0000),
                                                        ),
                                                      ),
                                                    ),
                                                    child: ListView.builder(
                                                      itemCount:
                                                          hiveList.length,
                                                      itemBuilder:
                                                          ((BuildContext
                                                                  context,
                                                              int index) {
                                                        return Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              double.infinity,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .red)),
                                                          child: ListTile(
                                                            leading: InkWell(
                                                              onTap: () {
                                                                hiveList
                                                                    .removeAt(
                                                                        index);
                                                                hiveMap
                                                                    .removeAt(
                                                                        index);
                                                                box.deleteAt(
                                                                    index);
                                                              },
                                                              child: const Icon(
                                                                CupertinoIcons
                                                                    .delete,
                                                                color:
                                                                    Colors.red,
                                                                size: 25,
                                                              ),
                                                            ),
                                                            title: Text(
                                                              "${hiveMap[index]}",
                                                              style: kTextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20),
                                                            ),
                                                            subtitle: Text(
                                                              "${hiveList[index]}",
                                                              style: kTextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  size: 18),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  );
                                                },
                                                valueListenable: _counter,
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Container(
                                                  height: 30,
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffFF0000),
                                                  ),
                                                  child: Image.asset(
                                                      "assets/parenthesis.png"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: backgroundColor2,
                                      border: Border.all(
                                          color: textColor, width: 2),
                                    ),
                                    child: const Icon(
                                      Icons.restore_rounded,
                                      size: 33,
                                      color: Color(0xffBBBBBB),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: size.height * 0.04),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: TextField(
                            controller: calculateController,
                            maxLines: 1,
                            style: kTextStyle(
                                fontWeight: FontWeight.w400,
                                size: 28,
                                color: textColor),
                            textAlign: TextAlign.end,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontSize: 28,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: TextField(
                            maxLines: 1,
                            controller: resultController,
                            style: kTextStyle(
                                fontWeight: FontWeight.w700,
                                size: 28,
                                color: textColor),
                            textAlign: TextAlign.end,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const Alignment(1, 1),
                      child: Transform.translate(
                        offset: const Offset(20, -10),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 500),
                          scale: animCricleClear,
                          child: Container(
                            // alignment: Alignment.topRight,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xffFF0000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height / 2.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: containerColor,
                ),
                child: GridView.count(
                  padding:
                      EdgeInsets.only(top: 4, left: leftGra, right: rightGra),
                  controller: scrollConrtoller,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  shrinkWrap: true,
                  crossAxisSpacing: widthGridViewCross,
                  mainAxisSpacing: heightGridViewMain,
                  childAspectRatio: size.height * 0.0024,
                  crossAxisCount: 4,
                  primary: false,
                  children: [
                    _itemContanierMainButton(
                      "(",
                      menuText2,
                    ),
                    _itemContanierMainButton(
                      ")",
                      menuText2,
                    ),
                    _itemContanierMainButton(
                      "/",
                      menuText2,
                    ),
                    GestureDetector(
                      onLongPress: () {
                        animCricleClear = 20;
                        setState(() {});

                        Timer(const Duration(milliseconds: 1000), () async {
                          animCricleClear = 0;
                          setState(() {});
                        });
                        setState(() {
                          calculateController.text = "";
                          resultController.text = "";
                        });
                      },
                      child: _itemContanierMainButton1(
                        "del",
                        menuText2,
                      ),
                    ),
                    _itemContanier(
                      "7",
                      textColor,
                    ),
                    _itemContanier(
                      "8",
                      textColor,
                    ),
                    _itemContanier(
                      "9",
                      textColor,
                    ),
                    _itemContanierMainButton1(
                      "x",
                      menuText2,
                    ),
                    _itemContanier(
                      "4",
                      textColor,
                    ),
                    _itemContanier(
                      "5",
                      textColor,
                    ),
                    _itemContanier(
                      "6",
                      textColor,
                    ),
                    _itemContanierMainButton1(
                      "-",
                      menuText2,
                    ),
                    _itemContanier(
                      "1",
                      textColor,
                    ),
                    _itemContanier(
                      "2",
                      textColor,
                    ),
                    _itemContanier(
                      "3",
                      textColor,
                    ),
                    _itemContanierMainButton1(
                      "+",
                      menuText2,
                    ),
                    _itemContanier(
                      ".",
                      textColor,
                    ),
                    _itemContanier(
                      "0",
                      textColor,
                    ),
                    _itemContanier(
                      "%",
                      textColor,
                    ),
                    _itemContanierMainButton1(
                      "=",
                      menuText2,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: size.height * 0.52,
                        color: const Color(0xff262626),
                        child: GestureDetector(
                          child: _itemButtomSheetAnim(size),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 31,
                  decoration: BoxDecoration(
                    color: menuText1,
                  ),
                  child: Image.asset("assets/parenthesis.png"),
                ),
              ),
            ],
          ),
          BestCurrencyPage(),
          Scaffold(
            backgroundColor: valumePage,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: valumePage,
              title: TabBar(
                controller: _tabController1,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    icon: Text(
                      "DISTANCE",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "AREA",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "MASS",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "VOLUME",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "TEMPERATURE",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "FUEL",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "COOKING",
                      style: kTextStyle(
                        size: 16,
                        color: menuText1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController1,
              children: <Widget>[
                MyWidgetMeasurments(listMap, listDistance),
                MyWidgetMeasurments(listMapArea, listArea),
                MyWidgetMeasurments(listMapMassMass, listMass),
                MyWidgetMeasurments(listMapVolume, listVolume),
                MyWidgetMeasurments(listMapTemperature, listTemprature),
                MyWidgetMeasurments(listMapFuel, listFuel),
                MyWidgetMeasurments(listMapCooking, listCooking),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _itemButtomSheetAnim(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: menuText1,
            ),
            child: Image.asset("assets/parenthesis.png"),
          ),
        ),
        GridView.count(
          padding: const EdgeInsets.only(top: 4, bottom: 1),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1.04,
          childAspectRatio: size.height * 0.00237,
          crossAxisCount: 4,
          primary: false,
          children: [
            _itemBottomSheet("RAD"),
            _itemBottomSheet("sin"),
            _itemBottomSheet("cos"),
            _itemBottomSheet("tan"),
            _itemBottomSheet("π"),
            _itemBottomSheet("sinh"),
            _itemBottomSheet("cosh"),
            _itemBottomSheet("tanh"),
            _itemBottomSheet("x⁻¹"),
            _itemBottomSheet("x²"),
            _itemBottomSheet("x³"),
            _itemBottomSheet("exp"),
            _itemBottomSheet("log"),
            _itemBottomSheet("ln"),
            _itemBottomSheet("e"),
            _itemBottomSheet("eⁿ"),
            _itemBottomSheet("|x|"),
            _itemBottomSheet("√"),
            _itemBottomSheet("³√"),
            _itemBottomSheet("n!"),
          ],
        ),
      ],
    );
  }

  Widget _itemBottomSheet(String text) {
    return scaleWidget(
      onTap: () {
        setState(() {
          writer(text);
          // bestCalculate(text);
          // buttinCalculator(text);
        });
      },
      child: Container(
        width: 101,
        height: 76,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xff262626),
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
            color: const Color(0xffDADADA),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _itemContanier(String text, Color colors) {
    return scaleWidget(
      onTap: () {
        writer(text);
        // bestCalculate(text);
        // buttinCalculator(text);
      },
      scale: 0.8,
      child: Container(
        alignment: Alignment.center,
        width: 102,
        height: 78.17,
        decoration: decoration,
        child: Text(
          text,
          style: kTextStyle(size: 28, color: colors),
        ),
      ),
    );
  }

  Widget _itemContanierMainButton(String text, Color colors) {
    return scaleWidget(
      onTap: () {
        writer(text);
        // bestCalculate(text);
        // buttinCalculator(text);
      },
      scale: 0.8,
      child: Container(
        alignment: Alignment.center,
        width: 102,
        height: 78.17,
        decoration: decorationMain,
        child: Text(
          text,
          style: kTextStyle(size: 28, color: colors),
        ),
      ),
    );
  }

  Widget _itemContanierMainButton1(String text, Color colors) {
    return scaleWidget(
      onTap: () {
        writer(text);
        // bestCalculate(text);
        // buttinCalculator(text);
      },
      scale: 0.8,
      child: Container(
        alignment: Alignment.center,
        width: 102,
        height: 78.17,
        decoration: decorationMain1,
        child: Text(
          text,
          style: kTextStyle(size: 28, color: colors),
        ),
      ),
    );
  }

  Widget _itemPage(String text, String text2, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            changeTheme(number);
            setState(() {});
          },
          child: Image.asset(
            "assets/$text.png",
            width: 130,
            height: 210,
          ),
        ),
        InkWell(
          onTap: () {
            changeTheme(number + 1);
            setState(() {});
          },
          child: Image.asset(
            "assets/$text2.png",
            width: 130,
            height: 210,
          ),
        ),
      ],
    );
  }

  Widget colorizeAnimation() {
    const colorizeColors = [
      Color(0xff262626),
      Colors.white,
      Color(0xff262626),
      Colors.white,
      Color(0xff262626),
      Colors.white,
      Color(0xff262626),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 22,
    );
    return AnimatedTextKit(
      pause: const Duration(milliseconds: 1000),
      stopPauseOnTap: true,
      animatedTexts: [
        ColorizeAnimatedText(bestController1,
            textStyle: colorizeTextStyle, colors: colorizeColors),
      ],
      totalRepeatCount: 1,
      repeatForever: true,
    );
  }

  Row _itemPages(String text, String text2, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            changeTheme(number);
            setState(() {});
          },
          child: Image.asset(
            "assets/$text.png",
            width: 150,
            height: 220,
          ),
        ),
        GestureDetector(
          onTap: () {
            changeTheme(number + 1);
            setState(() {});
          },
          child: Image.asset(
            "assets/$text2.png",
            width: 150,
            height: 220,
          ),
        ),
      ],
    );
  }

  Row _itemsSettings2(String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: kTextStyle(
              size: 22, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
        widget,
      ],
    );
  }

  Column _itemSettings(String text1, String text2, Widget widget) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text1,
            style: kTextStyle(
                size: 22, color: Colors.black87, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text2,
                style: kTextStyle(
                    size: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
              widget,
            ],
          ),
        ]);
  }

  Widget builds() => TextField(
        controller: controller1,
        maxLength: 25,
        style: kTextStyle(size: 20, color: Colors.black54),
        decoration: InputDecoration(
            hintText: "Zevs",
            labelText: 'Input string',
            border: const OutlineInputBorder(),
            hintStyle: kTextStyle(size: 20, color: Colors.black54),
            suffixIcon: controller1.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : IconButton(
                    onPressed: () => controller1.clear(),
                    icon: const Icon(Icons.close))),
        textInputAction: TextInputAction.done,
      );
}
