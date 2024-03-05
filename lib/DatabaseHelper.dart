// database_helper.dart
import 'package:imcflutter/imc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'imc_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE imc (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            altura REAL,
            peso REAL,
            imc REAL
          )
        ''');
      },
    );
  }

  Future<int> inserirIMC(IMC imc) async {
    final db = await database;
    return await db.insert('imc', imc.toMap());
  }

  Future<List<IMC>> buscarTodosIMC() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('imc');

    return List.generate(maps.length, (i) {
      return IMC.fromMap(maps[i]);
    });
  }
}
