import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _SettingsState();
}

class _SettingsState extends State<About> {
  final settingsController = TextEditingController();
  var switchValue = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xff262626),
              body: SafeArea(
                  child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/claculate_icon.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Best Calculator ver 1.0',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text('Creator: Usmonov Akramjon',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    SizedBox(height: 20),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        label: Text('usmonovakramjon.2002@gmail.com',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)))
                  ],
                ),
              )),
            )));
  }
}
