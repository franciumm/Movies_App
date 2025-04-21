import 'package:flutter/material.dart';
import 'package:movies/Modules/Browse/Browse_Screen.dart';
import 'package:movies/Modules/Search/Search_Screen.dart';
import 'package:movies/Modules/WatchList/WatchList_Screen.dart';

import 'Home Screen/Home_Screen.dart';

//hello!
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  List<Widget> body = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchListScreen()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
              elevation: 100,
              currentIndex: selectedIndex,
              onTap: onItemTapped,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'SEARCH',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'BROWSE',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'WATCHLIST',
                ),
              ])),
      body: body[selectedIndex],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
