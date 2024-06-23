// import 'dart:math';
//
// import '../models/order.dart';
// import '../models/order_details.dart';
// import '../models/product.dart';
// import '../models/wishlist.dart';
//
// class MockData {
//   static final colors = ['orange', 'blue', 'yellow'];
//   static List<Product> mockProducts = List.generate(20, (index) {
//     return Product(
//         id: 'product_id_$index',
//         name: 'Product $index',
//         description: 'Description for product $index',
//         price: (index + 1) * 10.0,
//         size: ['S', 'M', 'L', 'XL'][index % 4],
//         category: ['Men', 'Women', 'Best Seller', 'Feature Products'][index % 4],
//         image: 'assets/logos/${colors[Random().nextInt(colors.length)]}${Random.secure().nextInt(3) + 1}.png' // Example categories
//         );
//   });
//
//   static Wishlist mockWishlist = Wishlist(
//     id: 'wishlist_id_1',
//     products: mockProducts.take(5).toList(),
//   );
//
//   static List<Order> mockOrders = List.generate(5, (index) {
//     return Order(
//       id: 'order_id_$index',
//       userId: 'user_id_1',
//       orderDetails: List.generate(3, (detailIndex) {
//         return OrderDetail(
//           productId: mockProducts[detailIndex].id,
//           quantity: detailIndex + 1,
//           price: mockProducts[detailIndex].price,
//         );
//       }),
//       totalAmount: mockProducts.take(3).map((product) => product.price).reduce((a, b) => a + b),
//     );
//   });
//
//   static Map<String, dynamic> getProductList() {
//     return {
//       'status': 200,
//       'message': 'Success',
//       'data': mockProducts.map((product) => product.toJson()).toList(),
//     };
//   }
//
//   static Map<String, dynamic> getWishlist() {
//     return {
//       'status': 200,
//       'message': 'Success',
//       'data': mockWishlist.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> getOrders() {
//     return {
//       'status': 200,
//       'message': 'Success',
//       'data': mockOrders.map((order) => order.toJson()).toList(),
//     };
//   }
//
//   static Map<String, dynamic> getOrderDetails(String orderId) {
//     final order = mockOrders.firstWhere((order) => order.id == orderId);
//     return {
//       'status': 200,
//       'message': 'Success',
//       'data': order.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> addToWishlist(String productId) {
//     final product = mockProducts.firstWhere((product) => product.id == productId);
//     mockWishlist.products.add(product);
//
//     return {
//       'status': 200,
//       'message': 'Product added to wishlist',
//       'data': mockWishlist.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> removeFromWishlist(String productId) {
//     mockWishlist.products.removeWhere((product) => product.id == productId);
//
//     return {
//       'status': 200,
//       'message': 'Product removed from wishlist',
//       'data': mockWishlist.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> createOrder(String userId, List<OrderDetail> orderDetails) {
//     final double totalAmount = orderDetails.map((detail) => detail.price).reduce((a, b) => a + b);
//     final newOrder = Order(
//       id: 'order_id_${mockOrders.length + 1}',
//       userId: userId,
//       orderDetails: orderDetails,
//       totalAmount: totalAmount,
//     );
//
//     mockOrders.add(newOrder);
//
//     return {
//       'status': 200,
//       'message': 'Order created',
//       'data': newOrder.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> addProductToOrder(String orderId, OrderDetail orderDetail) {
//     final order = mockOrders.firstWhere((order) => order.id == orderId);
//     order.orderDetails.add(orderDetail);
//     order.totalAmount += orderDetail.price;
//
//     return {
//       'status': 200,
//       'message': 'Product added to order',
//       'data': order.toJson(),
//     };
//   }
//
//   static Map<String, dynamic> removeProductFromOrder(String orderId, String productId) {
//     final order = mockOrders.firstWhere((order) => order.id == orderId);
//     final orderDetail = order.orderDetails.firstWhere((detail) => detail.productId == productId);
//     order.orderDetails.remove(orderDetail);
//     order.totalAmount -= orderDetail.price;
//
//     return {
//       'status': 200,
//       'message': 'Product removed from order',
//       'data': order.toJson(),
//     };
//   }
// }
