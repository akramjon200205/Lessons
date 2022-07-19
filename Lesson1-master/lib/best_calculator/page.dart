import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lesson1/best_calculator/area_pagea.dart';
import 'package:lesson1/best_calculator/best_currency_page.dart';
import 'package:lesson1/best_calculator/cal_constants.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/best_calculator/fuel_page.dart';
import 'package:lesson1/best_calculator/mass_page.dart';
import 'package:lesson1/best_calculator/best_currency_model.dart';
import 'package:lesson1/best_calculator/setting_page.dart';
import 'package:lesson1/best_calculator/temperature_page.dart';
import 'package:lesson1/best_calculator/volume_page.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/hive_util.dart';
import 'package:lesson1/widgets/scale_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'cooking_page.dart';
import 'distance.dart';

class BestClaculatePage extends StatefulWidget {
  const BestClaculatePage({Key? key}) : super(key: key);

  @override
  State<BestClaculatePage> createState() => _BestClaculatePageState();
}

class _BestClaculatePageState extends State<BestClaculatePage>
    with TickerProviderStateMixin, HiveUtil, CalculatorUtils {
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
  var scrollConrtoller = ScrollController();

  bool click = false;
  bool isPage1 = false;
  bool isPage2 = false;
  bool isPage3 = false;

  String expression = "";

  @override
  void initState() {
    super.initState();
    scrollConrtoller = ScrollController();
    scrollConrtoller.addListener(() {
      if (scrollConrtoller.position.userScrollDirection ==
          ScrollDirection.forward) {
        writer("C");
      }
      setState(() {});
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
        child: const SettingPage(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: size.width * 0.68,
                        child: colorizeAnimation()),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "history",
                                              style: kTextStyle(
                                                size: 18,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xffFF0000),
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            CupertinoIcons.delete_simple,
                                            size: 35,
                                            color: Color(0xffFF0000),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: size.height * 0.775,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff262626),
                                        border: Border(
                                          top: BorderSide(
                                            width: 1,
                                            color: Color(0xffFF0000),
                                          ),
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffFF0000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        height: 30,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
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
                            color: const Color(0xff262626),
                            border: Border.all(color: textColor, width: 2),
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
                padding: EdgeInsets.only(top: 10, bottom: size.height * 0.04),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: TextField(
                  controller: calculateController,
                  maxLines: 1,
                  style: kTextStyle(fontWeight: FontWeight.w400, size: 28),
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
                  style: kTextStyle(fontWeight: FontWeight.w700, size: 28),
                  textAlign: TextAlign.end,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    hintStyle:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              GridView.count(
                padding: const EdgeInsets.only(top: 4),
                controller: scrollConrtoller,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1.04,
                childAspectRatio: size.height * 0.0024,
                crossAxisCount: 4,
                primary: false,
                children: [
                  _itemContanier(
                    "xⁿ",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  _itemContanier(
                    "%",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  _itemContanier(
                    "/",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        calculateController.text = "";
                        resultController.text = "";
                      });
                    },
                    child: _itemContanier(
                      "del",
                      menuText1,
                      const Color(0xff161616),
                    ),
                  ),
                  _itemContanier(
                    "7",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "8",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "9",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "x",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  _itemContanier(
                    "4",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "5",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "6",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "-",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  _itemContanier(
                    "1",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "2",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "3",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "+",
                    menuText1,
                    const Color(0xff161616),
                  ),
                  _itemContanier(".", textColor, containerColor),
                  _itemContanier(
                    "0",
                    textColor,
                    containerColor,
                  ),
                  _itemContanier(
                    "( )",
                    const Color(
                      0xffBBBBBB,
                    ),
                    containerColor,
                  ),
                  _itemContanier(
                    "=",
                    menuText1,
                    const Color(0xff161616),
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
              children: const <Widget>[
                MyWidgetDistance(),
                MyWidgetArea(),
                MyWidgetMass(),
                MyWidgetVolume(),
                MyWidgetTemperature(),
                MyWidgetFuel(),
                MyWidgetCooking(),
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

  Widget _itemContanier(String text, Color colors, Color contanierColor) {
    return scaleWidget(
      onTap: () {
        writer(text);
      },
      scale: 0.8,
      child: Container(
        alignment: Alignment.center,
        width: 102,
        height: 78.17,
        decoration: BoxDecoration(
          color: contanierColor,
          border: const Border(
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
      stopPauseOnTap: true,
      animatedTexts: [
        ColorizeAnimatedText(controller() ?? "",
            textStyle: colorizeTextStyle, colors: colorizeColors),
      ],
      totalRepeatCount: 1,
      repeatForever: true,
    );
  }
}
