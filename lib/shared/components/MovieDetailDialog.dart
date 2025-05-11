import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';
import '../../services/api_services.dart';
import '../../models/watchlist_model.dart';
import '../../shared/components/film_item.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Movie Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        leading: const BackButton(color: Colors.white),
        actions: [
          Consumer<WatchlistModel>(
            builder: (ctx, watchlist, _) {
              final inList = watchlist.contains(movieId);
              return IconButton(
                icon: Icon(
                  inList ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () => watchlist.toggle(movieId),
                tooltip: inList ? 'Remove from Watchlist' : 'Add to Watchlist',
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<_MovieDetailData>(
        future: _fetchDetailData(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(
              child: Text(
                'Error: ${snap.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final detail = snap.data!.movie;
          final similar = snap.data!.similar;

          // Poster widget
          Widget poster = (detail.posterPath?.isNotEmpty ?? false)
              ? Image.network(
            'https://image.tmdb.org/t/p/w500${detail.posterPath}',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _placeholder(),
          )
              : _placeholder();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: poster,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          detail.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            detail.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    detail.overview,
                    style: const TextStyle(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'More Like This',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (ctx, constraints) {
                    const itemsPerRow = 3, hPad = 16.0;
                    const minW = 100.0, maxW = 140.0, aspect = 2 / 3;
                    final totalGaps = (itemsPerRow + 1) * hPad;
                    double itemW = (constraints.maxWidth - totalGaps) / itemsPerRow;
                    itemW = itemW.clamp(minW, maxW);
                    final itemH = itemW / aspect;
                    final cardH = itemH * 1.3 + FilmItem.infoHeight(ctx);

                    return SizedBox(
                      height: cardH,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: hPad),
                        separatorBuilder: (_, __) => const SizedBox(width: hPad),
                        itemCount: similar.length,
                        itemBuilder: (_, i) {
                          final m = similar[i];
                          return FilmItem(
                            movieId: m.id,
                            title: m.title,
                            time: m.releaseDate,
                            rate: m.voteAverage,
                            showInfo: true,
                            width: itemW,
                            height: itemH,
                            imageUrl: m.fullPosterUrl,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _placeholder() => Container(
    color: Colors.grey[800],
    child: const Center(
      child: Icon(Icons.image_not_supported, color: Colors.white54, size: 40),
    ),
  );

  Future<_MovieDetailData> _fetchDetailData() async {
    final movie = await ApiService.fetchMovieDetail(movieId);
    final similar = await ApiService.fetchSimilarMovies(movieId);
    return _MovieDetailData(movie: movie, similar: similar);
  }
}

class _MovieDetailData {
  final Movie movie;
  final List<Movie> similar;
  _MovieDetailData({required this.movie, required this.similar});
}
