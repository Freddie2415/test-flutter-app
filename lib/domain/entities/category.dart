class Category {
  final int id;
  final String name;
  final int? adsCount;
  final String? icon;
  final List<Category>? children;

  Category({
    required this.id,
    required this.name,
    this.adsCount,
    this.icon,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<Category>? children;
    if (json['childs'] != null && json['childs'] is List) {
      children = (json['childs'] as List)
          .map((childJson) => Category.fromJson(childJson))
          .toList();
    }

    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      adsCount: json['ads_count'] as int?,
      icon: json['icon'] as String?,
      children: children,
    );
  }
}
