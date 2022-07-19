import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lesson1/best_calculator/best_currency_model.dart';
import 'package:lesson1/best_calculator/best_currency_search_page.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/hive_util.dart';
import 'package:lesson1/widgets/scale_widget.dart';

class BestCurrencyPage extends StatefulWidget {
  const BestCurrencyPage({Key? key}) : super(key: key);

  @override
  State<BestCurrencyPage> createState() => _BestCurrencyPageState();
}

class _BestCurrencyPageState extends State<BestCurrencyPage> with HiveUtil {
  final TextEditingController _editingControllerTop = TextEditingController();
  final TextEditingController _editingControllerBottom =
      TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<BestCurrencyModel> _listCurrency = [];
  BestCurrencyModel? topCur;
  BestCurrencyModel? bottomCur;
  final currencyController = TextEditingController();

  onClickCurrencyButton(String text) {
    if (text == "C") {
      _editingControllerTop.text = "";
    } else if (text == "⌫") {
    } else if (text == '.') {
      if (!_editingControllerTop.text.contains(".")) {
        _editingControllerTop.text += text;
      }
    } else {
      _editingControllerTop.text += text;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff434343),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 29),
          child: Column(
            children: [
              FutureBuilder(
                future: _listCurrency.isEmpty ? _loadData() : null,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 13, right: 7, top: 7),
                      // margin:
                      //     const EdgeInsets.only(left: 12, right: 14, top: 29),
                      decoration: const BoxDecoration(
                          color: Color(0xff262626),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff161616),
                              blurRadius: 4,
                              offset: Offset(0, 3),
                              spreadRadius: 4,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'From currency',
                                style: kTextStyle(
                                    size: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff00E0FF)),
                              ),
                              IconButton(
                                onPressed: () {},
                                iconSize: 20,
                                icon: const Icon(
                                  Icons.refresh,
                                  size: 35,
                                  color: Color(0xff9C9C9C),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _itemExch(_editingControllerTop, topCur, _topFocus,
                              ((value) {
                            if (value is BestCurrencyModel) {
                              setState(() => topCur = value);
                            }
                          })),
                          const SizedBox(
                            height: 15,
                          ),
                          _itemExch(
                            _editingControllerBottom,
                            bottomCur,
                            _bottomFocus,
                            ((value) {
                              if (value is BestCurrencyModel) {
                                setState(() => bottomCur = value);
                              }
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
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
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }),
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemButtonCurrency(
                        "7",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "8",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "9",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "⌫",
                        menuText1,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemButtonCurrency(
                        "4",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "5",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "6",
                        const Color(0xffDADADA),
                      ),
                      scaleWidget(
                        onTap: () {
                          setState(() {
                            var model = topCur?.copyWith();
                            topCur = bottomCur?.copyWith();
                            bottomCur = model;
                            _editingControllerTop.clear();
                            _editingControllerBottom.clear();
                          });
                        },
                        scale: 0.8,
                        child: Container(
                          width: 90.89,
                          height: 79,
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
                            'assets/down_top.png',
                            width: 25.19,
                            height: 49.84,
                            color: menuText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemButtonCurrency(
                        "1",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "2",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "3",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "C",
                        const Color(0xffFF0000),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _itemButtonCurrency(
                        ".",
                        const Color(0xffDADADA),
                      ),
                      _itemButtonCurrency(
                        "0",
                        const Color(0xffDADADA),
                      ),
                      scaleWidget(
                        onTap: () {},
                        scale: 0.8,
                        child: Container(
                          width: 90.89 * 2,
                          height: 79,
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
                                color: const Color(0xffDADADA),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemExch(TextEditingController controller, BestCurrencyModel? model,
      FocusNode focusNode, Function callback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                readOnly: true,
                controller: controller,
                focusNode: focusNode,
                style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '0.00',
                  hintStyle: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BestBestCurrencyPage(
                    _listCurrency,
                    bottomCur: bottomCur.toString(),
                    topCur: topCur.toString(),
                  ),
                ),
              ).then(((value) => callback(value))),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    model?.ccy ?? 'UNK',
                    style: kTextStyle(size: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white54,
                  size: 15,
                )
              ]),
            )
          ],
        ),
      ],
    );
  }

  Widget _itemButtonCurrency(String textCur, Color colorCur) {
    return scaleWidget(
      onTap: () {
        setState(() {
          onClickCurrencyButton(textCur);
        });
      },
      scale: 0.8,
      child: Container(
        width: 90.89,
        height: 79,
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
}
