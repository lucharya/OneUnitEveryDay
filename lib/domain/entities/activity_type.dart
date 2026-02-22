/// Types of activities supported by the app
enum ActivityType {
  daily;

  /// Convert to string for database storage
  String toStorageString() => name;

  /// Create from string read from database
  static ActivityType fromStorageString(String value) {
    return ActivityType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ActivityType.daily,
    );
  }
}
