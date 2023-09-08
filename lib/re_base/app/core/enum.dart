extension EnumExt on Enum {
  static Enum? enumFromString(String? key, Iterable<Enum> values) =>
      values.firstWhere((v) => key == v.name);
}
