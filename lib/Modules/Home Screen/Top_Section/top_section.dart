// lib/screens/top_section.dart

import 'dart:math';
import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../services/api_services.dart';
import '../../../shared/components/film_item.dart';
import '../../../shared/styles/colors.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  late Future<Movie> _futureTopMovie;

  @override
  void initState() {
    super.initState();
    _futureTopMovie = ApiService
        .fetchPopular(page: 1)
        .then((resp) => resp.results.first);
  }

  @override
  Widget build(BuildContext context) {
    // cap the background to 1/3 of screen height
    final screenH = MediaQuery.of(context).size.height;
    final maxBgH = screenH / 3;

    return FutureBuilder<Movie>(
      future: _futureTopMovie,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          // placeholder size matches what our final layout will be
          return SizedBox(
            height: maxBgH,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snap.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: ${snap.error}'),
          );
        }

        final movie = snap.data!;
        final width = MediaQuery.of(context).size.width;

        // compute background size
        const bgAspect = 16 / 9;
        final calcBgH = width / bgAspect;
        final bgH = min(calcBgH, maxBgH);

        // poster size is 60% of bg height, 2:3 ratio
        const posterFraction = 0.6;
        const posterAspect = 2 / 3;
        final posterH = bgH * posterFraction;
        final posterW = posterH * posterAspect;
        final posterTop = bgH - (posterH / 2);

        return SizedBox(
          width: width,
          height: bgH + (posterH / 2) + 16,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // background image + play icon + title overlaid
              SizedBox(
                width: width,
                height: bgH,
                child: Stack(fit: StackFit.expand, children: [
                  Image.network(
                    movie.fullBackdropUrl,
                    fit: BoxFit.cover,
                  ),
                  const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 64,
                      color: Colors.white70,
                    ),
                  ),

                ]),
              ),
              Padding(
                padding:  EdgeInsets.only(left: posterW*1.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              // overlapping poster
              Positioned(
                left: 16,
                top: posterTop,
                child: SizedBox(
                  width: posterW,
                  height: posterH,
                  child: FilmItem(
                    title: movie.title,
                    time: movie.releaseDate,
                    rate: movie.voteAverage,
                    showInfo: false,
                    width: posterW,
                    height: posterH,
                    imageUrl: movie.fullPosterUrl,
                    initialInWatchlist: false,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
