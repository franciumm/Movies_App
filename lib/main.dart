import 'package:flutter/material.dart';
import 'package:movies/shared/styles/my_theme.dart';

import 'Modules/Main_Layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      home: MainLayout(),
    );
  }
}
