class CashRegisterModel {
  final int id;
  final int locationId;
  final String status;
  final String createdAt;

  CashRegisterModel({
    required this.id,
    required this.locationId,
    required this.status,
    required this.createdAt,
  });

  factory CashRegisterModel.fromJson(Map<String, dynamic> json) {
    return CashRegisterModel(
      id: json['id'],
      locationId: json['location_id'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}