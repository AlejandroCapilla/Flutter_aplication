import 'dart:io';
import 'package:flutter_demo/models/events_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EventsDatabaseHelper {
  static final nombreBDEvents = 'EVENTS';
  static final versionBDEvents = 1;

  static Database? _databaseEvents;

  Future<Database> get database async {
    if (_databaseEvents != null) return _databaseEvents!;
    return _databaseEvents = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nombreBDEvents);
    return await openDatabase(
      pathBD,
      version: versionBDEvents,
      onCreate: _createTable,
    );
  }

  _createTable(Database db, int version) async {
    print("Events: Metodo _createTable ejecutado");
    String query =
        "CREATE TABLE tblEvento (idEvento INTEGER PRIMARY KEY, dscEvento VARCHAR(200), fechaEvento DATE, completado BOOLEAN)";
    await db.execute(query);
  }

  Future<int> INSERTAR(String table, Map<String, dynamic> map) async {
    print("Events: Metodo INSERTAR ejecutado");
    var conexion = await database;
    return await conexion.insert(table, map);
  }

  Future<int> ACTUALIZAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion.update(table, map,
        where: 'idEvento = ?', whereArgs: map[map['idEvento']]);
  }

  Future<int> ELIMINAR(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'idPost = ?', whereArgs: [id]);
  }

  Future<List<EventModel>> GETALLEVENTS() async {
    var conexion = await database;
    var result = await conexion.query('tblEvento');
    print("Events: Metodo GETALLEVENTS ejecutado");
    return result.map((evento) => EventModel.fromMap(evento)).toList();
  }

  Future<List<EventModel>> getEventsForDay(String fecha) async {
    var conexion = await database;
    var query = "SELECT * FROM tblEvento where fechaEvento=?";
    var result = await conexion.rawQuery(query, [fecha]);
    List<EventModel> eventos = [];
    if (result.isNotEmpty) {
      eventos = result.map((evento) => EventModel.fromMap(evento)).toList();
    }
    return eventos;
  }
}
