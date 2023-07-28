// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../models/movie_model.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackground(context, movie),
          _buildMovieInformation(context),
          _buildButtons(context)
        ],
      ),
    );
  }

  //? builder dos botões
  Positioned _buildButtons(BuildContext context) {
    return Positioned(
      bottom: 10,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* botão 1
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Color(0xFFFF7272),
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.425, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {},
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Add to ',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Watchlist')
                    ]),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            //* botão 2
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.white,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 0.425, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => _MoviePlayer(movie: movie)));
              },
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Start ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'Watching')
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  //? builder das informações
  Positioned _buildMovieInformation(BuildContext context) {
    return Positioned(
      bottom: 90,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //* informações
            Text(
              movie.nome,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${movie.ano} | '
              '${movie.categoria} | '
              '${movie.duration.inHours}h '
              '${movie.duration.inMinutes.remainder(60)}m',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            //* estrelas
            RatingBar.builder(
              initialRating: 3.5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemSize: 23,
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              unratedColor: Colors.white,
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: (rating) {},
            ),
            SizedBox(
              height: 20,
            ),
            //* lorem ipsum
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
              maxLines: 8,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(height: 1.75, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  //? builder da tela
  List<Widget> _buildBackground(context, movie) {
    return [
      Container(
        height: double.infinity,
        color: const Color(0xFF000B49),
      ),
      Image.asset(
        movie.imagem,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        fit: BoxFit.cover,
      ),
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Color(0xFF000B49)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.5])),
        ),
      )
    ];
  }
}

//? video player
class _MoviePlayer extends StatefulWidget {
  const _MoviePlayer({required this.movie});

  final Movie movie;

  @override
  State<_MoviePlayer> createState() => __MoviePlayerState();
}

class __MoviePlayerState extends State<_MoviePlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.asset(widget.movie.trailer)
    ..initialize().then((value) {
      chewieController.play();
      setState(() {});
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9
    );

  }

  @override
   void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}