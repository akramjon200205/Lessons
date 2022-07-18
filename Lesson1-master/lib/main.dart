import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson1/best_calculator/best_currency_model.dart';
import 'package:lesson1/best_calculator/page.dart';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<BestCurrencyModel>(BestCurrencyModelAdapter());
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

      home: const BestClaculatePage(),
    );
  }
}
