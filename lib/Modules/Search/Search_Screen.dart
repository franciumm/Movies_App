import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../../services/api_services.dart';
import '../../shared/components/film_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();
  List<Movie> _results = [];
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _search(String q) async {
    if (q.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
      _results = [];
    });
    try {
      final movies = await ApiService.searchMovies(q.trim());
      setState(() => _results = movies);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.grey[900];
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: Theme.of(context).colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _ctrl,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: Theme.of(context).hintColor),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor),
              ),
              onSubmitted: _search,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
        child: Text('Error:\n$_error',
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.redAccent)),
      )
          : _results.isEmpty && _ctrl.text.isNotEmpty
          ? Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('lib/assets/Photos/Icon material-local-movies.png'),
          const SizedBox(height: 10),
          Text('No Results', style: Theme.of(context).textTheme.displayLarge),
        ]),
      )
          : LayoutBuilder(builder: (ctx, constraints) {
        const crossCount = 2, gap = 12.0;
        final totalGap = gap * (crossCount + 1);
        final itemW = (constraints.maxWidth - totalGap) / crossCount;
        final posterH = itemW / (2 / 3);
        final cardH = posterH * 1.3 + FilmItem.infoHeight(ctx);
        final aspect = itemW / cardH;

        return GridView.builder(
          padding: const EdgeInsets.all(gap),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            childAspectRatio: aspect,
          ),
          itemCount: _results.length,
          itemBuilder: (_, i) {
            final m = _results[i];
            return FilmItem(
              movieId: m.id,
              title: m.title,
              time: m.releaseDate,
              rate: m.voteAverage,
              showInfo: true,
              width: itemW,
              height: posterH,
              imageUrl: m.fullPosterUrl,
            );
          },
        );
      }),
    );
  }
}
