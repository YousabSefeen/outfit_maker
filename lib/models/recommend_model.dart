

class RecommendModel {
  int? status;
  String? message;
  List<Data>? data;

  RecommendModel({this.status, this.message, this.data});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }


}

class Data {
  String? name;
  int? price;
  String? imageUrl;
  String? id;

  Data({this.name, this.price, this.imageUrl, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }


}