import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../services/db.dart';

class WatchlistModel extends ChangeNotifier {
  final Set<int> _ids = {};
  late Database _db;
  bool _initialized = false;

  WatchlistModel() {
    _init();
  }

  Future<void> _init() async {
    _db = await DBHelper.instance.database;
    final rows = await _db.query('watchlist');
    _ids.addAll(rows.map((r) => r['id'] as int));
    _initialized = true;
    notifyListeners();
  }

  List<int> get movieIds => List.unmodifiable(_ids);
  bool contains(int id) => _ids.contains(id);

  Future<void> toggle(int id) async {
    if (!_initialized) return;

    if (_ids.contains(id)) {
      await _db.delete('watchlist', where: 'id = ?', whereArgs: [id]);
      _ids.remove(id);
    } else {
      await _db.insert('watchlist', {'id': id});
      _ids.add(id);
    }

    notifyListeners();
  }
}
