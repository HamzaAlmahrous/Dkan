import 'package:dkan/models/product_model.dart';

class CategoryDetail {
  bool? status;
  late Data data;


  CategoryDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  late List<Product> productData;


  Data.fromJson(Map<String, dynamic> json) {
    productData = [];
    json['data'].forEach((element) {
      productData.add(Product.fromJson(element));
      });
  }
}
