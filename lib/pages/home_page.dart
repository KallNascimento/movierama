import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/components/centered_message.dart';
import 'package:movies/components/centered_progress.dart';
import 'package:movies/components/movie_card.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/pages/movie_detail_page.dart';

class Moviepage extends StatefulWidget {
  @override
  _MoviepageState createState() => _MoviepageState();
}

class _MoviepageState extends State<Moviepage> {
  final _controller = MovieController();
  final _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initialize();
  }

  _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (_controller.currentPage == lastPage) {
          lastPage++;
          await _controller.fetchAllMovies(page: lastPage);
          setState(() {});
        }
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });
    await _controller.fetchAllMovies(page: lastPage);
    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildMovieGrid(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: Text('Movierama'),
      actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _initialize)],
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return CenteredProgress();
    }
    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2.0),
      itemCount: _controller.moviesCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 0.65),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      ontap: () => _openDetailPage(movie.id),
    );
  }

  _openDetailPage(movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }
}
