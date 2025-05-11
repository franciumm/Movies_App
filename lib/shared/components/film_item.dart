import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/models/watchlist_model.dart';
import 'package:movies/shared/styles/colors.dart';
import 'package:movies/shared/components/MovieDetailDialog.dart';
class FilmItem extends StatelessWidget {

  static const double _infoPad = 8.0;

  static double infoHeight(BuildContext ctx) {

    return MediaQuery.of(ctx).size.height * (57 / 870) + _infoPad;
  }

  const FilmItem({
    super.key,
    required this.movieId,
    required this.title,
    required this.time,
    required this.rate,
    required this.showInfo,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  final int movieId;
  final String title;
  final String time;
  final String imageUrl;
  final double rate;
  final double width;
  final double height;
  final bool showInfo;

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistModel>(
      builder: (ctx, watchlist, _) {
        final inWatchlist = watchlist.contains(movieId);

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MovieDetailScreen(movieId: movieId),
              ),
            );
          },
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Poster + bookmark
                    Stack(
                      children: [
                        _buildPoster(),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () => watchlist.toggle(movieId),
                            child: Image.asset(
                              inWatchlist
                                  ? 'lib/assets/Photos/donebookmark.png'
                                  : 'lib/assets/Photos/bookmark.png',
                              width: 29,
                              height: 29,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Info strip
                    if (showInfo) _buildInfoStrip(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPoster() {
    return imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    )
        : _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[800],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.white54,
        size: 40,
      ),
    );
  }

  Widget _buildInfoStrip(BuildContext context) {
    return Container(
      width: width,
      color: Recommended,
      padding: EdgeInsets.fromLTRB(
        width * 0.04,
        height * 0.07,
        0,
        height * 0.07,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 3),
              Text(
                rate.toStringAsFixed(1),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            time,
            style:  TextStyle(
              color: TextBack,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
