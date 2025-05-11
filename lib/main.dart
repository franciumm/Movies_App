import 'package:flutter/material.dart';
import 'package:movies/shared/styles/my_theme.dart';
import 'package:provider/provider.dart';

import 'Modules/Main_Layout.dart';
import 'models/watchlist_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WatchlistModel(),
      child:  MyApp(),
    ),);
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      home: MainLayout(),
    );
  }
}
