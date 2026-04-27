class PlaceOrderModel {
  final int? id;
  final String? status;
  final double? finalTotal;

  PlaceOrderModel({
    this.id,
    this.status,
    this.finalTotal,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      id: json['id'],
      status: json['status'],
      finalTotal: (json['final_total'] ?? 0).toDouble(),
    );
  }
}