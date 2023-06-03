import 'dart:convert';

import 'package:flutter_demo/models/actor_model.dart';
import 'package:flutter_demo/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular {
  final url =
      'https://api.themoviedb.org/3/movie/popular?api_key=25e54d8eb5bd343a889f3772cf2117b8&language=es-MX&page=1';

  Future<List<PopularModel>?> getAllPopular() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular =
          popular.map((video) => PopularModel.fromMap(video)).toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<List<PopularModel>?> getFavoriteMovies(List<int> movieIds) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      var listPopular = popular
          .map((video) => PopularModel.fromMap(video))
          .where((pop) => movieIds.contains(pop.id))
          .toList();
      return listPopular;
    } else {
      return null;
    }
  }

  Future<String> getIdVideo(int id_popular) async {
    Uri auxVideo = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id_popular/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(auxVideo);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      print(listJSON[0]['key']);
      return listJSON[0]['key'];
    }
    return '';
  }

  Future<List<ActorModel>?> getAllAuthors(PopularModel popularModel) async {
    Uri auxActores = Uri.parse(
        'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=d7236b730825fb7b3c7e23e7d91e473c');
    var result = await http.get(auxActores);
    var listJSON = jsonDecode(result.body)['cast'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}
