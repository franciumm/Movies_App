import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const Map<String, String> _headers = {
    'Authorization':
    'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNWZlMjkyMzhhNmYyZWUyZmMwMGY5ZmM3N2E0MjM1NCIsIm5iZiI6MTY3NDA0NTgzNS4wNDksInN1YiI6IjYzYzdlOThiN2E5N2FiMDA4YWM5ZTc3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2Re733SfH_B7YZFbCXa2yjU9DdjOqlcrCpabyFvhCCA',
    'accept': 'application/json',
  };

  /// Fetches a list of popular movies (page 1 by default)
  static Future<List<Movie>> fetchPopular({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/movie/popular?language=en-US&page=$page');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      return results.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }




  static Future<List<Movie>> fetchRecommended({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/movie/top_rated?language=en-US&page=$page');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      return results.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load recommended movies');
    }
  }
  /// Fetches the most recently added movie
  static Future<Movie> fetchLatest() async {
    final uri = Uri.parse('$_baseUrl/movie/latest?language=en-US');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      return Movie.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load latest movie');
    }
  }
}
