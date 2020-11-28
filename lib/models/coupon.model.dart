import '../father/model.dart';
class Coupon extends Model {

  final int id;
  final String operator;
  final int liters;
  final int amount;
  final int product_id;
  final int vehicle_id;
  final String status;
  final String secret_id;
  final String vehicleImageUrl;
  final String createdAt;
  final String updatedAt;

  Coupon({
    this.id,
    this.operator,
    this.liters,
    this.amount,
    this.product_id,
    this.vehicle_id,
    this.status,
    this.secret_id,
    this.vehicleImageUrl,
    this.createdAt,
    this.updatedAt
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      operator: json['operator'],
      liters: json['liters'],
      amount: json['amount'],
      product_id: json['product_id'],
      vehicle_id: json['vehicle_id'],
      status: json['status'],
      secret_id: json['secret_id'],
      vehicleImageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}