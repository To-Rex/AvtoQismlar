import 'package:avto_qismlar/models/products.dart';

class HistoryClass {
  String id;
  String date;
  String total;
  String status;
  List<ProductClass> products;

  HistoryClass(
      {required this.id,
      required this.date,
      required this.total,
      required this.status,
      required this.products});

factory HistoryClass.fromJson(Map<String, dynamic> json) {
    return HistoryClass(
      id: json['id'],
      date: json['date'],
      total: json['total'],
      status: json['status'],
      products: List<ProductClass>.from(json['products'].map((x) => ProductClass.fromJson(x))),
    );
  }
}

