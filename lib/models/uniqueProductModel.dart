class UniqueProductModel {
  final String productId;
  final int price;
  final String name;
  final String imageUrl;

  UniqueProductModel(
      {required this.productId,
      required this.price,
      required this.name,
      required this.imageUrl});

  factory UniqueProductModel.fromJson(Map<String, dynamic> json) {
    return UniqueProductModel(
      productId: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl:
          'https://lemur-glorious-neatly.ngrok-free.app/images/${json['imageUrl']}',
    );
  }


}
