import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage(this.title, {Key? key}) : super(key: key);

  final String title;

  final Color scaffoldColor = const Color(0xfff8f8f8);
  final Color textColor1 = const Color(0xff333333);
  final Gradient _gradient = const LinearGradient(
      colors: [Color(0xff0038F5), Color(0xff9F03FF)],
      transform: GradientRotation(45));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor1),
        leading: IconButton(
            onPressed: () => Navigator.pop(context, 'BUTTON'),
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          title,
          style: kTextStyle(
              color: textColor1, size: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              color: textColor1,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_outlined,
              color: textColor1,
              size: 24,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Column(
            children: [
              Text(
                'Discover creator',
                style: kTextStyle(
                    size: 20,
                    color: textColor1,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                    height: 1.28),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: Text(
                  'Follow at least five creators\nto build your feed…',
                  textAlign: TextAlign.center,
                  style: kTextStyle(
                      size: 16,
                      color: textColor1,
                      fontWeight: FontWeight.w400,
                      height: 1.2),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 42,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    gradient: _gradient,
                  ),
                  child: Text(
                    'Feature Creatior',
                    style: kTextStyle(size: 16),
                  ),
                ),
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: const Color(0xffF0F0F0)),
                  child: Text(
                    'All Creator',
                    style: kTextStyle(size: 16, color: textColor1),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfffcfcfc),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: Image.asset(
                          'assets/img_bg.png',
                          height: 135,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        image: const DecorationImage(
                            image: AssetImage('assets/img_user.png'),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Kennedy Yanko',
                    style: kTextStyle(
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Kennedy Yanko is an artist working in found metal and paint skin. Her methods reflect a dual abstract expressionist-surr…',
                    textAlign: TextAlign.center,
                    style:
                        kTextStyle(size: 16, color: textColor1, height: 1.35),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '2024',
                        style: kTextStyle(
                            color: textColor1,
                            size: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          'Followers',
                          style: kTextStyle(
                              size: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: buttonStyle(
                          color: Colors.white,
                          shadowColor: Colors.black26,
                          elevation: 10,
                          borderRadius: 8,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                        ),
                        child: Text(
                          'Follow',
                          style: kTextStyle(
                              color: textColor1,
                              size: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: textColor1,
                size: 24,
              ),
              label: Text(
                'Load more',
                style: kTextStyle(
                    size: 20, color: textColor1, fontWeight: FontWeight.bold),
              ),
              style: buttonStyle(
                  borderRadius: 8,
                  side: const BorderSide(color: Color(0xff0038F5), width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 15)),
            ),
          )
        ],
      ),
    );
  }
}
