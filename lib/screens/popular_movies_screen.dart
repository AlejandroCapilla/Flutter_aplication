import 'package:flutter/material.dart';
import 'package:flutter_demo/models/popular_model.dart';
import 'package:flutter_demo/network/api_popular.dart';
import '../widgets/item_popular_movie.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  ApiPopular? apiPopular;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
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
                    return ItemPopularMovie(
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
