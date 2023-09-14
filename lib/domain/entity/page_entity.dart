class PageEntity<T> {
  final List<T> items;
  final int? total;
  final int? status;

  PageEntity({
    required this.items,
    this.total,
    this.status,
  });
}
