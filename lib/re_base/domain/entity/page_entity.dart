class PageEntity<T> {
  final List<T> items;
  final int? total;
  final int? statusCode;

  PageEntity({
    required this.items,
    this.total,
    this.statusCode,
  });
}
