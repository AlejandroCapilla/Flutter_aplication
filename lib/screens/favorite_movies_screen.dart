import 'package:flutter/material.dart';
import 'package:flutter_demo/database/favorites_movie_helper.dart';
import 'package:flutter_demo/models/popular_model.dart';
import 'package:flutter_demo/network/api_popular.dart';
import 'package:flutter_demo/widgets/item_favorite_popular_movie.dart';
import 'package:flutter_demo/widgets/item_popular_movie.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  ApiPopular? apiPopular;
  FavoriteMoviesDatabaseHelper? favoriteMovie;
  List<int> listFavorites = [];
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
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

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < listFavorites.length; i++) {
      int? id = listFavorites[i];
      print('favorite   idFav: $id');
    }
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: apiPopular!.getFavoriteMovies(listFavorites),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            return GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8),
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return ItemFavoritePopularMovie(
                        popularModel: snapshot.data![index]);
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Algo salio mal'),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                itemCount: snapshot.data != null ? snapshot.data!.length : 0);
          },
        ),
      ),
    );
  }
}
