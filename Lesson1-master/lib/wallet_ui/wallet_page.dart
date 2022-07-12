import 'package:flutter/material.dart';

import 'price_model.dart';
import '../utils/constants.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: scaffoldColor,
      appBar: AppBar(
        // backgroundColor: scaffoldColor,
        elevation: 0,
        title: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
                image: AssetImage('assets/img_user.jpeg'), fit: BoxFit.cover),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/ic_menu.png',
              height: 30,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                // color: textColor1,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 15),
                child: Text(
                  'Available Balance',
                  style: kTextStyle(size: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '\$28,600',
                style: kTextStyle(size: 50, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(12.5),
                  decoration: BoxDecoration(
                    color: const Color(0xffb1e7ee),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.call_made,
                          // color: accentColor,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Text(
                          'Send',
                          style:
                              kTextStyle(size: 17, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 62,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffc8e7a6), width: 6),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Icon(
                    Icons.call_received,
                    color: Color(0xffc8e7a6),
                    size: 25,
                  ),
                ),
                Container(
                  height: 90,
                  width: 62,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffffecc5), width: 6),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Image.asset(
                    'assets/ic_dots.png',
                    height: 15,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 15),
            child: Text(
              'Last Send',
              style: kTextStyle(size: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...listPrices.map((e) => _item(e)).toList(),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/ic_arrow_down.png',
                  width: 45,
                )),
          )
        ],
      ),
    );
  }

  Widget _item(PriceModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        title: Text(
          model.name ?? '',
          style: kTextStyle(size: 17, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          model.date ?? '',
          style: kTextStyle(color: Colors.grey[500], size: 12),
        ),
        trailing: Text(
          '-\$${model.price}',
          style: kTextStyle(
              color: Colors.orange, size: 17, fontWeight: FontWeight.w600),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black12, width: .5),
        ),
      ),
    );
  }
}
