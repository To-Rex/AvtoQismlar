import 'package:avto_qismlar/models/products.dart';

class HistoryClass {
  String id;
  String date;
  String total;
  String status;
  List<ProductClass> products = [];

  HistoryClass({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.products,
  });

  factory HistoryClass.fromJson(Map<String, dynamic> json) {
    return HistoryClass(
      id: json['id']??'',
      date: json['date']??'',
      total: json['total']??'',
      status: json['status']??'',
      products: json['products']??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'total': total,
      'status': status,
      'products': products,
    };
  }

  @override
  String toString() {
    return 'HistoryClass{id: $id, date: $date, total: $total, status: $status, products: $products}';
  }

  HistoryClass copyWith({
    String? id,
    String? date,
    String? total,
    String? status,
    List<ProductClass>? products,
  }) {
    return HistoryClass(
      id: id ?? this.id,
      date: date ?? this.date,
      total: total ?? this.total,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

}
