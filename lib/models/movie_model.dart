// ignore_for_file: prefer_const_constructors

class Movie{
  final String nome;
  final String imagem;
  final String trailer;
  final String categoria;
  final int ano;
  final Duration duration;

  Movie({
    required this.nome, 
    required this.imagem, 
    required this.trailer, 
    required this.categoria, 
    required this.ano, 
    required this.duration
  });

  //? lista de filmes
  static List<Movie> movies = [
    //* batman
    Movie(
      nome: 'The Batman', 
      imagem: 'assets/images/film1.jpg', 
      trailer: 'assets/videos/film1.mp4', 
      categoria: 'Adventure', 
      ano: 2022, 
      duration: Duration(hours: 2, minutes: 56)
    ),
    //* avatar
    Movie(
      nome: 'Avatar', 
      imagem: 'assets/images/film2.jpeg', 
      trailer: 'assets/videos/film2.mp4', 
      categoria: 'Science Fiction', 
      ano: 2009, 
      duration: Duration(hours: 2, minutes: 42)
    ),
    //* Avengers
    Movie(
      nome: 'Avengers: Endgame', 
      imagem: 'assets/images/film3.jpg', 
      trailer: 'assets/videos/film3.mp4', 
      categoria: 'Action', 
      ano: 2019, 
      duration: Duration(hours: 3, minutes: 02)
    ),
    //* Hobbit
    Movie(
      nome: 'The Hobbit', 
      imagem: 'assets/images/film4.jpg', 
      trailer: 'assets/videos/film4.mp4', 
      categoria: 'Fantasy', 
      ano: 2012, 
      duration: Duration(hours: 2, minutes: 49)
    ),
    //* American sniper
    Movie(
      nome: 'American Sniper', 
      imagem: 'assets/images/film5.jpg', 
      trailer: 'assets/videos/film5.mp4', 
      categoria: 'Biography', 
      ano: 2015, 
      duration: Duration(hours: 2, minutes: 12)
    ),
    //* homem aranha
    Movie(
      nome: 'The Amazing Spider-Man', 
      imagem: 'assets/images/film6.jpg', 
      trailer: 'assets/videos/film6.mp4', 
      categoria: 'Action', 
      ano: 2012, 
      duration: Duration(hours: 2, minutes: 17)
    ),
    //* doutor estranho
    Movie(
      nome: 'Doctor Strange', 
      imagem: 'assets/images/film7.jpg', 
      trailer: 'assets/videos/film7.mp4', 
      categoria: 'Fantasy', 
      ano: 2016, 
      duration: Duration(hours: 1, minutes: 55)
    ),
  ];

}

