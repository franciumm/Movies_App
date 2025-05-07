import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import '../../../services/api_services.dart';
import '../../../shared/components/film_item.dart';
import '../../../shared/styles/colors.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key? key}) : super(key: key);

  static const int _itemsPerRow = 3;
  static const double _horizontalPadding = 16.0;
  static const double _minItemWidth = 100.0;
  static const double _maxItemWidth = 140.0;
  static const double _aspectRatio = 2 / 3;

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  final ScrollController _scrollCtrl = ScrollController();
  final List<Movie> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;


  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    try {
      final newMovies = await ApiService.fetchRecommended(page: _currentPage);
      setState(() {
        if (newMovies.isEmpty) {
          _hasMore = false;
        } else {
          _movies.addAll(newMovies);
          _currentPage++;
        }
      });
    } catch (e) {
      // Optionally handle error
      _hasMore = false;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 70 &&
          !_isLoading && _hasMore) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(builder: (ctx, constraints) {
        final totalGaps = (Recommended._itemsPerRow + 1) *
            Recommended._horizontalPadding;
        double itemWidth =
            (constraints.maxWidth - totalGaps) / Recommended._itemsPerRow;
        itemWidth = itemWidth.clamp(
            Recommended._minItemWidth, Recommended._maxItemWidth);
        final itemHeight = itemWidth / Recommended._aspectRatio;
        final cardHeight =
            itemHeight * 1.3 + FilmItem.infoHeight(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Recommended._horizontalPadding),
              child: Text(
                'Recommended',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: cardHeight,
              child: ListView.separated(
                controller: _scrollCtrl,
                padding: const EdgeInsets.symmetric(
                    horizontal: Recommended._horizontalPadding),
                scrollDirection: Axis.horizontal,
                itemCount: _movies.length + (_hasMore ? 1 : 0),
                separatorBuilder: (_, __) =>
                const SizedBox(width: Recommended._horizontalPadding),
                itemBuilder: (_, i) {
                  if (i < _movies.length) {
                    final m = _movies[i];
                    return FilmItem(
                      title: m.title,
                      time: m.releaseDate,
                      movieId: m.id,
                      rate: m.voteAverage,
                      showInfo: true,
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: m.fullPosterUrl,
                      initialInWatchlist: false,
                    );
                  } else {
                    // loading indicator at end
                    return SizedBox(
                      width: itemWidth,
                      child: const Center(
                          child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}