class OrderDetailsModel {
  int? status;
  String? message;
  OrderData? data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }
}

class OrderData {
  int? total;
  List<Data>? data;

  OrderData({this.total, this.data});

  OrderData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? productImg;
  String? productName;
  int? productPrice;
  int? quentity;

  Data({this.productImg, this.productName, this.productPrice, this.quentity});

  Data.fromJson(Map<String, dynamic> json) {
  //  productImg = json['productImg'];
    productImg = 'https://lemur-glorious-neatly.ngrok-free.app/images/${json['productImg']}';
    productName = json['productName'];
    productPrice = json['productPrice'];
    quentity = json['quentity'];
  }
}