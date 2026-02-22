import 'activity_type.dart';

/// Domain entity representing an activity that can be completed daily
class Activity {
  final int? id;
  final String name;
  final String? description;
  final ActivityType type;
  final DateTime createdAt;

  const Activity({
    this.id,
    required this.name,
    this.description,
    this.type = ActivityType.daily,
    required this.createdAt,
  });

  Activity copyWith({
    int? id,
    String? name,
    String? description,
    ActivityType? type,
    DateTime? createdAt,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Activity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Activity(id: $id, name: $name, type: $type)';
}
