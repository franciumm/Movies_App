
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../services/api_services.dart';
import '../../models/Genre.dart';
import '../../shared/components/category_movies.dart';



class BrowseCategoriesScreen extends StatefulWidget {
  const BrowseCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<BrowseCategoriesScreen> createState() => _BrowseCategoriesScreenState();
}

class _BrowseCategoriesScreenState extends State<BrowseCategoriesScreen> {
  late Future<List<Genre>> _futureGenres;

  @override
  void initState() {
    super.initState();
    _futureGenres = ApiService.fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Browse Categories',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
      ),
      body: FutureBuilder<List<Genre>>(
        future: _futureGenres,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final genres = snap.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 16 / 9, // or tweak as you like
            ),
            itemCount: genres.length,
            itemBuilder: (_, i) {
              final g = genres[i];
              final asset = genreAssetMap[g.id] ?? 'lib/assets/Photos/default.jpeg';

              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryMoviesScreen(genre: g),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        asset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black45,
                      ),
                    ),
                    Center(
                      child: Text(
                        g.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
