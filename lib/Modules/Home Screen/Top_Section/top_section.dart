import 'dart:math';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../models/movie.dart';
import '../../../services/api_services.dart';
import '../../../shared/components/film_item.dart';


class TopSection extends StatefulWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  late Future<Movie> _futureTopMovie;

  @override
  void initState() {
    super.initState();
    _futureTopMovie = ApiService.fetchPopular();
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final maxBgH = screenH / 3;

    return FutureBuilder<Movie>(
      future: _futureTopMovie,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: maxBgH,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snap.hasError) {
          return SizedBox(
            height: maxBgH,
            child: const Center(child: Text('Error: \${snap.error}')),
          );
        }

        final movie = snap.data!;
        final width = MediaQuery.of(context).size.width;

        const bgAspect = 16 / 9;
        final calcBgH = width / bgAspect;
        final bgH = min(calcBgH, maxBgH);

        const posterFrac = 0.6;
        const posterAspect = 2 / 3;
        final posterH = bgH * posterFrac;
        final posterW = posterH * posterAspect;
        final posterTop = bgH - (posterH / 2);

        // Determine if backdrop URL is available
        final hasBackdrop = movie.backdropPath.isNotEmpty;
        final backdropUrl = hasBackdrop
            ? movie.fullBackdropUrl
            : null;

        return SizedBox(
          width: width,
          height: bgH + posterH / 2 + 16,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: width,
                height: bgH,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Backdrop or placeholder
                    if (backdropUrl != null)
                      Image.network(
                        backdropUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _bgPlaceholder(bgH),
                      )
                    else
                      _bgPlaceholder(bgH),

                    const Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 64,
                        color: Colors.white70,
                      ),
                    ),


                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:posterW*1.5, top: bgH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
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
              // Overlapping poster
              Positioned(
                left: 16,
                top: posterTop,
                child: SizedBox(
                  width: posterW,
                  height: posterH,
                  child: FilmItem(
                    title: movie.title,
                    time: movie.releaseDate,
                    movieId: movie.id,
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


  Widget _bgPlaceholder(double height) {
    return Container(
      height: height,
      color: Colors.grey[800],
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          size: 48,
          color: Colors.white38,
        ),
      ),
    );
  }
}
