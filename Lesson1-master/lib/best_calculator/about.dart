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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff262626),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/claculate_icon.png',
              width: double.infinity,
              height: 150,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40, bottom: 5),
              child: Text(
                'Best Calculator ver 1.0',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const Text('Creator: Usmonov Akramjon',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text('usmonovakramjon.2002@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.white)))
          ],
        ),
      )),
    );
  }
}
