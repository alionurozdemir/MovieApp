import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService(Dio());
});

class MovieService {
  final Dio _dio;
  MovieService(
    this._dio,
  );

  Future<List<Movie>> getMovies() async {
    final response = await _dio.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=339063300efae86aa888022759844c3c&language=en-US&page=1");

    final results = List<Map<String, dynamic>>.from(response.data['results']);

    List<Movie> movies =
        results.map((movieData) => Movie.fromMap(movieData)).toList(growable: false);

    return movies;
  }
}
