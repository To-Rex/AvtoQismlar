class Category {
  final String Id;
  final String Name;
  final String Sort;
  final String Picture;
  final String Active;

  Category({
    required this.Id,
    required this.Name,
    required this.Sort,
    required this.Picture,
    required this.Active,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      Id: json['id'],
      Name: json['name'],
      Sort: json['sort'],
      Picture: json['picture'],
      Active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'name': Name,
      'sort': Sort,
      'picture': Picture,
      'active': Active,
    };
  }

  @override
  String toString() {
    return 'Category{Id: $Id, Name: $Name, Sort: $Sort, Picture: $Picture, Active: $Active}';
  }

  Category copyWith({
    String? Id,
    String? Name,
    String? Sort,
    String? Picture,
    String? Active,
  }) {
    return Category(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      Sort: Sort ?? this.Sort,
      Picture: Picture ?? this.Picture,
      Active: Active ?? this.Active,
    );
  }
}
