import 'dart:convert';

import 'package:flutter_demo/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular {
  final url =
      'https://api.themoviedb.org/3/movie/popular?api_key=%3CYOUR_TOKEN%3E&language=es-MX&page=1';

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
}
