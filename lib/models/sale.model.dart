class Sale {

  final int id;
  final String volumetricControl;
  final int stationId;
  final int sellerId;
  final int couponId;
  final int priceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Sale({
        this.id,
        this.volumetricControl,
        this.stationId,
        this.sellerId,
        this.couponId,
        this.priceId,
        this.createdAt,
        this.updatedAt
      });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      volumetricControl: json['volumetric_control'],
      stationId: json['station_id'],
      sellerId: json['seller_id'],
      couponId: json['coupon_id'],
      priceId: json['price_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}