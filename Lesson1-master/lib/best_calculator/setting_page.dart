import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:lesson1/utils/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

var controller3 = "";

String controller() {
  var string1 = controller3.toString();
  return string1 ?? "";
}

class _SettingPageState extends State<SettingPage>
    with TickerProviderStateMixin {
  late TabController _tabController1;
  final controller1 = TextEditingController();
  bool _switchValue1 = true;
  bool _switchValue2 = true;
  bool _switchValue3 = true;
  bool _switchValue4 = true;
  bool _switchValue5 = true;
  bool _switchValue6 = true;

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 2, vsync: this);
    controller1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.grey[350],
        title: TabBar(
          controller: _tabController1,
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
        controller: _tabController1,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding: EdgeInsets.only(top: 3),
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
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                controller3 = controller1.text;
                              });
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
                          onChanged: (bool value) {
                            setState(() {
                              _switchValue3 = value;
                            });
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
                                  _switchValue6 = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 20),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
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
                            Text(
                              "About",
                              style: kTextStyle(
                                  size: 22,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54),
                            ),
                          ],
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
                    _itemPage("calcualtor_fragment_1", "calcualtor_fragment_2"),
                    const SizedBox(
                      height: 20,
                    ),
                    _itemPage("calcualtor_fragment_3", "calcualtor_fragment_4"),
                    const SizedBox(
                      height: 20,
                    ),
                    _itemPage("calculator_fragment_5", "calcualtor_fragment_6"),
                    const SizedBox(
                      height: 20,
                    ),
                    _itemPage("google_pixel_2", "xalcualtor_fragment"),
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
    );
  }

  Row _itemPage(String text, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/$text.png",
          width: 150,
          height: 220,
        ),
        Image.asset(
          "assets/$text2.png",
          width: 150,
          height: 220,
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
