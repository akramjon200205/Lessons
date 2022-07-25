import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lesson1/best_calculator/best_currency/best_currency_model/best_currency_model.dart';
import 'package:lesson1/utils/constants.dart';

class BestBestCurrencyPage extends StatefulWidget {
  const BestBestCurrencyPage(this._listCurrency, {Key? key, required this.topCur, required this.bottomCur}) : super(key: key);
  final List<BestCurrencyModel> _listCurrency;
  final String topCur;
  final String bottomCur;

  @override
  State<BestBestCurrencyPage> createState() => _BestBestCurrencyPageState();
}

class _BestBestCurrencyPageState extends State<BestBestCurrencyPage> {
  final List<BestCurrencyModel> _filterList = [];
  final TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _filterList.addAll(widget._listCurrency);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1f2235),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _editingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            fillColor: const Color(0xff2d334d),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: 20,
            ),
            hintText: 'Search',
            hintStyle: kTextStyle(color: Colors.white54, size: 16, fontWeight: FontWeight.w500),
            suffixIcon: IconButton(
                onPressed: () {
                  if (_editingController.text.isEmpty) {
                    Navigator.pop(context);
                  } else {
                    _editingController.clear();
                    setState(() {
                      _filterList.clear();
                      _filterList.addAll(widget._listCurrency);
                    });
                  }
                },
                icon: const Icon(Icons.clear, color: Colors.white, size: 20)),
          ),
          style: kTextStyle(size: 16, fontWeight: FontWeight.w500),
          onChanged: (value) {
            _filterList.clear();
            if (value.isNotEmpty) {
              for (final item in widget._listCurrency) {
                if (item.ccy!.toLowerCase().contains(value.toLowerCase()) ||
                    item.ccyNmEn!.toLowerCase().contains(value.toLowerCase())) {
                  _filterList.add(item);
                }
              }
            } else {
              _filterList.addAll(widget._listCurrency);
            }
            setState(() {});
          },
        ),
      ),
      backgroundColor: const Color(0xff1f2235),
      body: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemBuilder: ((context, index) {
            var model = _filterList[index];
            bool isChosen = widget.topCur == model.ccy || widget.bottomCur == model.ccy;
            return ListTile(
              tileColor: const Color(0xff2d334d),
              onTap: () {
                if (isChosen) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'It has been chosen!!!',
                        style: kTextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                } else {
                  Navigator.pop(context, model);
                }
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(27.5),
                child: SvgPicture.asset(
                  'assets/flags/${model.ccy?.substring(0, 2).toLowerCase()}.svg',
                  height: 45,
                  width: 45,
                ),
              ),
              title: Text(
                model.ccy ?? '',
                style: kTextStyle(size: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                model.ccyNmEn ?? '',
                style: kTextStyle(fontWeight: FontWeight.w500, color: Colors.white54),
              ),
              trailing: Text(
                model.rate ?? '',
                style: kTextStyle(size: 16, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: isChosen ? const BorderSide(color: Color(0xff10a4d4), width: 2) : BorderSide.none),
            );
          }),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: _filterList.length),
    );
  }
}