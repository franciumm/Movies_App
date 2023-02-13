import 'package:flutter/material.dart';
import 'package:movies/Modules/Home%20Screen/New_Releases/new_releases.dart';
import 'package:movies/Modules/Home%20Screen/Top_Section/top_section.dart';

import 'Recomended/Recomended.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TopSection(),
            SizedBox(
              height: 25,
            ),
            newrles(),
            SizedBox(
              height: 25,
            ),
            recomended(),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
