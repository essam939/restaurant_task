enum LocalDataType {
  secured,
  local;

  static const defaultValue = LocalDataType.local;

  factory LocalDataType.fromString(String? name) {
    if (name == null || name == '') return defaultValue;

    return LocalDataType.values.firstWhere(
          (flavor) => flavor.name == name,
      orElse: () => defaultValue,
    );
  }
}