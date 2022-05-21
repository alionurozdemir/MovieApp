import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/home/movie_box.dart';
import 'package:movie_app/movie.dart';
import 'package:movie_app/movie_service.dart';

final moviesFutureProvider = FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;
  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
  return movies;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Movies"),
      ),
      body: ref.watch(moviesFutureProvider).when(
            error: (e, s) {
              return Text(e.toString());
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            data: (movies) {
              return RefreshIndicator(
                onRefresh: () async {
                  return await ref.refresh(moviesFutureProvider);
                },
                child: GridView.extent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                  children: movies
                      .map((movie) => MovieBox(
                            title: movie.title,
                            image: movie.fullImageUrl,
                          ))
                      .toList(),
                ),
              );
            },
          ),
    );
  }
}
