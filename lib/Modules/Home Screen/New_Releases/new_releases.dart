import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import '../../../services/api_services.dart';
import '../../../shared/components/film_item.dart';
import '../../../shared/styles/colors.dart';

class newrles extends StatefulWidget {
  const newrles({super.key});

  static const _itemsPerRow = 3;
  static const _horizontalPadding = 16.0;
  static const _minItemWidth = 100.0;
  static const _maxItemWidth = 140.0;
  static const _aspectRatio = 2 / 3;

  @override
  State<newrles> createState() => _newrlesState();
}

class _newrlesState extends State<newrles> {
  late Future<Movie> _futureLatest;

  @override
  void initState() {
    super.initState();
    _futureLatest = ApiService.fetchLatest();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder<Movie>(
        future: _futureLatest,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 200,
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 200,
              child: Center(child: Text('Error: \${snapshot.error}')),
            );
          }

          final movie = snapshot.data!;

          return LayoutBuilder(builder: (context, constraints) {
            final available =
                constraints.maxWidth - (newrles._horizontalPadding * 2);
            double itemWidth = (available / newrles._itemsPerRow)
                .clamp(newrles._minItemWidth, newrles._maxItemWidth);
            final itemHeight = itemWidth / newrles._aspectRatio;

            final cardHeight = itemHeight * 0.9 + FilmItem.infoHeight(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: newrles._horizontalPadding),
                  child: Text(
                    'New Releases',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontSize: itemHeight * 0.09,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: cardHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                        left: newrles._horizontalPadding),
                    children: [
                      FilmItem(
                        title: movie.title,
                        time: movie.releaseDate,
                        rate: movie.voteAverage,
                        showInfo: false,
                        width: itemWidth,
                        height: itemHeight,
                        imageUrl: movie.fullPosterUrl,
                        initialInWatchlist: false,
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
