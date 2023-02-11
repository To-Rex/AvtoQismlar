class HistoryClass {
  String id;
  String date;
  String total;
  String status;

  HistoryClass(
      {required this.id,
      required this.date,
      required this.total,
      required this.status});

  factory HistoryClass.fromJson(Map<String, dynamic> json) {
    return HistoryClass(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      total: json['total'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
