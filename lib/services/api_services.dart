import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Genre.dart';
import '../models/movie.dart';

class ApiService {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const Map<String, String> _headers = {
    'Authorization':
    'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNWZlMjkyMzhhNmYyZWUyZmMwMGY5ZmM3N2E0MjM1NCIsIm5iZiI6MTY3NDA0NTgzNS4wNDksInN1YiI6IjYzYzdlOThiN2E5N2FiMDA4YWM5ZTc3NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2Re733SfH_B7YZFbCXa2yjU9DdjOqlcrCpabyFvhCCA',
    'accept': 'application/json',
  };

  static Future<List<Movie>> fetchLatest({int page = 1}) async {
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

  static Future<Movie> fetchPopular() async {
    final uri = Uri.parse('$_baseUrl/movie/latest?language=en-US');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      return Movie.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load latest movie');
    }
  }



  static Future<Movie> fetchMovieDetail(int movieId) async {
    final uri = Uri.parse('$_baseUrl/movie/$movieId?language=en-US');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      return Movie.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load movie details');
    }
  }


  static Future<List<Movie>> fetchSimilarMovies(int movieId, {int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/movie/$movieId/similar?language=en-US&page=$page');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      return results.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  static Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/search/movie?language=en-US&query=${Uri.encodeComponent(query)}&page=$page&include_adult=false',
    );
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      return results
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to search movies (${res.statusCode})');
    }
  }
  static Future<List<Genre>> fetchGenres() async {
    final uri = Uri.parse('$_baseUrl/genre/movie/list?language=en-US');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final gs = (jsonMap['genres'] as List)
          .map((g) => Genre.fromJson(g as Map<String, dynamic>))
          .toList();
      return gs;
    }
    throw Exception('Failed to load genres');
  }
  static Future<List<Movie>> discoverByGenre(int genreId, {int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/discover/movie?language=en-US&with_genres=$genreId&page=$page',
    );
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final jsonMap = json.decode(res.body) as Map<String, dynamic>;
      final results = jsonMap['results'] as List<dynamic>;
      return results
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to discover movies');
  }


}

