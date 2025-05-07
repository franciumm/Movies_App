
import 'package:flutter/material.dart';
import '../../models/Genre.dart';
import '../../models/movie.dart';
import '../../services/api_services.dart';
import '../../shared/components/film_item.dart';

class CategoryMoviesScreen extends StatefulWidget {
  final Genre genre;
  const CategoryMoviesScreen({required this.genre, Key? key}) : super(key: key);

  @override
  State<CategoryMoviesScreen> createState() => _CategoryMoviesScreenState();
}

class _CategoryMoviesScreenState extends State<CategoryMoviesScreen> {
  final ScrollController _ctrl = ScrollController();
  final List<Movie> _movies = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  static const int _threshold = 200; // px from bottom to trigger load

  @override
  void initState() {
    super.initState();
    _loadPage();
    _ctrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onScroll);
    _ctrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_ctrl.hasClients || _isLoading || !_hasMore) return;
    final max = _ctrl.position.maxScrollExtent;
    final cur = _ctrl.position.pixels;
    if (max - cur <= _threshold) {
      _loadPage();
    }
  }

  Future<void> _loadPage() async {
    setState(() => _isLoading = true);
    try {
      final newBatch = await ApiService.discoverByGenre(widget.genre.id, page: _page);
      if (newBatch.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
        _movies.addAll(newBatch);
      }
    } catch (e) {
      // you might want to show a SnackBar on error
      _hasMore = false;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.grey[900];
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(foregroundColor: Colors.white,
        title: Text(widget.genre.name),
        backgroundColor: bg,
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          const cols = 2;
          const gap = 12.0;
          final totalGap = gap * (cols + 1);
          final itemW = (constraints.maxWidth - totalGap) / cols;
          final posterH = itemW / (2 / 3);
          final cardH = posterH * 1.3 + FilmItem.infoHeight(ctx);
          final aspect = itemW / cardH;

          return GridView.builder(
            controller: _ctrl,
            padding: const EdgeInsets.all(gap),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: gap,
              mainAxisSpacing: gap,
              childAspectRatio: aspect,
            ),
            itemCount: _movies.length + (_hasMore ? 1 : 0),
            itemBuilder: (_, i) {
              if (i < _movies.length) {
                final m = _movies[i];
                return FilmItem(
                  movieId: m.id,
                  title: m.title,
                  time: m.releaseDate,
                  rate: m.voteAverage,
                  showInfo: true,
                  width: itemW,
                  height: posterH,
                  imageUrl: m.fullPosterUrl,
                  initialInWatchlist: false,
                );
              }
              // loading indicator at the end
              return Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
