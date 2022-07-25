
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/best_calculator/change_theme.dart';
import 'package:lesson1/utils/constants.dart';

class MeasurmentsUtills { 
  // Distance
   Map listMap = {
    "cm": "santimetr",
    "mm": "millimetr",
    "m": "metr",
    "yd": "yard",
    "ft": 'foot',
    'mi': 'mile',
    'km': 'kilometr',
    'in': 'inch',
    'nmi': 'nautical mile',
  };  

  Map listDistance = {
    "cm": 0.01,
    "mm": 0.001,
    "m": 1,
    "yd": 0.9144,
    "ft": 0.3048,
    'mi': 1609.344,
    'km': 1000,
    'in': 0.0254,
    'nmi': 1852,
  };

  // Mass
   Map listMapMassMass = {
    "mg": "milligram",
    "g": "gram",
    "kg": "kilogram",
    "t": "ton",
    "ton(UK)": 'long ton',
    'ton(US)': 'short ton',
    'lb': 'pound',
    'ounce': 'ounce',
    'st': 'stone',
    'ct': 'carat',
  };

  Map listMass = {
    "mg": 0.000001,
    "g": 0.001,
    "kg": 1,
    "t": 10000,
    "ton(UK)": 0.0929,
    'ton(US)': 2589988.11,
    'lb': 1000000,
    'ounce': 6.452 * pow(10, -4),
    'st': 4046.856,
    'ct': 5000,
  };

  // Area
   Map listMapArea = {
    "mm²": "square millimeter",
    "cm²": "cantimeter",
    "m²": "meter",
    "ha": "hectar",
    "ft²": 'foot',
    'mi²': 'mile',
    'km²': 'kilometer',
    'in²': 'inch',
    'ac²': 'acre',
  };

  Map listArea = {
    "mm²": 0.00001,
    "cm²": 0.0001,
    "m²": 1,
    "ha": 0.0001,
    "ft²": 0.09290304,
    'mi²': 0.000000386,
    'km²': 0.000001,
    'in²': 1550.003,
    'ac²': 0.0002471053,
  };
//  Valume
 Map listMapVolume = {
    "m³": "cubic meter",
    "mm³": "cubic millimeter",
    "cm³": "cubic santimeter",
    "dm³": "cubic decimeter",
    "ml(cc)": 'millimeter',
    'L': 'liter',
    'ft³': 'cubic foot',
    'ln³': 'cubic inch',
    'gal(US)': '(US)gallon',
    'pt Iqd(US)': '(US)pint',
    'qt Iqd(US)': '(US)quart',
    'oz(US)': '(US)ounce',
    'cup(US)': '(US)cup',
    'tbsp(US)': '(US)tablespoon',
    'tsp(US)': '(US)teaspoon',
    'gal(UK)': '(UK)gallon',
    'qt(UK)': '(UK)quart',
    'pt(UK)': '(UK)pint',
    'oz(UK)': '(UK)ounce',
    'cup(UK)': '(UK)cup',
    'tbsp(UK)': '(UK)tablespoon',
    'tsp(UK)': '(UK)teaspoon',
    'dr': 'dram',
    'bbl': 'barrel',
    'cord': 'cord',
    'gill': 'gill',
  };

  Map listVolume = {
    "m³": 1,
    "mm³": pow(10, -10) * 10,
    "cm³": 0.000001,
    "dm³": 0.001,
    "ml(cc)": 0.000001,
    'L': 0.001,
    'ft³': 35.3147,
    'ln³': 61023.7438368,
    'gal(US)': 264.1721,
    'pt Iqd(US)': 2113.3764,
    'qt Iqd(US)': 1056.6882,
    'oz(US)': 8.4535,
    'cup(US)': 4226.7528,
    'tbsp(US)': 67628.045,
    'tsp(US)': 202884.1,
    'gal(UK)': 264.1721,
    'qt(UK)': 0.22,
    'pt(UK)': 2113.3764,
    'oz(UK)': 35195.08,
    'cup(UK)': 3519.5033,
    'tbsp(UK)': 56312.127564567,
    'tsp(UK)': 168936.3826937,
    'dr': 270512.18047136,
    'bbl': 6.28981077,
    'cord': 0.27589582978642,
    'gill': 7264.664,
  };
  
  // Temperature
  Map listMapTemperature = {
    "C": "celsius",
    "K": "kelvin",
    "F": "fehrenheit",
  };

  Map listTemprature = {
    "C": 1,
    'K': 274,
    'F': 33.6,
  };

  // Fuel

  Map listMapFuel = {
    "L/100km": "liters/100 kilometer",
    "gal(UK)/100 miles": "gallons(UK)/100 miles",
    "gal(US)/100 miles": "gallons(US)/100 miles",
    "km/L": "kilometer/liter",
    "MPG(UK)": "(UK)miles per gallon",
    "MPG(US)": "(US)miles per gallon",
  };

  Map listFuel = {
    "L/100km": 100,
    "gal(UK)/100 miles": 282.485875706,
    "gal(US)/100 miles": 235.294117647,
    "km/L": 1,
    "MPG(UK)": 0.35400619,
    "MPG(US)": 0.425143708,
  };

  // Cooking
   Map listMapCooking = {
    "mL(cc)": 'milliliter',
    'gal(US)': 'gallon',
    'qt Iqd(US)': 'quart',
    'pt Iqd(US)': 'pint',
    'fl oz(US)': 'ounce',
    'cuo(US)': 'cup',
    'tbsp(US)': 'tablespoon',
    'tsp(US)': 'teaspoon',
    'gal(UK)': 'gallon',
    'qt(UK)': 'quart',
    'pt(UK)': 'pint',
    'fl oz(UK)': 'ounce',
    'cuo(UK)': 'cup',
    'tbsp(UK)': 'tablespoon',
  };

  Map listCooking = {
    "mL(cc)": 1,
    'gal(US)': 3787.8787,
    'qt Iqd(US)': 943.39622,
    'pt Iqd(US)': 473.93364,
    'fl oz(US)': 29.585798817,
    'cuo(US)': 236.406619385,
    'tbsp(US)': 14.792899408,
    'tsp(US)': 4.926108374,
    'gal(UK)': 4545.4545,
    'qt(UK)': 1136.3636,
    'pt(UK)': 568.181818182,
    'fl oz(UK)': 28.4090909091,
    'cuo(UK)': 284.090909091,
    'tbsp(UK)': 17.761989343,
  };
}


