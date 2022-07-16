import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lesson1/best_calculator/best_currency_model.dart';
import 'package:lesson1/best_calculator/setting_page.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/hive_util.dart';
import 'package:lesson1/utils/routes.dart';
import 'package:lesson1/widgets/scale_widget.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin, HiveUtil {
  late TabController _tabController;
  late TabController _tabController1;
  final _bestController = TextEditingController(); // controller = output
  final _bestResultController = TextEditingController(); //
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<BestCurrencyModel> _listCurrency = [];
  BestCurrencyModel? topCur;
  BestCurrencyModel? bottomCur;

  bool click = false;
  bool isPage1 = false;
  bool isPage2 = false;
  bool isPage3 = false;

  String expression = "";

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  Future<bool?> _loadData() async {
    var isLoad = await loadLocalData();
    if (isLoad) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = BestCurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            _listCurrency.add(model);
            await saveBox<String>(dateBox, topCur?.date ?? '', key: dateKey);
            await saveBox<List<dynamic>>(currencyBox, _listCurrency,
                key: currencyListKey);
          }
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
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy').format(
            DateTime.now().add(
              const Duration(days: -1),
            ),
          )) {
        var list =
            await getBox<List<dynamic>>(currencyBox, key: currencyListKey) ??
                [];
        _listCurrency = List.castFrom<dynamic, BestCurrencyModel>(list);
        for (var model in _listCurrency) {
          if (model.ccy == 'USD') {
            topCur = model;
          } else if (model.ccy == 'RUB') {
            bottomCur = model;
          }
        }
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
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

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  String spliter(String text) {
    var result = text;
    ["/", "+", "-", "x"].forEach((element) {
      result = result.split(element).last;
    });
    return result;
  }

  buttonCalculator(String buttonText) {
    if (buttonText == "⌫") {
      _bestController.text =
          _bestController.text.substring(0, _bestController.text.length - 1);

      expression = _bestController.text;
      expression = expression.replaceAll("x", "*");
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        _bestResultController.text =
            double.parse("${exp.evaluate(EvaluationType.REAL, cm)}")
                .toStringAsFixed(2);
      } catch (e) {
        _bestResultController.text = "";
      }
    } else if (buttonText == "=") {
      expression = _bestController.text;
      expression = expression.replaceAll("x", '*');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        _bestResultController.text =
            double.parse("${exp.evaluate(EvaluationType.REAL, cm)}")
                .toStringAsFixed(2);
        _bestController.text = _bestResultController.text;
        _bestResultController.text = "";
      } catch (e) {
        _bestResultController.text = "";
      }
    } else if (buttonText == "%") {
      if (_bestController.text.isNotEmpty) {
        var last = spliter(_bestController.text);
        var _controllerText = _bestController.text;
        _bestController.text =
            "${_controllerText.substring(0, _controllerText.length - last.length)}${double.parse(last) / 100}";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "/") {
        if (_bestController.text[_bestController.text.length - 1] == "+" ||
            _bestController.text[_bestController.text.length - 1] == "-" ||
            _bestController.text[_bestController.text.length - 1] == "x" ||
            _bestController.text[_bestController.text.length - 1] == "/") {}
      }
    } else if (buttonText == ".") {
      if (!spliter(_bestController.text).contains(".")) {
        _bestController.text += buttonText;
      }
    } else if (buttonText == "()") {
    } else if (buttonText == "x^n") {
      // if (double.parse(_bestController.text[_bestController.text.length - 1]) >=
      //         0 &&
      //     double.parse(_bestController.text[_bestController.text.length - 1]) <=
      //         9) {

      // }
    } else {
      if (_bestController.text == "0") {
        _bestController.text = buttonText;
      } else {
        _bestController.text = _bestController.text + buttonText;
        expression = _bestController.text;
        expression = expression.replaceAll("x", '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();

          _bestResultController.text =
              double.parse("${exp.evaluate(EvaluationType.REAL, cm)}")
                  .toStringAsFixed(2);
        } catch (e) {
          _bestResultController.text = "";
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        backgroundColor: const Color(0xff161616),
        leading: GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: const Icon(
            Icons.menu,
            color: color1,
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
              child: Image.asset(
                "assets/settings_icon.png",
                width: 26.31,
                height: 28.44,
              ),
            ),
          ),
        ],
        title: TabBar(
          indicatorColor: const Color(0xff161616),
          indicatorWeight: 0.1,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Image.asset(
                "assets/claculate_icon.png",
                width: 22.9,
                height: 31.36,
              ),
            ),
            Tab(
              icon: Image.asset(
                "assets/currency_icon.png",
                width: 29.58,
                height: 29.58,
              ),
            ),
            Tab(
              icon: Image.asset(
                "assets/lines_icon.png",
                width: 20,
                height: 31,
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
                          "calcualtor_fragment_1", "calcualtor_fragment_2"),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage(
                          "calcualtor_fragment_3", "calcualtor_fragment_4"),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage(
                          "calculator_fragment_5", "calcualtor_fragment_6"),
                      const SizedBox(
                        height: 20,
                      ),
                      _itemPage("google_pixel_2", "xalcualtor_fragment"),
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
        child: const SettingPage(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          colorizeAnimation(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff262626),
                                border: Border.all(
                                    color: const Color(0xffBBBBBB), width: 2),
                              ),
                              child: const Icon(
                                Icons.restore_rounded,
                                size: 33,
                                color: Color(0xffBBBBBB),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: size.height * 0.04),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: TextField(
                    controller: _bestController,
                    maxLines: 1,
                    style: kTextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.end,
                    readOnly: true,
                    decoration: const InputDecoration(
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
                    controller: _bestResultController,
                    style: kTextStyle(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.end,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '',
                      hintStyle:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                GridView.count(
                  padding: const EdgeInsets.only(top: 4),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1.04,
                  childAspectRatio: size.height * 0.0024,
                  crossAxisCount: 4,
                  primary: false,
                  children: [
                    _itemContanier(
                      "x^n",
                      const Color(0xffFF0000),
                    ),
                    _itemContanier(
                      "%",
                      const Color(0xffFF0000),
                    ),
                    _itemContanier(
                      "/",
                      const Color(0xffFF0000),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _bestController.text = "";
                          _bestResultController.text = "";
                        });
                      },
                      child: _itemContanier(
                        "⌫",
                        const Color(0xffFF0000),
                      ),
                    ),
                    _itemContanier(
                      "7",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "8",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "9",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "x",
                      const Color(0xffFF0000),
                    ),
                    _itemContanier(
                      "4",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "5",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "6",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "-",
                      const Color(0xffFF0000),
                    ),
                    _itemContanier(
                      "1",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "2",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "3",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "+",
                      const Color(0xffFF0000),
                    ),
                    _itemContanier(
                      ".",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                      "0",
                      const Color(0xffBBBBBB),
                    ),
                    _itemContanier(
                        "()",
                        const Color(
                          0xffBBBBBB,
                        )),
                    _itemContanier(
                      "=",
                      const Color(0xffFF0000),
                    ),
                  ],
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
                            onTap: () => Navigator.pop(context),
                            child: _itemButtomSheetAnim(size),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 407,
                    height: 31,
                    decoration: const BoxDecoration(
                      color: color1,
                    ),
                    child: Image.asset("assets/parenthesis.png"),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff434343),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 29),
                  ),
                  FutureBuilder(
                    future: _listCurrency.isEmpty ? _loadData() : null,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 385,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Color(0xff262626),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13, right: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "From currency",
                                          style: kTextStyle(
                                              size: 16,
                                              color: const Color(0xff00E0FF),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          size: 40,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                _itemCurrency(
                                  const Color(0xff00E0FF),
                                  topCur,
                                  _editingControllerTop,
                                  _topFocus,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "In currency",
                                  style: kTextStyle(
                                      size: 16,
                                      color: const Color(0xffFF4D00),
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                _itemCurrency(
                                  const Color(0xffFF4D00),
                                  bottomCur,
                                  _editingControllerBottom,
                                  _bottomFocus,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              'Error',
                              style: kTextStyle(size: 18),
                            ),
                          ),
                        );
                      } 
                      else {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  GridView.count(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    primary: false,
                    childAspectRatio: size.height * 0.0024,
                    children: [
                      _itemButtonCurrency(
                        "7",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "8",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "9",
                        const Color(0xffBBBBBB),
                      ),
                      scaleWidget(
                        onTap: () {},
                        scale: 0.8,
                        child: Container(
                          width: 94.89,
                          height: 81,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xff161616),
                            border: Border(
                              top: BorderSide(
                                color: Color(0xff54617F),
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Color(0xff54617F),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.backspace_outlined,
                            size: 25,
                            color: Color(0xffFF0000),
                          ),
                        ),
                      ),
                      _itemButtonCurrency(
                        "4",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "5",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "6",
                        const Color(0xffBBBBBB),
                      ),
                      scaleWidget(
                        onTap: () {},
                        scale: 0.8,
                        child: Container(
                            width: 94.89,
                            height: 81,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff161616),
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xff54617F),
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: Color(0xff54617F),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Image.asset(
                              "assets/down_top.png",
                              width: 25.19,
                              height: 49.84,
                            )),
                      ),
                      _itemButtonCurrency(
                        "1",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "2",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "3",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "C",
                        const Color(0xffFF0000),
                      ),
                      _itemButtonCurrency(
                        ",",
                        const Color(0xffBBBBBB),
                      ),
                      _itemButtonCurrency(
                        "0",
                        const Color(0xffBBBBBB),
                      ),
                      Expanded(
                        child: scaleWidget(
                          onTap: () {},
                          scale: 0.8,
                          child: Container(
                            width: 188,
                            height: 81,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff161616),
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xff54617F),
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: Color(0xff54617F),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              "00",
                              style: kTextStyle(
                                  size: 28,
                                  color: const Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Scaffold(
            backgroundColor: const Color(0xff262626),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xff161616),
              title: TabBar(
                controller: _tabController1,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    icon: Text(
                      "DISTANCE",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "AREA",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "MASS",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "VOLUME",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "TEMPERATURE",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "FUEL",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      "COOKING",
                      style: kTextStyle(
                        size: 16,
                        color: const Color(0xffFF0000),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: double.infinity,
                          height: 170,
                          decoration: const BoxDecoration(
                            color: Color(0Xff161616),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13, right: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "m",
                                      style: kTextStyle(
                                          size: 16,
                                          color: const Color(0xffFF0000),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "m",
                                      style: kTextStyle(
                                          size: 38,
                                          color: const Color(0xffFF0000),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     showModalBottomSheet<void>(
                                //       context: context,
                                //       builder: (BuildContext context) {
                                //         return Container(
                                //           height: size.height * 0.52,
                                //           color: const Color(0xff262626),
                                //           decoration: const BoxDecoration(
                                //             color: Color(0xff262626),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   },
                                //   // child: TextField(
                                //   //   maxLines: 1,
                                //   //   style:
                                //   //       kTextStyle(fontWeight: FontWeight.w700),
                                //   //   textAlign: TextAlign.end,
                                //   //   readOnly: true,
                                //   //   keyboardType: TextInputType.number,
                                //   //   decoration: const InputDecoration(
                                //   //     hintText: '1',
                                //   //     hintStyle: TextStyle(
                                //   //         fontSize: 38,
                                //   //         fontWeight: FontWeight.w700, color: Color(0xffFF0000)),
                                //   //   ),
                                //   // ),
                                // child: Container(

                                // ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: size.height - 307,
                          decoration: const BoxDecoration(
                            color: Color(0xff161616),
                          ),
                          child: ListView(
                            children: [
                              _itemMeasurementsContanier(
                                  const Color(0xff262626),
                                  "millimetr",
                                  "mm",
                                  "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff161616),
                                  "cantimetr",
                                  "cm",
                                  "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff262626), "metr", "m", "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff161616), "yard", "yd", "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff262626), "foot", "ft", "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff161616),
                                  "kilometr",
                                  "km",
                                  "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff262626), "mile", "mi", "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff161616), "inch", "in", "1"),
                              _itemMeasurementsContanier(
                                  const Color(0xff262626),
                                  "nautical mile",
                                  "nmi",
                                  "1"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "ABS",
                    style: kTextStyle(
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _itemMeasurementsContanier(
      Color colorMeasurements, String text1, String text2, String text3) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: colorMeasurements,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 13, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _itemMeasurementsText(text1, 12),
                _itemMeasurementsText(text2, 24),
              ],
            ),
            _itemMeasurementsText(text3, 24),
          ],
        ),
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

  Column _itemButtomSheetAnim(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 30,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffFF0000),
          ),
          child: Image.asset("assets/parenthesis.png"),
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
            _itemBottomSheet("x^-1"),
            _itemBottomSheet("x^2"),
            _itemBottomSheet("x^3"),
            _itemBottomSheet("exp"),
            _itemBottomSheet("log"),
            _itemBottomSheet("ln"),
            _itemBottomSheet("e"),
            _itemBottomSheet("e^n"),
            _itemBottomSheet("|x|"),
            _itemBottomSheet("√"),
            _itemBottomSheet("3√"),
            _itemBottomSheet("n!"),
          ],
        ),
      ],
    );
  }

  Container _itemBottomSheet(String text) {
    return Container(
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
    );
  }

  Widget _itemButtonCurrency(dynamic textCur, Color colorCur) {
    return scaleWidget(
      onTap: () {},
      scale: 0.8,
      child: Container(
        width: 94.89,
        height: 81,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xff161616),
          border: Border(
            top: BorderSide(
              color: Color(0xff54617F),
              width: 1,
            ),
            right: BorderSide(
              color: Color(0xff54617F),
              width: 1,
            ),
          ),
        ),
        child: Text(
          textCur,
          style: kTextStyle(
              size: 28, color: colorCur, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _itemCurrency(Color colorCurrency, BestCurrencyModel? model,
      TextEditingController controller, FocusNode focusNode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model?.ccy ?? 'UNK',
                      style: kTextStyle(size: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model?.ccyNmEn ?? '',
                      style: kTextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 170,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xff262626),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: colorCurrency, width: 2),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            style: kTextStyle(size: 16, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemContanier(String text, Color colors) {
    return scaleWidget(
      onTap: () {
        buttonCalculator(text);
      },
      scale: 0.8,
      child: Container(
        alignment: Alignment.center,
        width: 102,
        height: 78.17,
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
          style: kTextStyle(size: 28, color: colors),
        ),
      ),
    );
  }

  Widget _itemPage(String text, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/$text.png",
          width: 130,
          height: 210,
        ),
        Image.asset(
          "assets/$text2.png",
          width: 130,
          height: 210,
        ),
      ],
    );
  }

  Widget colorizeAnimation() {
    const colorizeColors = [
      Color(0xff262626),
      Colors.grey,
      Color(0xff262626),
      Colors.grey,
      Color(0xff262626),
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 22,
    );
    return AnimatedTextKit(
      pause: const Duration(milliseconds: 600),
      animatedTexts: [
        ColorizeAnimatedText(controller() ?? "",
            textStyle: colorizeTextStyle, colors: colorizeColors),
      ],
      totalRepeatCount: 1,
      repeatForever: true,
    );
  }
}
