import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/popular_response.dart';

class ApiService {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const Map<String, String> _headers = {
    'Authorization':
    'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNWZlMjkyMzhhNmYyZWUyZmMwMGY5ZmM3N2E0MjM1NCIsIm5iZiI6MTY3NDA0NTgzNS4wNDksInN1YiI6IjYzYzdlOThiN2E5N2FiMDA4YWM5ZTc3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2Re733SfH_B7YZFbCXa2yjU9DdjOqlcrCpabyFvhCCA',
    'accept': 'application/json',
  };

  /// Fetch page [page] of popular movies.
  static Future<PopularResponse> fetchPopular({int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/popular?language=en-US&page=$page',
    );
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      return PopularResponse.fromJson(jsonMap);
    } else {
      throw http.ClientException(
        'Failed to load popular movies',
        uri,
      );
    }
  }
}
