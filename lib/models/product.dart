class Product {
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final String? size;
  final String? category;
  final String? image; // New property
  final double? rate;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
    required this.category,
    required this.image, // New property
    required this.rate,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    print(json['imageUrl']);
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      size: json['size'],
      category: json['category'],
      rate: json['rate'],
      image:
          'https://lemur-glorious-neatly.ngrok-free.app/images/${json['imageUrl']}',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'size': size,
      'category': category,
      'rate': rate,
      'image': image // New property
    };
  }
}
