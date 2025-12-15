import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/custom_movie.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    // Sesuaikan skema dengan model CustomMovie yang baru
    await db.execute('''
    CREATE TABLE $tableMovies (
      ${MovieFields.id} $idType,
      ${MovieFields.title} $textType,
      ${MovieFields.director} $textType,
      ${MovieFields.year} $integerType,
      ${MovieFields.posterUrl} $textType,
      ${MovieFields.isFavorite} $integerType
    )
    ''');
  }

  Future<CustomMovie> createMovie(CustomMovie movie) async {
    final db = await instance.database;
    // Gunakan method copyWith, bukan copy
    final id = await db.insert(tableMovies, movie.toJson());
    return movie.copyWith(id: id);
  }

  Future<CustomMovie> readMovie(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableMovies,
      columns: MovieFields.values,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CustomMovie.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<CustomMovie>> readAllMovies() async {
    final db = await instance.database;
    final result = await db.query(tableMovies, orderBy: '${MovieFields.id} ASC');
    return result.map((json) => CustomMovie.fromJson(json)).toList();
  }

  Future<int> updateMovie(CustomMovie movie) async {
    final db = await instance.database;
    return db.update(
      tableMovies,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableMovies,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

