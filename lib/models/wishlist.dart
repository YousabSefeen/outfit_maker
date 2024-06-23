

import 'package:new_task/models/product.dart';

class Wishlist {
  final String id;
  final List<Product> products;

  Wishlist({
    required this.id,
    required this.products,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      products: (json['products'] as List).map((item) => Product.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
