import 'dart:io';
import 'package:flutter_demo/models/favorite_movies_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteMoviesDatabaseHelper {
  static final nombreBDMovies = 'Movies';
  static final versionBDMovies = 1;

  static Database? _databaseMovies;

  Future<Database> get database async {
    if (_databaseMovies != null) return _databaseMovies!;
    return _databaseMovies = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nombreBDMovies);
    return await openDatabase(
      pathBD,
      version: versionBDMovies,
      onCreate: _createTable,
    );
  }

  _createTable(Database db, int version) async {
    String query = "CREATE TABLE tblMovie (idMovie INTEGER PRIMARY KEY)";
    await db.execute(query);
  }

  Future<int> INSERTAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion.insert(table, map);
  }

  Future<int> ELIMINAR(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'idMovie = ?', whereArgs: [id]);
  }

  Future<List<int>> GETALLMOVIES() async {
    var conexion = await database;
    var result = await conexion.query('tblMovie');
    return result.map((row) => row['idMovie'] as int).toList();
  }
}
