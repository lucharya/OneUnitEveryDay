import '../../domain/entities/activity.dart';
import '../../domain/entities/activity_type.dart';

/// Data model for Activity - handles SQLite serialization
class ActivityModel {
  final int? id;
  final String name;
  final String? description;
  final String type;
  final String createdAt;

  const ActivityModel({
    this.id,
    required this.name,
    this.description,
    required this.type,
    required this.createdAt,
  });

  /// Create from SQLite map
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String?,
      type: map['type'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  /// Convert to SQLite map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'type': type,
      'created_at': createdAt,
    };
  }

  /// Create from domain entity
  factory ActivityModel.fromEntity(Activity entity) {
    return ActivityModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      type: entity.type.toStorageString(),
      createdAt: entity.createdAt.toIso8601String(),
    );
  }

  /// Convert to domain entity
  Activity toEntity() {
    return Activity(
      id: id,
      name: name,
      description: description,
      type: ActivityType.fromStorageString(type),
      createdAt: DateTime.parse(createdAt),
    );
  }
}
