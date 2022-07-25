import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson1/best_calculator/best_currency/best_currency_model/best_currency_model.dart';
import 'package:lesson1/best_calculator/main_page.dart';

//hive uchun box
late Box box;
late Box box1;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<BestCurrencyModel>(BestCurrencyModelAdapter());
  box = await Hive.openBox("calculatorBest");
  box1 = await Hive.openBox("settingsBox");
  // Hive.registerAdapter();
  // Hive.registerAdapter<WeatherModel>(WeatherModelAdapter());
  // Hive.registerAdapter<WeeklyModel>(WeeklyModelAdapter());
  runApp(const LessonApp());
}

class LessonApp extends StatelessWidget {
  const LessonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
      // onGenerateRoute: (settings) => Routes.generateRoute(settings),

      home: 
      // CalculatorPage(),
      MainPage("Enter an optional word"),
    );
  }
}
