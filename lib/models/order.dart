import 'order_details.dart';

class Order {
  final String id;
  final String userId;
  final List<OrderDetail> orderDetails;
  double totalAmount;

  Order({
    required this.id,
    required this.userId,
    required this.orderDetails,
    required this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      orderDetails: (json['orderDetails'] as List).map((item) => OrderDetail.fromJson(item)).toList(),
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orderDetails': orderDetails.map((detail) => detail.toJson()).toList(),
      'totalAmount': totalAmount,
    };
  }
}
