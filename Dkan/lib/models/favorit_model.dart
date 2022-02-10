import 'package:dkan/models/product_model.dart';

class FavoritesModel {
  late bool status;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  late List<FavoritesData> data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      data =  [];
      json['data'].forEach((element){data.add(FavoritesData.fromJson(element));});
    }
}

class FavoritesData {
  int? id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class FavoriteProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}