import 'package:flutter/material.dart';
import 'package:lesson1/utils/constants.dart';
import 'package:lesson1/utils/routes.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({Key? key}) : super(key: key);

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  final Color scaffoldColor = const Color(0xfff8f8f8);

  final Color textColor1 = const Color(0xff333333);

  final Gradient _gradient = const LinearGradient(
      colors: [Color(0xff0038F5), Color(0xff9F03FF)],
      transform: GradientRotation(45));

  String btnName = 'Place a bid';

  @override
  Widget build(BuildContext context) {
    var data =
        'Together with my design team, we designed this futuristic Cyberyacht concept artwork. We wanted to create something that has not been created yet, so we started to collect ideas of how we imagine the Cyberyacht could look like in the future.';
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        title: Image.asset(
          'assets/app_logo.png',
          height: 37,
        ),
        centerTitle: false,
        actions: [
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/img_art1.png',
              height: 430,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Silent Color',
                    style: kTextStyle(
                        color: textColor1,
                        size: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: textColor1,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: textColor1,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xffFF9C00), Color(0xffFFDB03)],
                        transform: GradientRotation(60),
                      ),
                    ),
                    child: Text(
                      'H',
                      style: kTextStyle(size: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  label: Text(
                    '@openart',
                    style: kTextStyle(
                        size: 16,
                        color: textColor1,
                        fontWeight: FontWeight.bold),
                  ),
                  style: buttonStyle(
                    color: Colors.white,
                    shadowColor: Colors.black12,
                    elevation: 10,
                    padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                    borderRadius: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              data,
              style: kTextStyle(
                  color: textColor1,
                  size: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                _itemTip('#color'),
                _itemTip('#circle'),
                _itemTip('#black'),
                _itemTip('#art'),
              ],
            ),
          ),
          _itemView(Icons.wb_incandescent, 'View on Etherscan'),
          _itemView(Icons.star_border, 'View on IPFS'),
          _itemView(Icons.auto_graph, 'View IPFS Metadata'),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Bid',
                  style: kTextStyle(
                      color: textColor1, size: 20, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        '0.50 ETH',
                        style: kTextStyle(
                            size: 24,
                            fontWeight: FontWeight.bold,
                            color: textColor1),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '\$2,683.73',
                        style: kTextStyle(
                            size: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Auction ending in',
                  style: kTextStyle(size: 20, color: textColor1),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Row(
                    children: [
                      _itemTime('12', 'hours'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: _itemTime('30', 'minutes'),
                      ),
                      _itemTime('20', 'seconds'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.discoverPage,
                      arguments: {'title': 'ART'}).then((value) {
                    if (value is String) {
                      setState(() {
                        btnName = value;
                      });
                    }
                  }),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: _gradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      btnName,
                      style: kTextStyle(size: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            'Activity',
            style: kTextStyle(size: 20, color: textColor1),
          ),
          const SizedBox(
            height: 30,
          ),
          _itemActivity(),
          _itemActivity(),
          const SizedBox(
            height: 300,
          ),
        ],
      ),
    );
  }

  Widget _itemActivity() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: Colors.white,
        leading: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Image.asset(
                'assets/img_user1.png',
                fit: BoxFit.cover,
                height: 52,
                width: 52,
              ),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bid place by @pawel09',
              style: kTextStyle(fontWeight: FontWeight.bold, color: textColor1),
            ),
            Text(
              'June 06, 2021 at 12:00am',
              style: kTextStyle(
                  size: 13, fontWeight: FontWeight.w500, color: Colors.black54),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '1.50 ETH',
                style: kTextStyle(
                    size: 16, fontWeight: FontWeight.bold, color: textColor1),
              ),
              Text(
                '\$2,683.73',
                style: kTextStyle(
                    size: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )
            ],
          ),
        ),
        trailing: Column(
          children: const [
            Icon(
              Icons.launch,
              color: Colors.black54,
              size: 24,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  Column _itemTime(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextStyle(
              size: 24, fontWeight: FontWeight.bold, color: textColor1),
        ),
        Text(
          subtitle,
          style: kTextStyle(
              size: 13, fontWeight: FontWeight.w500, color: Colors.black54),
        )
      ],
    );
  }

  Container _itemView(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {},
        leading: Icon(icon, color: textColor1, size: 30),
        title: Text(
          title,
          style: kTextStyle(
              size: 16, color: textColor1, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.launch,
          color: Colors.black54,
          size: 24,
        ),
      ),
    );
  }

  Widget _itemTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: TextButton(
        onPressed: () {},
        style: buttonStyle(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: 20,
          side: const BorderSide(color: Colors.black26),
          size: const Size(50, 30),
        ),
        child: Text(
          text,
          style: kTextStyle(
              size: 13, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      ),
    );
  }
}
