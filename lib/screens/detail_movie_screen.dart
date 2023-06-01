import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_demo/database/favorites_movie_helper.dart';
import 'package:flutter_demo/models/actor_model.dart';
import 'package:flutter_demo/models/favorite_movies_model.dart';
import 'package:flutter_demo/models/popular_model.dart';
import 'package:flutter_demo/network/api_popular.dart';
import 'package:flutter_demo/widgets/card_actor.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen>
    with TickerProviderStateMixin {
  FavoriteMoviesDatabaseHelper? favoriteMovie;
  PopularModel? popularModel;
  ApiPopular apiPopular = ApiPopular();
  List<int> listFavorites = [];

  @override
  void initState() {
    super.initState();
    favoriteMovie = FavoriteMoviesDatabaseHelper();
    obtenerListaDesdeBaseDeDatos();
  }

  Future<void> obtenerListaDesdeBaseDeDatos() async {
    List<int> listaDesdeBD = await favoriteMovie!
        .GETALLMOVIES(); // Método que obtiene la lista desde la base de datos
    setState(() {
      listFavorites = listaDesdeBD;
    });
  }

  // Animacion de opacidad disminuyendo de la imagen de fondo
  late final AnimationController _controllerBackground = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animationBackground =
      Tween(begin: 1.0, end: 0.2).animate(_controllerBackground);

  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animationText =
      Tween(begin: 0.0, end: 1.0).animate(_controllerText);

  final spaceHorizontal = const SizedBox(
    height: 15,
  );

  final spaceVertical = const SizedBox(
    width: 15,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerBackground.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      popularModel = ModalRoute.of(context)!.settings.arguments as PopularModel;

      double vote = double.parse(popularModel!.voteAverage.toString());

      int idApi = popularModel!.id!;
      print('favorite   idApi: $idApi');

      for (var i = 0; i < listFavorites.length; i++) {
        int? id = listFavorites[i];
        print('favorite   idFav: $id');
      }

      bool esFavorita = listFavorites.contains(idApi);

      Icon star1;
      Icon star2;
      Icon star3;
      Icon star4;
      Icon star5;

      if (vote >= 0.5) {
        if (vote >= 1.5) {
          star1 = const Icon(Icons.star, color: Colors.white70);
        } else {
          star1 = const Icon(Icons.star_half, color: Colors.white70);
        }
      } else {
        star1 = const Icon(Icons.star_border, color: Colors.white70);
      }
      if (vote >= 2.5) {
        if (vote >= 3.5) {
          star2 = const Icon(Icons.star, color: Colors.white70);
        } else {
          star2 = const Icon(Icons.star_half, color: Colors.white70);
        }
      } else {
        star2 = const Icon(Icons.star_border, color: Colors.white70);
      }
      if (vote >= 4.5) {
        if (vote >= 5.5) {
          star3 = const Icon(Icons.star, color: Colors.white70);
        } else {
          star3 = const Icon(Icons.star_half, color: Colors.white70);
        }
      } else {
        star3 = const Icon(Icons.star_border, color: Colors.white70);
      }
      if (vote >= 6.5) {
        if (vote >= 7.5) {
          star4 = const Icon(Icons.star, color: Colors.white70);
        } else {
          star4 = const Icon(Icons.star_half, color: Colors.white70);
        }
      } else {
        star4 = const Icon(Icons.star_border, color: Colors.white70);
      }
      if (vote >= 8.5) {
        if (vote >= 9.5) {
          star5 = const Icon(Icons.star, color: Colors.white70);
        } else {
          star5 = const Icon(Icons.star_half, color: Colors.white70);
        }
      } else {
        star5 = const Icon(Icons.star_border, color: Colors.white70);
      }

      return SafeArea(
        child: Column(
          children: [
            FadeTransition(
              opacity: _animationText,
              child: FutureBuilder(
                  future: apiPopular.getIdVideo(popularModel!.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: snapshot.data.toString(),
                          flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: true,
                              controlsVisibleAtStart: true),
                        ),
                        showVideoProgressIndicator: true,
                      );
                    } else {
                      return const SizedBox(
                          height: 203,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }),
            ),
            Expanded(
              child: Stack(
                children: [
                  const Scaffold(
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Hero(
                    tag: popularModel!.id.toString(),
                    child: FadeTransition(
                      opacity: _animationBackground,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                opacity: 1,
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${popularModel!.posterPath}'))),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      spaceVertical,
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(
                                      esFavorita
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.pink,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      if (esFavorita) {
                                        favoriteMovie!.ELIMINAR(
                                            'tblMovie', popularModel!.id!);
                                        listFavorites.remove(popularModel!.id);
                                      } else {
                                        favoriteMovie!.INSERTAR('tblMovie', {
                                          'idMovie': popularModel!.id,
                                        });
                                        listFavorites.add(popularModel!.id!);
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            FadeTransition(
                              opacity: _animationText,
                              child: Text(
                                popularModel!.title.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            spaceHorizontal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 22,
                                  child: star1,
                                ),
                                SizedBox(
                                  width: 22,
                                  child: star2,
                                ),
                                SizedBox(
                                  width: 22,
                                  child: star3,
                                ),
                                SizedBox(
                                  width: 22,
                                  child: star4,
                                ),
                                SizedBox(
                                  width: 22,
                                  child: star5,
                                ),
                              ],
                            ),
                            spaceHorizontal,
                            FadeTransition(
                              opacity: _animationText,
                              child: Text(
                                popularModel!.overview.toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            spaceHorizontal,
                            FutureBuilder<List<ActorModel>?>(
                              future: apiPopular.getAllAuthors(popularModel!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        ActorModel actor =
                                            snapshot.data![index];
                                        return ActorCard(
                                          name: actor.name.toString(),
                                          photoUrl:
                                              'https://image.tmdb.org/t/p/original${actor.profilePath}',
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
