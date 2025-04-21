import 'package:flutter/material.dart';
import 'package:movies/shared/styles/my_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        title: Center(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.onPrimary,
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .unselectedItemColor),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .unselectedItemColor)),
                style: TextStyle(
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor),
              ),
            ),
          ),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/Photos/Icon material-local-movies.png',
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('No Results',
                    style: Theme.of(context).textTheme.displayLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
