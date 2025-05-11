import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _db;

  DBHelper._init();

  Future<Database> get database async {
    if (_db != null) return _db!;

    // location on device
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'watchlist.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // simple table with one column: the movie ID
        await db.execute('''
          CREATE TABLE watchlist (
            id INTEGER PRIMARY KEY
          )
        ''');
      },
    );
    return _db!;
  }
}
