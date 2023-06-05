import 'dart:convert';
import 'package:flutter_demo/models/deezer_model.dart';
import 'package:http/http.dart' as http;

class ApiDeezer {
  Future<List<DeezerModel>?> getAllDeezer(String search) async {
    final response =
        await http.get(Uri.parse("https://api.deezer.com/search?q=$search"));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['data'] as List;
      var listDeezer =
          popular.map((video) => DeezerModel.fromMap(video)).toList();
      return listDeezer;
    } else {
      return null;
    }
  }
}
