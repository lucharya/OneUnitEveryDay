import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../models/activity_log_model.dart';

/// Local data source for activity logs using SQLite
class ActivityLogLocalDataSource {
  final DatabaseHelper _dbHelper;

  ActivityLogLocalDataSource({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<Database> get _db => _dbHelper.database;

  /// Get all logs for a given activity, ordered by date descending
  Future<List<ActivityLogModel>> getByActivityId(int activityId) async {
    final db = await _db;
    final maps = await db.query(
      'activity_logs',
      where: 'activity_id = ?',
      whereArgs: [activityId],
      orderBy: 'date DESC',
    );
    return maps.map(ActivityLogModel.fromMap).toList();
  }

  /// Get a specific log by activity and date
  Future<ActivityLogModel?> getByActivityAndDate(
    int activityId,
    String date,
  ) async {
    final db = await _db;
    final maps = await db.query(
      'activity_logs',
      where: 'activity_id = ? AND date = ?',
      whereArgs: [activityId, date],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return ActivityLogModel.fromMap(maps.first);
  }

  /// Get logs within a date range for an activity
  Future<List<ActivityLogModel>> getByActivityAndDateRange(
    int activityId,
    String startDate,
    String endDate,
  ) async {
    final db = await _db;
    final maps = await db.query(
      'activity_logs',
      where: 'activity_id = ? AND date >= ? AND date <= ?',
      whereArgs: [activityId, startDate, endDate],
      orderBy: 'date DESC',
    );
    return maps.map(ActivityLogModel.fromMap).toList();
  }

  /// Insert a new log entry, returns the id
  Future<int> insert(ActivityLogModel model) async {
    final db = await _db;
    return await db.insert(
      'activity_logs',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  /// Check if a log exists for the given activity and date
  Future<bool> existsForDate(int activityId, String date) async {
    final db = await _db;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM activity_logs WHERE activity_id = ? AND date = ?',
      [activityId, date],
    );
    final count = Sqflite.firstIntValue(result) ?? 0;
    return count > 0;
  }

  /// Delete a log for a specific activity and date
  Future<int> deleteByActivityAndDate(int activityId, String date) async {
    final db = await _db;
    return await db.delete(
      'activity_logs',
      where: 'activity_id = ? AND date = ?',
      whereArgs: [activityId, date],
    );
  }

  /// Delete all logs for a given activity
  Future<void> deleteByActivityId(int activityId) async {
    final db = await _db;
    await db.delete(
      'activity_logs',
      where: 'activity_id = ?',
      whereArgs: [activityId],
    );
  }
}
