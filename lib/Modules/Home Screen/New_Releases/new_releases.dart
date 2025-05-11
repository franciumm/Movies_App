import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/movie.dart';
import '../../../services/api_services.dart';
import '../../../shared/components/film_item.dart';
import '../../../shared/styles/colors.dart';

class newrles extends StatefulWidget {
  const newrles({Key? key}) : super(key: key);

  static const int itemsPerRow = 3;
  static const double horizontalPadding = 16.0;
  static const double minItemWidth = 100.0;
  static const double maxItemWidth = 140.0;
  static const double aspectRatio = 2 / 3;

  @override
  State<newrles> createState() => _newrlesState();
}

class _newrlesState extends State<newrles> {
  final ScrollController _scrollCtrl = ScrollController();
  final List<Movie> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    try {
      final next =
      await ApiService.fetchLatest(page: _currentPage);
      if (next.isEmpty) {
        _hasMore = false;
      } else {
        _movies.addAll(next);
        _currentPage++;
      }
    } catch (_) {
      _hasMore = false;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 70 &&
        !_isLoading &&
        _hasMore) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        const totalGaps =
            (newrles.itemsPerRow + 1) * newrles.horizontalPadding;
        double itemWidth =
            (constraints.maxWidth - totalGaps) / newrles.itemsPerRow;
        itemWidth = itemWidth
            .clamp(newrles.minItemWidth, newrles.maxItemWidth);
        final itemHeight = itemWidth / newrles.aspectRatio;
        final cardHeight =
            itemHeight * 0.9 + FilmItem.infoHeight(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: newrles.horizontalPadding),
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
              child: ListView.separated(
                controller: _scrollCtrl,
                padding: const EdgeInsets.only(
                    left: newrles.horizontalPadding),
                scrollDirection: Axis.horizontal,
                itemCount: _movies.length + (_hasMore ? 1 : 0),
                separatorBuilder: (_, __) =>
                const SizedBox(width: newrles.horizontalPadding),
                itemBuilder: (ctx, index) {
                  if (index < _movies.length) {
                    final m = _movies[index];
                    return FilmItem(
                      movieId: m.id,
                      title: m.title,
                      time: m.releaseDate,
                      rate: m.voteAverage,
                      showInfo: false,
                      width: itemWidth,
                      height: itemHeight,
                      imageUrl: m.fullPosterUrl,

                    );
                  }
                  return SizedBox(
                    width: itemWidth,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
