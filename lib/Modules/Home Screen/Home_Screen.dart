import 'package:flutter/material.dart';
import 'package:movies/Modules/Home%20Screen/New_Releases/new_releases.dart';
import 'package:movies/Modules/Home%20Screen/Top_Section/top_section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          TopSection(),
          SizedBox(
            height: 25,
          ),
          newrles(),
        ],
      ),
    );
  }
}
