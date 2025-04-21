import 'dart:math';
import 'package:flutter/material.dart';
import '../../../shared/components/film_item.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  static const double backgroundAspect = 16 / 9;
  static const double posterAspect = 2 / 3;
  static const double posterHeightFraction = 0.6; // 60% of bg height
  static const double horizontalPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxBgHeight = screenHeight / 3; // cap to 1/3 screen

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // Compute background height 16:9 and cap
      final calculatedBgHeight = width / backgroundAspect;
      final bgHeight = min(calculatedBgHeight, maxBgHeight);

      // Poster dimensions relative to bg height
      final posterHeight = bgHeight * posterHeightFraction;
      final posterWidth = posterHeight * posterAspect;
      final posterOffset = bgHeight - (posterHeight / 2);

      return SizedBox(
        width: width,
        // total height = bg + half poster below + padding
        height: bgHeight + (posterHeight / 2) + horizontalPadding,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background + icon confined
            SizedBox(
              width: width,
              height: bgHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg',
                    fit: BoxFit.cover,
                  ),
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
            // Poster overlapping background
            Positioned(
              left: horizontalPadding,
              top: posterOffset,
              child: SizedBox(
                width: posterWidth,
                height: posterHeight,
                child: FilmItem(
                  title: 'Avengers: Endgame',
                  time: '',
                  rate: 4.0,
                  showInfo: false,
                  width: posterWidth,
                  height: posterHeight,
                  imageUrl:
                  'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg',
                  initialInWatchlist: false,
                ),
              ),
            ),
            // Title and metadata aligned with poster
            Positioned(
              left: horizontalPadding + posterWidth + horizontalPadding,
              top:   bgHeight,
              child: SizedBox(
                width: width - posterWidth - horizontalPadding * 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Puss in Boots',
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
                    const SizedBox(height: 4),
                    Text(
                      '2022 • 1h 58m',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
