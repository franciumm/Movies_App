

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/models/watchlist_model.dart';
import 'package:movies/services/api_services.dart';
import '../../models/movie.dart';
import '../../shared/components/MovieDetailDialog.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ids = context.watch<WatchlistModel>().movieIds;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('My Wishlist'),
      ),
      body: ids.isEmpty
          ? const Center(child: Text('Your wishlist is empty!'))
          : FutureBuilder<List<Movie>>(
        future: Future.wait(ids.map(ApiService.fetchMovieDetail)),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return const Center(child: Text('Failed to load wishlist.'));
          }
          final movies = snap.data!;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: movies.length,
            separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (ctx, i) {
              final m = movies[i];
              return _WishlistRow(movie: m);
            },
          );
        },
      ),
    );
  }
}

class _WishlistRow extends StatelessWidget {
  final Movie movie;
  const _WishlistRow({required this.movie});

  @override
  Widget build(BuildContext context) {
    const posterWidth = 100.0;
    final posterHeight = posterWidth / (2 / 3); // maintain 2:3 aspect
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movieId: movie.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: movie.posterPath != null
                  ? Image.network(
                'https://image.tmdb.org/t/p/w300${movie.posterPath}',
                width: posterWidth,
                height: posterHeight,
                fit: BoxFit.cover,
              )
                  : Container(
                width: posterWidth,
                height: posterHeight,
                color: Colors.grey[800],
                child: const Icon(Icons.image_not_supported,
                    color: Colors.white54, size: 40),
              ),
            ),

            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Overview snippet
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white54, height: 1.3),
                  ),
                ],
              ),
            ),

            // Remove button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () =>
                  context.read<WatchlistModel>().toggle(movie.id),
            ),
          ],
        ),
      ),
    );
  }
}
