
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/HomeScreenProv.com.dart';
import 'Top_Section/top_section.dart';
import 'New_Releases/new_releases.dart';
import 'Recomended/Recomended.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProv>(
      create: (_) => HomeProv()..fetchInitialData(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Consumer<HomeProv>(
          builder: (ctx, prov, _) {
            return RefreshIndicator(
              onRefresh: prov.reloadHomeData,
              child: SingleChildScrollView(
                key: ValueKey(prov.reloadKey),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // No more const—this ensures each child rebuilds
                    TopSection(),
                    SizedBox(height: MediaQuery.of(context).size.height * (40 / 580)),
                    newrles(),
                    SizedBox(height: MediaQuery.of(context).size.height * (30 / 580)),
                    Recommended(),
                    SizedBox(height: MediaQuery.of(context).size.height * (60 / 580)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
