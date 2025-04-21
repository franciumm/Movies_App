import 'dart:convert';

/// A single movie entry from TMDB, used for both list and detail endpoints.
class Movie {
  /// Whether the movie is adult-rated
  final bool adult;

  /// Path to backdrop image
  final String backdropPath;

  /// Genre IDs (either from `genre_ids` list or `genres` array)
  final List<int> genreIds;

  /// TMDB movie identifier
  final int id;

  /// Original language code
  final String originalLanguage;

  /// Original title text
  final String originalTitle;

  /// Movie overview / summary
  final String overview;

  /// Popularity score
  final double popularity;

  /// Path to poster image
  final String posterPath;

  /// Release date (yyyy-MM-dd)
  final String releaseDate;

  /// Localized title
  final String title;

  /// Whether there's an associated video
  final bool video;

  /// Average vote score
  final double voteAverage;

  /// Total vote count
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Creates a [Movie] from a JSON map.
  ///
  /// Handles both `genre_ids: [int]` and `genres: [ { id, name } ]` formats,
  /// and provides sensible defaults for missing fields.
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Parse genres
    List<int> ids;
    if (json['genre_ids'] != null) {
      ids = List<int>.from(json['genre_ids'] as List<dynamic>);
    } else if (json['genres'] != null) {
      ids = (json['genres'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((g) => g['id'] as int)
          .toList();
    } else {
      ids = [];
    }

    return Movie(
      adult: json['adult'] as bool? ?? false,
      backdropPath: json['backdrop_path'] as String? ?? '',
      genreIds: ids,
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String? ?? '',
      originalTitle: json['original_title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      title: json['title'] as String? ?? '',
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
    );
  }

  String get fullPosterUrl =>
      posterPath.isNotEmpty ? 'https://image.tmdb.org/t/p/w500$posterPath' : '';

  String get fullBackdropUrl =>
      backdropPath.isNotEmpty ? 'https://image.tmdb.org/t/p/w780$backdropPath' : '';

  static Movie fromRawJson(String str) =>
      Movie.fromJson(json.decode(str) as Map<String, dynamic>);

  /// Encodes this [Movie] instance as a JSON string.
  String toRawJson() => json.encode(toJson());

  /// Converts this [Movie] into a JSON-serializable map.
  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_ids': genreIds,
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };
}
