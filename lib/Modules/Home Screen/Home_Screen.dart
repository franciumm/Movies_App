import 'package:flutter/material.dart';
import 'package:movies/shared/components/top_section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [TopSection()],
      ),
    );
  }
}
