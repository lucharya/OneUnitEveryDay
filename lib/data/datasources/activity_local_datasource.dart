import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../models/activity_model.dart';

/// Local data source for activities using SQLite
class ActivityLocalDataSource {
  final DatabaseHelper _dbHelper;

  ActivityLocalDataSource({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<Database> get _db => _dbHelper.database;

  /// Get all activities ordered by creation date (newest first)
  Future<List<ActivityModel>> getAll() async {
    final db = await _db;
    final maps = await db.query(
      'activities',
      orderBy: 'created_at DESC',
    );
    return maps.map(ActivityModel.fromMap).toList();
  }

  /// Get a single activity by id
  Future<ActivityModel?> getById(int id) async {
    final db = await _db;
    final maps = await db.query(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return ActivityModel.fromMap(maps.first);
  }

  /// Insert a new activity, returns the id
  Future<int> insert(ActivityModel model) async {
    final db = await _db;
    return await db.insert('activities', model.toMap());
  }

  /// Update an existing activity
  Future<void> update(ActivityModel model) async {
    final db = await _db;
    await db.update(
      'activities',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  /// Delete an activity by id
  Future<void> delete(int id) async {
    final db = await _db;
    await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
