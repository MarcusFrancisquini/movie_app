// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../widgets/movie_item.dart';
import 'movie_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Movie.movies;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Center(
              child: Text(
                'Explore',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* texto inicial
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: 'Featured ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      )
                    ),
                    TextSpan(
                      text: 'Movies'
                    )
                  ]
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //* filmes
              for (final movie in movies) InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieScreen(movie: movie)
                    )
                  );
                },
                child: MovieListItem(
                  cover: movie.imagem,
                  name: movie.nome,
                  info: '${movie.ano} | ' '${movie.categoria} | ' '${movie.duration.inHours}h ' '${movie.duration.inMinutes.remainder(60)}m'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//? AppBar customizada
class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}