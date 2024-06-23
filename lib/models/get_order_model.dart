

class GetOrderModel {
  final String  id;
  final String  orderNumber;
  final int  total;
  final int  status;
  final String  date;
  final String  imageUrl;

  final String  name;
  GetOrderModel({
    required this.id,
    required this.orderNumber,
    required this.total,
    required this.status,
    required this.date,
    required this.imageUrl,
    required this.name,

  });
  factory GetOrderModel.fromJson(Map<String, dynamic> json) {

    return GetOrderModel(
      id: json['id'],

      orderNumber: json['orderNumber'],
      total: json['total'],
      status: json['status'],
      date: json['date'],
      name: json['name'],
      imageUrl:
      'https://lemur-glorious-neatly.ngrok-free.app/images/${json['imageUrl']}',
    );
  }

}
