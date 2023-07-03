import 'package:flutter/material.dart';

/// server mode
enum ServerMode { share, receive, auth }

enum ProjectionMode { native, high, low }

enum Tabview { all, clipboard, savePath }

/// todo clipboard read/write   enable/disable

ThemeData customLightTheme = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
);

ThemeData customDarkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
);

LinearGradient pbLinearGradient = const LinearGradient(
  colors: <Color>[
    Colors.purpleAccent,
    Colors.lightBlueAccent,
  ],
);

LinearGradient wwwLinearGradient = const LinearGradient(
  colors: <Color>[
    Colors.white70,
    Colors.white60,
    Colors.white54,
  ],
);

BoxDecoration barLightGradient = BoxDecoration(
  gradient: pbLinearGradient,
);

BoxDecoration barDarkGradient = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.blueGrey,
      Colors.blueGrey.shade700,
    ],
  ),
);

const InputDecoration inputDecoration = InputDecoration(
  border: UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  ),
);

/// shared_preferences key
const String keyDarkMode = 'isDarkMode';
const String keyFontFamily = "fontFamily";
const String keyBrightness = "brightness";
const String keyFontsize = "fontsize";
const String keyBgColor = "bgColor";

const String defaultFontFamily = '';
const double defaultBrightness = 0.2;
const int defaultFontsize = 20;
const int defaultBgColor = 0xfffff2cc;

/// sqlite3
const String dbname = 'ft.db';
const int dbVersion = 1;
