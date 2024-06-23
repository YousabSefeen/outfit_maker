class OrderDetail {
  final String productId;
  final int quantity;
  final double price;

  OrderDetail({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
