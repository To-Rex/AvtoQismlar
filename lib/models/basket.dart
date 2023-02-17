import 'package:avto_qismlar/models/products.dart';

class BasketClass {
  String client_id;
  List<ProductClass> products = [];

  BasketClass({
    required this.client_id,
    required this.products,
  });

  factory BasketClass.fromJson(Map<String, dynamic> json) {
    return BasketClass(
      client_id: json['client_id'] ?? '',
      products: json['products'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'products': products,
    };
  }

  @override
  String toString() {
    return 'HistoryClass{client_id: $client_id, products: $products}';
  }

  BasketClass copyWith({
    String? id,
    List<ProductClass>? products,
  }) {
    return BasketClass(
      client_id: id ?? client_id,
      products: products ?? this.products,
    );
  }
}
