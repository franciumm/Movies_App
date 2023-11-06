import 'package:flutter/material.dart';
import 'package:movies/Modules/Home%20Screen/New_Releases/new_releases.dart';
import 'package:movies/Modules/Home%20Screen/Top_Section/top_section.dart';
import 'package:provider/provider.dart';

import '../../Provider/HomeScreenProv.com.dart';
import 'Recomended/Recomended.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ChangeNotifierProvider(
        builder: (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const TopSection(),
                SizedBox(height: MediaQuery.of(context).size.height* (40/580)),
                const newrles(),
                SizedBox(height: MediaQuery.of(context).size.height* (30/580)),
                const recomended(),
                SizedBox(
                    height: MediaQuery.of(context).size.height* (60/580)
                ),
              ],
            ),
          );

        },
        create: (context) => HomeProv(), ),
    );
  }
}
