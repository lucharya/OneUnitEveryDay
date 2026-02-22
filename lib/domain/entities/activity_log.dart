/// Domain entity representing a single completion log for an activity on a given date
class ActivityLog {
  final int? id;
  final int activityId;
  final String date; // YYYY-MM-DD
  final DateTime createdAt;

  const ActivityLog({
    this.id,
    required this.activityId,
    required this.date,
    required this.createdAt,
  });

  ActivityLog copyWith({
    int? id,
    int? activityId,
    String? date,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityLog &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ActivityLog(id: $id, activityId: $activityId, date: $date)';
}
