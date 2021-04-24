import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final Function ontap;
  final String urlBase = 'https://image.tmdb.org/t/p/w220_and_h330_face/';
  const MovieCard({
    Key key,
    this.posterPath,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  '$urlBase$posterPath',
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
