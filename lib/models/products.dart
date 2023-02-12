
class ProductClass {
  final String id;
  final String name;
  final String nameRu;
  final String code;
  final String productTypeId;
  final String countryId;
  final String brandId;
  final String measurement;
  final String price;
  final String sellPrice;
  final String discount;
  final String count;
  final String guarantee;
  final String picture;
  final String description;
  final String minCount;
  final String createdAt;
  final String updatedAt;
  final String country;
  final String countryRu;
  final String brand;
  final String categoryId;
  final String dollarRate;

  ProductClass({
    required this.id,
    required this.name,
    required this.nameRu,
    required this.code,
    required this.productTypeId,
    required this.countryId,
    required this.brandId,
    required this.measurement,
    required this.price,
    required this.sellPrice,
    required this.discount,
    required this.count,
    required this.guarantee,
    required this.picture,
    required this.description,
    required this.minCount,
    required this.createdAt,
    required this.updatedAt,
    required this.country,
    required this.countryRu,
    required this.brand,
    required this.categoryId,
    required this.dollarRate,
  });

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    return ProductClass(
      id: json['id']??'',
      name: json['name'],
      nameRu: json['name_ru']??'',
      code: json['code']??'',
      productTypeId: json['product_type_id']??'',
      countryId: json['country_id']??'',
      brandId: json['brand_id']??'',
      measurement: json['measurement']??'',
      price: json['price']??'',
      sellPrice: json['sell_price']??'',
      discount: json['discount']??'',
      count: json['count']??'',
      guarantee: json['guarantee']??'',
      picture: json['picture']??'',
      description: json['description']??'',
      minCount: json['min_count']??'',
      createdAt: json['created_at']??'',
      updatedAt: json['updated_at']??'',
      country: json['country']??'',
      countryRu: json['country_ru']??'',
      brand: json['brand']??'',
      categoryId: json['category_id']??'',
      dollarRate: json['dollar_rate']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ru': nameRu,
      'code': code,
      'product_type_id': productTypeId,
      'country_id': countryId,
      'brand_id': brandId,
      'measurement': measurement,
      'price': price,
      'sell_price': sellPrice,
      'discount': discount,
      'count': count,
      'guarantee': guarantee,
      'picture': picture,
      'description': description,
      'min_count': minCount,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country': country,
      'country_ru': countryRu,
      'brand': brand,
      'category_id': categoryId,
      'dollar_rate': dollarRate,
    };
  }
}
