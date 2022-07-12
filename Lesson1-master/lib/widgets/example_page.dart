import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Page'),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          shadowColor: Colors.green,
          color: Colors.blueGrey,
          margin: EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          semanticContainer: false,
          surfaceTintColor: Colors.red,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: 150,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
