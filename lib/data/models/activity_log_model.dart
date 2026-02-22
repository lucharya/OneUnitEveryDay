import '../../domain/entities/activity_log.dart';

/// Data model for ActivityLog - handles SQLite serialization
class ActivityLogModel {
  final int? id;
  final int activityId;
  final String date;
  final String createdAt;

  const ActivityLogModel({
    this.id,
    required this.activityId,
    required this.date,
    required this.createdAt,
  });

  /// Create from SQLite map
  factory ActivityLogModel.fromMap(Map<String, dynamic> map) {
    return ActivityLogModel(
      id: map['id'] as int?,
      activityId: map['activity_id'] as int,
      date: map['date'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  /// Convert to SQLite map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'activity_id': activityId,
      'date': date,
      'created_at': createdAt,
    };
  }

  /// Create from domain entity
  factory ActivityLogModel.fromEntity(ActivityLog entity) {
    return ActivityLogModel(
      id: entity.id,
      activityId: entity.activityId,
      date: entity.date,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }

  /// Convert to domain entity
  ActivityLog toEntity() {
    return ActivityLog(
      id: id,
      activityId: activityId,
      date: date,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
