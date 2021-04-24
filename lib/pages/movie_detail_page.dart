import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movies/components/centered_message.dart';
import 'package:movies/components/centered_progress.dart';
import 'package:movies/components/chip_date.dart';
import 'package:movies/components/rate.dart';
import 'package:movies/controllers/movie_detail_controller.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovieById(widget.movieId);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller.movieDetail?.title ?? ''),
    );
  }

  _buildMovieDetail() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }

    return ListView(
      children: [
        _buildCover(),
        _buildStatus(),
        _buildOverview(),
        _buildDetails(),
        _buildOficialPage()
      ],
    );
  }

  _buildOverview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        "Sinopse: " + _controller.movieDetail.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  _buildDetails() {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: RichText(
          text: TextSpan(
              text: 'See on IMDB',
              style: TextStyle(color: Colors.red),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  var url = 'https://www.imdb.com/title/' +
                      _controller.movieDetail.imdbId;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Não existe esse site: ' +
                        _controller.movieDetail.homepage +
                        '!';
                  }
                }),
        ));
  }

  _buildOficialPage() {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: RichText(
          text: TextSpan(
              text: 'Oficial Page',
              style: TextStyle(color: Colors.red),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  var url = _controller.movieDetail.homepage;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Não existe esse site: ' +
                        _controller.movieDetail.homepage +
                        '!';
                  }
                }),
        ));
  }

  _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Rate(_controller.movieDetail.voteAverage),
          ChipDate(date: _controller.movieDetail.releaseDate),
        ],
      ),
    );
  }

  _buildCover() {
    return Image.network(
      'https://image.tmdb.org/t/p/w500${_controller.movieDetail.backdropPath}',
    );
  }
}
